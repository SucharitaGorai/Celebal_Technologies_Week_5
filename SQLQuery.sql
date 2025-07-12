CREATE TABLE SubjectAllotments (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50),
    Is_Valid BIT
);
CREATE TABLE SubjectRequest (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50)
);


CREATE PROCEDURE sp_ProcessSubjectRequests
AS
BEGIN
    
    DECLARE @StudentID VARCHAR(50);
    DECLARE @RequestedSubjectID VARCHAR(50);

    
    DECLARE request_cursor CURSOR FOR
        SELECT StudentId, SubjectId FROM SubjectRequest;

    OPEN request_cursor;
    FETCH NEXT FROM request_cursor INTO @StudentID, @RequestedSubjectID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        DECLARE @CurrentSubjectID VARCHAR(50);
        SELECT @CurrentSubjectID = SubjectId
        FROM SubjectAllotments
        WHERE StudentId = @StudentID AND Is_Valid = 1;

        IF @CurrentSubjectID IS NULL
        BEGIN
           
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
            VALUES (@StudentID, @RequestedSubjectID, 1);
        END
        ELSE IF @CurrentSubjectID <> @RequestedSubjectID
        BEGIN
            
            UPDATE SubjectAllotments
            SET Is_Valid = 0
            WHERE StudentId = @StudentID AND Is_Valid = 1;

            
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
            VALUES (@StudentID, @RequestedSubjectID, 1);
        END
        

        FETCH NEXT FROM request_cursor INTO @StudentID, @RequestedSubjectID;
    END

    CLOSE request_cursor;
    DEALLOCATE request_cursor;  
END;

EXEC sp_ProcessSubjectRequests;

-- Existing subject allotments for a student
INSERT INTO SubjectAllotments VALUES ('159103036', 'PO1491', 1);
INSERT INTO SubjectAllotments VALUES ('159103036', 'PO1492', 0);
INSERT INTO SubjectAllotments VALUES ('159103036', 'PO1493', 0);
INSERT INTO SubjectAllotments VALUES ('159103036', 'PO1494', 0);
INSERT INTO SubjectAllotments VALUES ('159103036', 'PO1495', 0);

-- Student requests a new subject
INSERT INTO SubjectRequest VALUES ('159103036', 'PO1496');

Select * from SubjectAllotments;

Select * from SubjectRequest;



