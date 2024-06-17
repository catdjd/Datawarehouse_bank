drop database oltp;
CREATE DATABASE IF NOT EXISTS  oltp;
use oltp;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE IF NOT EXISTS oltp.Borrower_Account(
    PartyId varchar(100) NOT NULL primary key
);

CREATE TABLE IF NOT EXISTS oltp.Loan_Application(
    LoanNumber float NOT NULL primary key,
    PartyId varchar(100) NOT NULL,
    LoanApplicationStartedDate date NOT NULL,
    AppliedAmount float NOT NULL,
    ApplicationSignedHour int DEFAULT NULL,
    ApplicationSignedWeekend int DEFAULT NULL,
    VerificationType varchar(50) DEFAULT NULL 
);


CREATE TABLE IF NOT EXISTS oltp.Borrower(
    BorrowerID  int NOT NULL primary key,
    LoanNumber float default NULL,
    Age int DEFAULT NULL,
    Gender varchar(20) DEFAULT NULL,
    Country varchar(20) DEFAULT NULL,
    LanguageCode varchar(50) DEFAULT NULL,
    Education varchar(50) DEFAULT NULL,
    EmploymentDuration varchar(100) DEFAULT NULL,
    HomeOwnershipType varchar(100) DEFAULT NULL
);


CREATE TABLE IF NOT EXISTS oltp.Loan(
    LoanId VARCHAR(100) not NULL primary key,
    LoanNumber float not NULL,
    LoanDate date not null,
    Amount float not null,
    LoanDuration int not null,
    Interest decimal(10,2) not null,
    MonthlyPayment float DEFAULT null,
    MonthlyPaymentDay  float default null,
    MaturityDate_Original date default null,
    MaturityDate_Last date  default null,
    StatusLoan varchar(20) not null,
    Restructured varchar(20) default null,
    WorseLateCategory varchar(50) default null,
    Rating varchar(20) default null,
    RecoveryStage int default null,
    DefaultStatus varchar(20) default null,
    ExpectedLoss float default null,
    LossGivenDefault float default null,
    ExpectedReturn float default null,
    ProbabilityOfDefault float default null
);

 
 
CREATE TABLE IF NOT EXISTS oltp.Borrower_credit(
    CreditID int not null primary key,
    LoanNumber float default NULL,
	CreditCustomer varchar(50) DEFAULT NULL,
    IncomeTotal float default null,
    ExistingLiabilities int default null,
    LiabilitiesTotal float default null,
    RefinanceLiabilities int default null,
    NoOfPreviousLoansBeforeLoan int default null,
    AmountOfPreviousLoansBeforeLoan float default null,
    PreviousRepaymentsBeforeLoan float default null,
    PreviousEarlyRepaymentsCountBeforeLoan int default null,
    CreditScore varchar(50) default null
	
);

CREATE TABLE IF NOT EXISTS oltp.Loan_detail(
    Loan_detailID int not null primary key,
    LoanId varchar(100) not null,
    FirstPaymentDate date default null,
    ActiveScheduleFirstPaymentReached varchar(20) default null,
    LastPaymentOn  date default null,
    CurrentDebtDaysPrimary int default null,
    DebtOccuredOn date default null,
    CurrentDebtDaysSecondary int default null,
    DebtOccuredOnForSecondary date default null,
    PrincipalOverdueBySchedule float default null,
    PrincipalPaymentsMade float default null,
    InterestAndPenaltyPaymentsMade float default null,
    PrincipalWriteOffs float default null,
    InterestAndPenaltyWriteOffs float default null,
    PrincipalBalance float default null,
    InterestAndPenaltyBalance float default null,
    GracePeriodStart date default null,
    GracePeriodEnd date default null
  
);

CREATE TABLE IF NOT EXISTS oltp.Recovery(
    RecoveryID int not null primary key,
    LoanId varchar(100) not null,
    DefaultDate date default null,
    PlannedPrincipalPostDefault  float default null,
    PlannedInterestPostDefault float default null,
    EAD1 float default null,
    EAD2  float default null,
    PrincipalRecovery  float default null,
    InterestRecovery   float default null

);

CREATE TABLE IF NOT EXISTS oltp.Loan_Bidding(
    BiddingID int not null primary key,
    LoanId varchar(100) not null,
    BiddingStartedOn date default null,
    BidsPortfolioManager int default null,
    BidsApi int default null,
    BidsManual int default null
);
ALTER TABLE loan_application ADD CONSTRAINT fk_acount_loan_application FOREIGN KEY (PartyId) REFERENCES Borrower_Account(PartyId);
ALTER TABLE Borrower_credit add Constraint fk_loan_app_2 foreign key (LoanNumber) references Loan_Application(LoanNumber) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Borrower add Constraint fk_loan_app foreign key (LoanNumber) references Loan_Application(LoanNumber) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Loan  add Constraint fk_loan_app_3 foreign key (LoanNumber) references Loan_Application(LoanNumber) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Loan_Bidding ADD Constraint fk_loan_bidding foreign key (LoanId) references Loan(LoanId) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Recovery add Constraint fk_recovery foreign key (LoanId) references Loan(LoanId) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Loan_detail add Constraint fk_loan_detail foreign key (LoanId) references Loan(LoanId) ON DELETE CASCADE ON UPDATE CASCADE;


INSERT INTO oltp.Borrower_Account (PartyId)
SELECT DISTINCT PartyId
FROM oltp.Loan_Application;

