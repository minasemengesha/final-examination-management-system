-- 1. Create the database
CREATE DATABASE Transaction_Demo;
GO

-- 2. Select the database
USE Transaction_Demo;
GO

-- 3. Create the Account Holder table
CREATE TABLE Account_Holder
(
    Acc_Num  BIGINT PRIMARY KEY NOT NULL,
    Acc_Name VARCHAR(30) NOT NULL,
    Acc_Ini  DECIMAL(18, 2) NOT NULL
);
GO

-- 4. Insert initial account information
INSERT INTO Account_Holder (Acc_Num, Acc_Name, Acc_Ini)
VALUES (1000353564738, 'Abebe Kebede', 3500.70);
GO

-- 5. Begin transaction
-- Set to 1 to demonstrate rollback; set to 0 to demonstrate commit
DECLARE @SimulateFailure BIT = 1;

BEGIN TRY
    BEGIN TRANSACTION;

    -- Update the account balance
    UPDATE Account_Holder
    SET Acc_Ini = Acc_Ini + 1000.00
    WHERE Acc_Num = 1000353564738;

    IF @@ROWCOUNT = 0
        THROW 50001, 'Account was not found.', 1;

    IF @SimulateFailure = 1
        THROW 50000, 'Simulated failure for rollback demonstration.', 1;

    COMMIT TRANSACTION;
    PRINT 'Transaction completed successfully.';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    PRINT 'Transaction failed!';
    PRINT ERROR_MESSAGE();
END CATCH;
GO

-- 6. Display updated account information.
SELECT
    Acc_Num,
    Acc_Name,
    Acc_Ini AS Account_Balance
FROM Account_Holder
WHERE Acc_Num = 1000353564738;
GO