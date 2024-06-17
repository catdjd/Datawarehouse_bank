-- Tạo thủ tục đổ dữ liệu từ OLTP sang OLAP
Use olap;

-- Đổ bảng fact_Loan
DROP PROCEDURE IF EXISTS oltp_to_olap_fact_loan;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_fact_loan()
BEGIN
	INSERT IGNORE INTO Fact_Loan_Approval(LoanId,AppliedAmount, Amount,Interest,MonthlyPayment, LoanDate, Duration,
    PartyId, VerificationType, Rating, CreditCustomer,IncomeTotal, IncomeCategory, CreditScore, Age , Gender, Country , Education, EmploymentDuration,
    HomeType)
    SELECT 
         `lo`.`LoanID` AS `LoanID`,
		  `app`.`AppliedAmount` AS `AppliedAmount`,`lo`.`Amount` AS `Amount`,`lo`.`Interest` AS `Interest`,`lo`.`MonthlyPayment` AS `MonthlyPayment`,`lo`.`LoanDate` AS `LoanDate`,`lo`.`LoanDuration` AS `Duration`,`acc`.`PartyId` AS `PartyId`,`app`.`VerificationType` AS `VerificationType`,`lo`.`Rating` AS `Rating`,
          `ass`.`CreditCustomer` AS `CreditCustomer`, `ass`.`IncomeTotal` AS `IncomeTotal`, `ass`.`Income_Category` AS `IncomeCategory`, `ass`.`CreditScore` AS `CreditScore`, `bo`.`Age` AS `Age`,
          `bo`.`Gender` AS `Gender`,`bo`.`Country` AS `Country`,`bo`.`Education` AS `Education`,`bo`.`EmploymentDuration` AS `EmploymentDuration`,`bo`.`HomeOwnershipType` AS `HomeType`
    FROM
       oltp.loan AS lo
        INNER JOIN oltp.loan_application AS app ON lo.LoanNumber = app.LoanNumber
        INNER JOIN oltp.borrower_account AS acc ON app.PartyId = acc.PartyId
		INNER JOIN oltp.borrower_credit AS ass ON  app.LoanNumber = ass.LoanNumber
		INNER JOIN oltp.borrower AS bo ON app.LoanNumber = bo.LoanNumber;
END $$
DELIMITER ;
CALL oltp_to_olap_fact_loan();

-- Bảng Fact_Payment
DROP PROCEDURE IF EXISTS oltp_to_olap_fact_payment;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_fact_payment()
BEGIN
	INSERT IGNORE INTO Fact_Payment (LoanId,PrincipalPaymentsMade, InterestAndPenaltyPaymentsMade,
    PrincipalWriteOffs, InterestAndPenaltyWriteOffs, PrincipalBalance,PrincipalOverdueBySchedule ,PaymentDeferral,CurrentDebtDaysPrimary, CurrentDebtDaysSecondary,ExpectedLoss, LossGivenDefault,
    ExpectedReturn,ProbabilityOfDefault,LastPaymentdays, LoanDate, Duration, StatusLoan,DefaultStatus, Restructured,
    WorseLateCategory, Rating, ActiveFirstPayment,PartyId,RecoveryStage, 
    CreditCustomer,  IncomeCategory, CreditScore, Age , Gender, Country , Education, EmploymentDuration,
    HomeType)
    SELECT 
         `lo`.`LoanID` AS `LoanID`,`del`.`PrincipalPaymentsMade` AS `PrincipalPaymentsMade`,`del`.`InterestAndPenaltyPaymentsMade` AS `InterestAndPenaltyPaymentsMade`,`del`.`PrincipalWriteOffs` AS `PrincipalWriteOffs`,
          `del`.`InterestAndPenaltyWriteOffs` AS `InterestAndPenaltyWriteOffs`,`del`.`PrincipalBalance` AS `PrincipalBalance`,`del`.`PrincipalOverdueBySchedule` AS `PrincipalOverdueBySchedule`,`lo`.`PaymentDeferral` AS `PaymentDeferral`,`del`.`CurrentDebtDaysPrimary` AS `CurrentDebtDaysPrimary`,`del`.`CurrentDebtDaysSecondary` AS `CurrentDebtDaysSecondary`,`lo`.`ExpectedLoss` AS `ExpectedLoss`,`lo`.`LossGivenDefault` AS `LossGivenDefault`,`lo`.`ExpectedReturn` AS `ExpectedReturn`,
          `lo`.`ProbabilityOfDefault` AS `ProbabilityOfDefault`,`del`.`LastPaymentdays` AS `LastPaymentdays`,`lo`.`LoanDate` AS `LoanDate`,
          `lo`.`LoanDuration` AS `Duration`,`lo`.`StatusLoan` AS `StatusLoan`,`lo`.`DefaultStatus` AS `DefaultStatus`,`lo`.`Restructured` AS `Restructured`,`lo`.`WorseLateCategory` AS `WorseLateCategory`,`lo`.`Rating` AS `Rating`,`del`.`ActiveScheduleFirstPaymentReached` AS `ActiveFirstPayment`, 
         `acc`.`PartyId` AS `PartyId`,`lo`.`RecoveryStage` AS `RecoveryStage`,
          `ass`.`CreditCustomer` AS `CreditCustomer`, `ass`.`Income_Category` AS `IncomeCategory`, `ass`.`CreditScore` AS `CreditScore`, `bo`.`Age` AS `Age`,
          `bo`.`Gender` AS `Gender`,`bo`.`Country` AS `Country`,`bo`.`Education` AS `Education`,`bo`.`EmploymentDuration` AS `EmploymentDuration`,`bo`.`HomeOwnershipType` AS `HomeType`
         
    FROM
       oltp.loan AS lo
		INNER JOIN oltp.loan_detail AS del ON lo.LoanId = del.LoanId
        INNER JOIN oltp.loan_application AS app ON lo.LoanNumber = app.LoanNumber
        INNER JOIN oltp.borrower_account AS acc ON app.PartyId = acc.PartyId
		INNER JOIN oltp.borrower_credit AS ass ON  app.LoanNumber = ass.LoanNumber
		INNER JOIN oltp.borrower AS bo ON app.LoanNumber = bo.LoanNumber;
END $$
DELIMITER ;
CALL oltp_to_olap_fact_payment();

-- Bảng fact_Recovery 
DROP PROCEDURE IF EXISTS oltp_to_olap_fact_recovery;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_fact_recovery()
BEGIN
	INSERT IGNORE INTO Fact_Recovery(LoanId,DefaultDate,PlannedPrincipalPostDefault,PlannedInterestPostDefault,EAD1,EAD2 ,PrincipalRecovery,InterestRecovery,DebtRecoveryRate ,
    ExpectedLossAmount,RecoveryStage, LoanDate, LoanDuration, StatusLoan, Restructured,
    WorseLateCategory, Rating, ActiveFirstPayment, CreditCustomer,  IncomeCategory, CreditScore, PartyId,Age , Gender, Country , Education, EmploymentDuration,
    HomeType)
    SELECT 
         `lo`.`LoanID` AS `LoanID`,
		 `re`.`DefaultDate` AS `DefaultDate`,`re`.`PlannedPrincipalPostDefault` AS `PlannedPrincipalPostDefault`,`re`.`PlannedInterestPostDefault` AS `PlannedInterestPostDefault`,`re`.`EAD1` AS `EAD1`,`re`.`EAD2` AS `EAD2`,
          `re`.`PrincipalRecovery` AS `PrincipalRecovery`,`re`.`InterestRecovery` AS `InterestRecovery`,`re`.`DebtRecoveryRate` AS `DebtRecoveryRate`,`re`.`ExpectedLossAmount` AS `ExpectedLossAmount`,`lo`.`RecoveryStage` AS `RecoveryStage`,`lo`.`LoanDate` AS `LoanDate`,
          `lo`.`LoanDuration` AS `LoanDuration`,`lo`.`StatusLoan` AS `StatusLoan`,`lo`.`Restructured` AS `Restructured`,`lo`.`WorseLateCategory` AS `WorseLateCategory`,`lo`.`Rating` AS `Rating`,`del`.`ActiveScheduleFirstPaymentReached` AS `ActiveFirstPayment`,   `ass`.`CreditCustomer` AS `CreditCustomer`, `ass`.`Income_Category` AS `IncomeCategory`,
          `ass`.`CreditScore` AS `CreditScore`, `acc`.`PartyId` AS `PartyId`,`bo`.`Age` AS `Age`,
          `bo`.`Gender` AS `Gender`,`bo`.`Country` AS `Country`,`bo`.`Education` AS `Education`,`bo`.`EmploymentDuration` AS `EmploymentDuration`,`bo`.`HomeOwnershipType` AS `HomeType`
         
    FROM
        oltp.loan AS lo
		INNER JOIN oltp.loan_detail AS del ON lo.LoanId = del.LoanId
        INNER JOIN oltp.recovery AS re ON lo.LoanId = re.LoanId
        INNER JOIN oltp.loan_application AS app ON lo.LoanNumber = app.LoanNumber
        INNER JOIN oltp.borrower_account AS acc ON app.PartyId = acc.PartyId
		INNER JOIN oltp.borrower_credit AS ass ON  app.LoanNumber = ass.LoanNumber
		INNER JOIN oltp.borrower AS bo ON app.LoanNumber = bo.LoanNumber;
END $$
DELIMITER ;
CALL oltp_to_olap_fact_recovery();

-- Bảng Dim_Borrower_Account
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_borrower_account;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_borrower_account()
BEGIN
	INSERT IGNORE INTO Dim_Borrower_Account(PartyID)
    SELECT 
            `oltp`.`borrower_account`.`PartyId` AS `PartyId`
    FROM
		  oltp.borrower_account;		
END $$
DELIMITER ;
CALL oltp_to_olap_dim_borrower_account();

-- bảng Dim Age
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_age;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_age ()
 BEGIN
	INSERT IGNORE INTO Dim_Age( Age, Age_Category)
    SELECT 
        `oltp`.`borrower`.`Age` AS `Age`,
        `oltp`.`borrower`.`Age_Category` AS `Age_Category`
    FROM
        `oltp`.`borrower`;
END $$
DELIMITER ;
Call oltp_to_olap_dim_age ();

-- bảng Dim Gender
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_gender;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_gender()
BEGIN
	INSERT IGNORE INTO Dim_Gender (Gender)
    SELECT DISTINCT
        `oltp`.`borrower`.`Gender` AS `Gender`
    FROM
        `oltp`.`borrower` ;
END $$
DELIMITER ;
CALL oltp_to_olap_dim_gender();

-- Bảng Dim Country
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_country;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_country()
BEGIN
    INSERT IGNORE INTO Dim_Country (Country,LanguageCode )
    SELECT DISTINCT
        `oltp`.`borrower`.`Country` AS `Country`,
        `oltp`.`borrower`.`LanguageCode` AS `LanguageCode`
    FROM
        `oltp`.`borrower` ;
END$$
DELIMITER ;
CALL oltp_to_olap_dim_country();

-- Dim education
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_education;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_education ()
 BEGIN
	INSERT IGNORE Dim_Education( Education )
    SELECT DISTINCT
        `oltp`.`borrower`.`Education` AS `Education`
    FROM
        `oltp`.`borrower` ;
END $$
DELIMITER ;
CALL  oltp_to_olap_dim_education ();

-- Dim Employment duration 
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_employment_duration;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_employment_duration()
 BEGIN
	INSERT IGNORE Dim_Employment_Duration(EmploymentDuration)
    SELECT DISTINCT
     `oltp`.`borrower`.`EmploymentDuration` AS `EmploymentDuration`
    FROM
        `oltp`.`borrower` ;
END$$
DELIMITER ;
CALL oltp_to_olap_dim_employment_duration();

-- Dim hometype
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_home_type;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_home_type()
 BEGIN
	INSERT IGNORE Dim_Home_Type(HHomeOwnershipType )
    SELECT DISTINCT
       `oltp`.`borrower`.`HomeOwnershipType` AS `HHomeOwnershipType`
    FROM
        `oltp`.`borrower` ;
END$$
DELIMITER ;
CALL oltp_to_olap_dim_home_type();

-- Dim Dim_Verification_Type
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_verification_type;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_verification_type ()
 BEGIN
	INSERT IGNORE Dim_Verification_Type(VerificationType)
    SELECT DISTINCT
        `oltp`.`loan_application`.`VerificationType` AS `VerificationType`
    FROM
        `oltp`.`loan_application` ;
END $$
DELIMITER ;
CALL oltp_to_olap_dim_verification_type ();

-- Dim Credit Custotmer 
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_credit_customer;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_credit_customer()
 BEGIN
	INSERT IGNORE  Dim_Credit_Customer(CreditCustomer)
    SELECT DISTINCT
        `oltp`.`borrower_credit`.`CreditCustomer` AS `CreditCustomer`
    FROM
        `oltp`.`borrower_credit` ;
END $$
DELIMITER ;
CALL oltp_to_olap_dim_credit_customer();

-- Dim Income
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_income;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_income()
 BEGIN
	INSERT IGNORE  Dim_Income(IncomeCategory)
    SELECT DISTINCT
        `oltp`.`borrower_credit`.`Income_Category` AS `IncomeCategory`
    FROM
        `oltp`.`borrower_credit` ;
END$$
DELIMITER ;
CALL oltp_to_olap_dim_income();

-- Dim Dim_Credit_Score
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_credit_score;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_credit_score()
 BEGIN
	INSERT IGNORE  Dim_Credit_Score(CreditScore)
    SELECT DISTINCT
        `oltp`.`borrower_credit`.`CreditScore` AS `CreditScore`
    FROM
        `oltp`.`borrower_credit`;
END $$
DELIMITER ;
CALL oltp_to_olap_dim_credit_score();

-- Dim Date
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_date;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_date () 
BEGIN
	INSERT IGNORE Dim_Date( LoanDate, Day, Month, Year ) 
    SELECT 
        `oltp`.`loan`.`LoanDate` AS `LoanDate`,
        DAYOFMONTH(`oltp`.`loan`.`LoanDate`) AS `Day`,
        MONTH(`oltp`.`loan`.`LoanDate`) AS `Month`,
        YEAR(`oltp`.`loan`.`LoanDate`) AS `Year`
    FROM
        `oltp`.`loan`;
END$$
DELIMITER ;
CALL oltp_to_olap_dim_date ();

-- Dim Loan Duration
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_loan_duration;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_loan_duration()
 BEGIN
	INSERT IGNORE  Dim_Loan_Duration(LoanDuration, Duration_Term)
    SELECT 
        `oltp`.`loan`.`LoanDuration` AS `LoanDuration`,
        `oltp`.`loan`.`Duration_Term` AS `Duration_Term`
    FROM
        `oltp`.`loan` ;
END $$
DELIMITER ;
CALL oltp_to_olap_dim_loan_duration();

-- Dim Status
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_status;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_status()
 BEGIN
	INSERT IGNORE  Dim_Status(StatusLoan)
    SELECT DISTINCT
        `oltp`.`loan`.`StatusLoan` AS `StatusLoan`
    FROM
        `oltp`.`loan` ;
END  $$
DELIMITER ;
CALL oltp_to_olap_dim_status();

-- Dim defaultstatus
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_default_status;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_default_status()
 BEGIN
	INSERT IGNORE  Dim_Default_Status(DefaultStatus )
    SELECT DISTINCT
        `oltp`.`loan`.`DefaultStatus` AS `DefaultStatus`
    FROM
        `oltp`.`loan` ;
END  $$
DELIMITER ;
CALL oltp_to_olap_dim_default_status();

-- Dim Restructured 
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_restructured ;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_restructured ()
 BEGIN
	INSERT IGNORE  Dim_Restructured(Restructured )
    SELECT DISTINCT
        `oltp`.`loan`.`Restructured` AS `Restructured`
    FROM
        `oltp`.`loan` ;
END $$ 
DELIMITER ;
CALL oltp_to_olap_dim_restructured ();


-- Dim_Rating
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_rating ;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_rating()
 BEGIN
	INSERT IGNORE  Dim_Rating(Rating)
    SELECT DISTINCT
        `oltp`.`loan`.`Rating` AS `Rating`
    FROM
        `oltp`.`loan` ;
END $$ 
DELIMITER ;
CALL oltp_to_olap_dim_rating();

--  Dim WorseLateCategory
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_WorseLateCategory ;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_WorseLateCategory()
 BEGIN
	INSERT IGNORE  Dim_Worse_Late_Category(WorseLateCategory)
    SELECT DISTINCT
        `oltp`.`loan`.`WorseLateCategory` AS `WorseLateCategory`
    FROM
        `oltp`.`loan` ;
END $$ 
DELIMITER ;
CALL oltp_to_olap_dim_WorseLateCategory();

-- Dim ActiveFirstPayment
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_ActiveFirstPayment;
DELIMITER  $$
CREATE PROCEDURE oltp_to_olap_dim_ActiveFirstPayment()
 BEGIN
	INSERT IGNORE  Dim_Active_First_Payment(ActiveFirstPayment)
    SELECT DISTINCT
        `oltp`.`loan_detail`.`ActiveScheduleFirstPaymentReached` AS `ActiveFirstPayment`
    FROM
        `oltp`.`loan_detail` ;
END$$ 
DELIMITER ;
CALL oltp_to_olap_dim_ActiveFirstPayment();

-- Dim Recovery Stage 
DROP PROCEDURE IF EXISTS oltp_to_olap_dim_recovery_stage;
DELIMITER $$
CREATE PROCEDURE oltp_to_olap_dim_recovery_stage()
 BEGIN
	INSERT IGNORE  Dim_Recovery_Stage( RecoveryStage)
    SELECT DISTINCT
        `oltp`.`loan`.`RecoveryStage` AS `RecoveryStage`
    FROM
        `oltp`.`loan`;
END $$ 
DELIMITER ;
CALL oltp_to_olap_dim_recovery_stage();