
-- Step 1–4: Initialize database, create tables, define keys, and handle existing DB

DROP DATABASE IF EXISTS PetPalsDB;
CREATE DATABASE PetPalsDB;
USE PetPalsDB;

CREATE TABLE Shelters (
    ShelterID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Pets (
    PetID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Breed VARCHAR(100),
    Type VARCHAR(50),
    AvailableForAdoption BOOLEAN DEFAULT TRUE,
    OwnerID INT DEFAULT NULL,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Adoption (
    AdoptionID INT AUTO_INCREMENT PRIMARY KEY,
    PetID INT,
    UserID INT,
    AdoptionDate DATETIME,
    FOREIGN KEY (PetID) REFERENCES Pets(PetID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Donations (
    DonationID INT AUTO_INCREMENT PRIMARY KEY,
    DonorName VARCHAR(100),
    DonationType VARCHAR(50),
    DonationAmount DECIMAL(10,2),
    DonationItem VARCHAR(100),
    DonationDate DATETIME,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE AdoptionEvents (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(255)
);

CREATE TABLE Participants (
    ParticipantID INT AUTO_INCREMENT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

DELIMITER //

CREATE PROCEDURE UpdateShelterInfo(
    IN p_ShelterID INT,
    IN p_NewName VARCHAR(100),
    IN p_NewLocation VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Shelters WHERE ShelterID = p_ShelterID) THEN
        UPDATE Shelters
        SET Name = p_NewName, Location = p_NewLocation
        WHERE ShelterID = p_ShelterID;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Shelter ID';
    END IF;
END //

DELIMITER ;

-- Sample Data
INSERT INTO Shelters (Name, Location) VALUES ('My Shelter', 'Chennai');

INSERT INTO Pets (Name, Age, Breed, Type, AvailableForAdoption, OwnerID, ShelterID)
VALUES 
('Tommy', 2, 'Labrador', 'Dog', TRUE, NULL, 1),
('Kitty', 4, 'Siamese', 'Cat', TRUE, NULL, 1),
('Max', 6, 'Beagle', 'Dog', FALSE, 1, 1);

INSERT INTO Users (Name) VALUES ('User1'), ('User2');

INSERT INTO Adoption (PetID, UserID, AdoptionDate) VALUES (3, 1, NOW());

INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID)
VALUES 
('Donor1', 'Cash', 500.00, NULL, NOW(), 1),
('Donor2', 'Item', NULL, 'Pet Food', NOW(), 1);

INSERT INTO AdoptionEvents (EventName, EventDate, Location)
VALUES ('Adoption Day', '2025-07-01 10:00:00', 'Chennai');

INSERT INTO Participants (ParticipantName, ParticipantType, EventID)
VALUES ('My Shelter', 'Shelter', 1), ('User1', 'Adopter', 1);

-- Q5
SELECT Name, Age, Breed, Type FROM Pets WHERE AvailableForAdoption = 1;

-- Q6
SELECT ParticipantName, ParticipantType FROM Participants WHERE EventID = 1;

-- Q7 (see stored procedure above)
CALL UpdateShelterInfo(1, 'Updated Shelter', 'New Location');
SELECT * FROM Shelters;

-- Q8
SELECT S.Name AS ShelterName, IFNULL(SUM(D.DonationAmount), 0) AS TotalDonation
FROM Shelters S
LEFT JOIN Donations D ON S.ShelterID = D.ShelterID
GROUP BY S.ShelterID;

-- Q9
SELECT Name, Age, Breed, Type FROM Pets WHERE OwnerID IS NULL;

-- Q10
SELECT DATE_FORMAT(DonationDate, '%Y-%m') AS MonthYear, SUM(DonationAmount) AS TotalDonations
FROM Donations
GROUP BY DATE_FORMAT(DonationDate, '%Y-%m')
ORDER BY MonthYear;

-- Q11
SELECT DISTINCT Breed FROM Pets WHERE (Age BETWEEN 1 AND 3) OR (Age > 5);

-- Q12
SELECT P.Name AS PetName, S.Name AS ShelterName
FROM Pets P JOIN Shelters S ON P.ShelterID = S.ShelterID
WHERE P.AvailableForAdoption = 1;

-- Q13
SELECT COUNT(*) AS TotalParticipants
FROM Participants P JOIN AdoptionEvents E ON P.EventID = E.EventID
WHERE E.Location = 'Chennai';

-- Q14
SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 5;

-- Q15
SELECT * FROM Pets WHERE PetID NOT IN (SELECT PetID FROM Adoption);

-- Q16
SELECT P.Name AS PetName, U.Name AS AdopterName
FROM Pets P JOIN Adoption A ON P.PetID = A.PetID
JOIN Users U ON A.UserID = U.UserID;

-- Q17
SELECT S.Name AS ShelterName, COUNT(P.PetID) AS AvailablePets
FROM Shelters S
LEFT JOIN Pets P ON S.ShelterID = P.ShelterID AND P.AvailableForAdoption = 1
GROUP BY S.ShelterID;

-- Q18
SELECT A.PetID AS Pet1_ID, B.PetID AS Pet2_ID, A.Breed, A.ShelterID
FROM Pets A JOIN Pets B ON A.Breed = B.Breed AND A.ShelterID = B.ShelterID AND A.PetID < B.PetID;

-- Q19
SELECT S.Name AS ShelterName, E.EventName
FROM Shelters S CROSS JOIN AdoptionEvents E;

-- Q20
SELECT S.Name, COUNT(*) AS TotalAdopted
FROM Adoption A JOIN Pets P ON A.PetID = P.PetID
JOIN Shelters S ON P.ShelterID = S.ShelterID
GROUP BY S.ShelterID
ORDER BY TotalAdopted DESC
LIMIT 1;
