
CREATE DATABASE IF NOT EXISTS OLAP;
use OLAP;


CREATE TABLE IF NOT EXISTS Fact_Loan_Approval(
   LoanId VARCHAR(100) not NULL primary key,
   AppliedAmount float NOT NULL,
   Amount float not null,
    Interest decimal(10,2) not null,
    MonthlyPayment float default null,
	LoanDate date not null,
    Duration int not null,
    PartyId varchar(100) default null,
    VerificationType varchar(50) DEFAULT NULL,
    Rating varchar(20) default null,
    CreditCustomer varchar(50) DEFAULT NULL,
     IncomeCategory  VARCHAR(50) default null,
       IncomeTotal float default null,
     CreditScore varchar(50) default null,
	Age int DEFAULT NULL,
    Gender varchar(20) DEFAULT NULL,
    Country varchar(20) DEFAULT NULL,
    Education varchar(50) DEFAULT NULL,
    EmploymentDuration varchar(100) DEFAULT NULL,
    HomeType varchar(100) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS Fact_Payment(
   LoanId VARCHAR(100) not NULL primary key,
	PrincipalPaymentsMade float default null,
    InterestAndPenaltyPaymentsMade float default null,
    PrincipalWriteOffs float default null,
    InterestAndPenaltyWriteOffs float default null,
    PrincipalBalance float default null,
    PrincipalOverdueBySchedule float default null,
    PaymentDeferral int default null,
	CurrentDebtDaysPrimary int default null,
    CurrentDebtDaysSecondary int default null,
     ExpectedLoss float default null,
    LossGivenDefault float default null,
    ExpectedReturn float default null,
    ProbabilityOfDefault float default null,
    LastPaymentdays int default null,
	LoanDate date not null,
    Duration int not null,
    StatusLoan varchar(20) not null,
    DefaultStatus varchar(20) default null,
    Restructured varchar(20) default null,
    WorseLateCategory varchar(50) default null,
    Rating varchar(20) default null,
    ActiveFirstPayment varchar(20) default null,
    PartyId varchar(100) default null,
    RecoveryStage int(10) default null,
    CreditCustomer varchar(50) DEFAULT NULL,
     IncomeCategory  VARCHAR(50) default null,
     CreditScore varchar(50) default null,
	Age int(10) DEFAULT NULL,
    Gender varchar(20) DEFAULT NULL,
    Country varchar(20) DEFAULT NULL,
    Education varchar(50) DEFAULT NULL,
    EmploymentDuration varchar(100) DEFAULT NULL,
    HomeType varchar(100) DEFAULT NULL
);

drop table Fact_Recovery;
CREATE TABLE IF NOT EXISTS Fact_Recovery(
	LoanId VARCHAR(100) not NULL primary key,
	DefaultDate date default null,
    PlannedPrincipalPostDefault  float default null,
    PlannedInterestPostDefault float default null,
    EAD1 float default null,
    EAD2  float default null,
	PrincipalRecovery  float default null,
    InterestRecovery   float default null,
    DebtRecoveryRate decimal(10,2) default null,
    ExpectedLossAmount  decimal(10,2) default null,
    RecoveryStage int(10) default null,
    LoanDate date not null,
    LoanDuration int(20) not null,
    StatusLoan varchar(20) not null,
    Restructured varchar(20) default null,
    WorseLateCategory varchar(50) default null,
    Rating varchar(20) default null,
    ActiveFirstPayment varchar(20) default NULL,
     CreditCustomer varchar(50) DEFAULT NULL,
     IncomeCategory  VARCHAR(50) default null,
     CreditScore varchar(50) default null,
     PartyId varchar(100) default null,
     Age int(10) DEFAULT NULL,
    Gender varchar(20) DEFAULT NULL,
    Country varchar(20) DEFAULT NULL,
    Education varchar(50) DEFAULT NULL,
    EmploymentDuration varchar(100) DEFAULT NULL,
    HomeType varchar(100) DEFAULT NULL
);



CREATE TABLE IF  NOT EXISTS Dim_Borrower_account(
	PartyId varchar(100) NOT NULL primary key
);

-- Dim Age
CREATE TABLE IF NOT EXISTS Dim_Age(
   Age int(10) NOT  NULL primary key,
   Age_Category VARCHAR(50) DEFAULT NULL
);
-- Dim Gender
CREATE TABLE IF NOT EXISTS Dim_Gender(
 Gender_ID int(10) AUTO_INCREMENT Not null  primary key,
 Gender varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim Country
CREATE TABLE IF NOT EXISTS Dim_Country(
 Country_ID int AUTO_INCREMENT Not null  primary key,
 Country varchar(20) DEFAULT NULL,
 LanguageCode varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim Education
CREATE TABLE IF NOT EXISTS Dim_Education(
 Education_ID int AUTO_INCREMENT Not null  primary key,
 Education varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim  EmploymentDuration 
CREATE TABLE IF NOT EXISTS Dim_Employment_Duration(
  Employment_ID int AUTO_INCREMENT Not null  primary key,
  EmploymentDuration varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim HomeType
CREATE TABLE IF NOT EXISTS Dim_Home_Type(
  HomeType_ID int AUTO_INCREMENT Not null  primary key,
 HHomeOwnershipType varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim VerificationType
CREATE TABLE IF NOT EXISTS Dim_Verification_Type(
  VerificationType_ID int AUTO_INCREMENT Not null  primary key,
  VerificationType varchar(50) DEFAULT NULL 
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim  CreditCustomer
CREATE TABLE IF NOT EXISTS Dim_Credit_Customer(
  CreditCustomer_ID int AUTO_INCREMENT Not null  primary key,
  CreditCustomer varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim Total Imcome
CREATE TABLE IF NOT EXISTS Dim_Income(
  Income_ID int AUTO_INCREMENT Not null  primary key,
  IncomeCategory  VARCHAR(50) default null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim ScoreCredit 
CREATE TABLE IF NOT EXISTS Dim_Credit_Score(
  Scorecredit_ID int AUTO_INCREMENT Not null  primary key,
 CreditScore varchar(50) default null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim Date
CREATE TABLE IF NOT EXISTS Dim_Date(
  LoanDate date not null  primary key,
  Day  int(10) default null,
  Month int(10) default null,
  Year int(10) default null  
);
-- Dim Loan Duration 
CREATE TABLE IF NOT EXISTS Dim_Loan_Duration(
  LoanDuration int Not null  primary key,
  Duration_Term VARCHAR(50) default null
);
-- Dim LoanSatus 
CREATE TABLE IF NOT EXISTS Dim_Status(
  Status_ID int AUTO_INCREMENT Not null  primary key,
  StatusLoan varchar(20) not null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim Restructured 
CREATE TABLE IF NOT EXISTS Dim_Restructured(
  Restructured_ID int AUTO_INCREMENT Not null  primary key,
   Restructured varchar(20) default null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim Rating 
CREATE TABLE IF NOT EXISTS Dim_Rating(
  Rating_ID int AUTO_INCREMENT Not null  primary key,
   Rating varchar(20) default null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim WorseLateCategory
CREATE TABLE IF NOT EXISTS Dim_Worse_Late_Category(
   WorseLate_ID int AUTO_INCREMENT Not null  primary key,
   WorseLateCategory varchar(50) default null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

 -- Dim ActiveFirstPayment
 CREATE TABLE IF NOT EXISTS Dim_Active_First_Payment(
   ActiveFirst_ID int AUTO_INCREMENT Not null  primary key,
   ActiveFirstPayment varchar(20) default null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dim Recovery State 
CREATE TABLE IF NOT EXISTS Dim_Recovery_Stage(
   RecoveryStage int not null primary key   
);
-- Dim DefaultStatus
CREATE TABLE IF NOT EXISTS Dim_Default_Status(
   Default_ID int AUTO_INCREMENT Not null  primary key,
   DefaultStatus varchar(50) default null
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT
CHARSET=utf8 COLLATE=utf8_unicode_ci;



ALTER TABLE Fact_Loan
    DROP FOREIGN KEY fact_loan_ibfk_1;
-- Đặt khóa ngoại cho bảng Fact_Loan

ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (VerificationType) REFERENCES Dim_Verification_Type(VerificationType);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (CreditCustomer) REFERENCES Dim_Credit_Customer(CreditCustomer);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (IncomeCategory) REFERENCES Dim_Income(IncomeCategory);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (CreditScore) REFERENCES Dim_Credit_Score(CreditScore);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (Age) REFERENCES Dim_Age(Age);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (Gender) REFERENCES Dim_Gender(Gender);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (Country) REFERENCES Dim_Country(Country);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (Education) REFERENCES Dim_Education(Education);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (EmploymentDuration) REFERENCES Dim_Employment_Duration(EmploymentDuration);
ALTER TABLE Fact_Loan_Approval ADD FOREIGN KEY (HomeType) REFERENCES Dim_Home_Type(HHomeOwnershipType);


-- Đặt khóa ngoại chô bảng Repayment
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (DefaultStatus) REFERENCES Dim_Default_Status(DefaultStatus);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (LoanDate) REFERENCES Dim_Date(LoanDate);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (Duration) REFERENCES Dim_Loan_Duration(LoanDuration);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (StatusLoan) REFERENCES  Dim_Status(StatusLoan);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (Restructured) REFERENCES Dim_Restructured(Restructured);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (WorseLateCategory) REFERENCES Dim_Worse_Late_Category(WorseLateCategory);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (ActiveFirstPayment) REFERENCES Dim_Active_First_Payment(ActiveFirstPayment);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (RecoveryStage) REFERENCES Dim_Recovery_Stage(RecoveryStage);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (Rating) REFERENCES Dim_Rating(Rating);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (Age) REFERENCES Dim_Age(Age);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (Gender) REFERENCES Dim_Gender(Gender);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (Country) REFERENCES Dim_Country(Country);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (Education) REFERENCES Dim_Education(Education);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (EmploymentDuration) REFERENCES Dim_Employment_Duration(EmploymentDuration);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (HomeType) REFERENCES Dim_Home_Type(HHomeOwnershipType);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (IncomeCategory) REFERENCES Dim_Income(IncomeCategory);
ALTER TABLE Fact_Repayment ADD FOREIGN KEY (CreditCustomer) REFERENCES Dim_Credit_Customer(CreditCustomer);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (CreditScore) REFERENCES Dim_Credit_Score(CreditScore);
-- Đặt khóa ngoại cho bảng Recovery 
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (LoanDate) REFERENCES Dim_Date(LoanDate);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (LoanDuration) REFERENCES Dim_Loan_Duration(LoanDuration);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (StatusLoan) REFERENCES  Dim_Status(StatusLoan);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (Restructured) REFERENCES Dim_Restructured(Restructured);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (WorseLateCategory) REFERENCES Dim_Worse_Late_Category(WorseLateCategory);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (ActiveFirstPayment) REFERENCES Dim_Active_First_Payment(ActiveFirstPayment);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (RecoveryStage) REFERENCES Dim_Recovery_Stage(RecoveryStage);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (Rating) REFERENCES Dim_Rating(Rating);
ALTER TABLE Fact_Recovery ADD FOREIGN KEY (CreditScore) REFERENCES Dim_Credit_Score(CreditScore);
