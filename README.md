Hexaware PetPals SQL Coding Challenge Solution
This repository contains my comprehensive SQL solution for the "PetPals - The Pet Adoption Platform" RDBMS coding challenge provided by Hexaware.

Files Included:
PetPals_Full_SQL_Solution.sql: This is the core SQL script. It includes all necessary commands to:

Initialize the database (DROP DATABASE IF EXISTS, CREATE DATABASE, USE).

Create all required tables (CREATE TABLE IF NOT EXISTS) with appropriate primary and foreign keys.

Insert sample data into the tables.

Define the UpdateShelterInfo stored procedure with error handling.

Execute all 20 SQL queries that solve the specific challenge tasks.

Note: This solution is designed and tested for MySQL.

SQL Coding challenge output screenshot.docx: This document contains screenshots of the actual output results from running each of the SQL queries and the stored procedure call, demonstrating the correctness of the implemented solutions.

How to Use This Solution:
Download the SQL Script: Begin by downloading the PetPals_Full_SQL_Solution.sql file directly from this GitHub repository.

Open in SQL Client: Open the downloaded .sql file using a MySQL client (e.g., MySQL Workbench, DBeaver, or through your command-line interface).

Execute the Script: Run the entire PetPals_Full_SQL_Solution.sql script. It is designed to be executed sequentially, setting up the database, populating it with data, defining procedures, and then running each challenge query.

Verify Outputs: To see the results of each query, open the SQL Coding challenge output screenshot.docx file. The screenshots correspond directly to the numbered tasks/queries in this README and the SQL file.

Solutions Overview:
Below are the SQL queries for each of the 20 tasks, as implemented and executed within the PetPals_Full_SQL_Solution.sql script. Please refer to the SQL Coding challenge output screenshot.docx file for the corresponding output screenshots.

Task 1: Initialize Database
-- Solution provided in PetPals_Full_SQL_Solution.sql
-- Includes DROP DATABASE IF EXISTS, CREATE DATABASE, USE for PetPalsDB.

Task 2-4: Create Tables, Define Keys, Handle Errors
-- All CREATE TABLE statements are fully defined within PetPals_Full_SQL_Solution.sql.
-- They include PRIMARY KEY, FOREIGN KEY constraints, and use IF NOT EXISTS for idempotency.

Task 5: Retrieve available pets
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 1;

Task 6: Retrieve names of participants for a specific adoption event
SELECT ParticipantName, ParticipantType
FROM Participants
WHERE EventID = 1; -- Example: retrieving participants for EventID 1

Task 7: Create a stored procedure to update shelter information
-- Stored procedure definition and an example call are included in PetPals_Full_SQL_Solution.sql.
-- Example Call: CALL UpdateShelterInfo(1, 'Updated Shelter', 'New Location');

Task 8: Calculate total donation amount for each shelter
SELECT S.Name AS ShelterName, IFNULL(SUM(D.DonationAmount), 0) AS TotalDonation
FROM Shelters S
LEFT JOIN Donations D ON S.ShelterID = D.ShelterID
GROUP BY S.ShelterID;

Task 9: Retrieve pets that do not have an owner
SELECT Name, Age, Breed, Type
FROM Pets
WHERE OwnerID IS NULL;

Task 10: Retrieve total donation amount for each month and year
SELECT DATE_FORMAT(DonationDate, '%Y-%m') AS MonthYear, SUM(DonationAmount) AS TotalDonations
FROM Donations
GROUP BY DATE_FORMAT(DonationDate, '%Y-%m')
ORDER BY MonthYear;

Task 11: Retrieve distinct breeds for pets aged between 1-3 or older than 5 years
SELECT DISTINCT Breed
FROM Pets
WHERE (Age BETWEEN 1 AND 3) OR (Age > 5);

Task 12: Retrieve pets and their respective shelters (available for adoption)
SELECT P.Name AS PetName, S.Name AS ShelterName
FROM Pets P
JOIN Shelters S ON P.ShelterID = S.ShelterID
WHERE P.AvailableForAdoption = 1;

Task 13: Find total number of participants in events organized by shelters in a specific city
SELECT COUNT(*) AS TotalParticipants
FROM Participants P
JOIN AdoptionEvents E ON P.EventID = E.EventID
WHERE E.Location = 'Chennai'; -- Example: for events in Chennai

Task 14: Retrieve unique breeds for pets with ages between 1 and 5 years
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;

Task 15: Find pets that have not been adopted
SELECT *
FROM Pets
WHERE PetID NOT IN (SELECT PetID FROM Adoption);

Task 16: Retrieve names of all adopted pets along with adopter's name
SELECT P.Name AS PetName, U.Name AS AdopterName
FROM Pets P
JOIN Adoption A ON P.PetID = A.PetID
JOIN Users U ON A.UserID = U.UserID;

Task 17: Retrieve all shelters along with count of available pets in each
SELECT S.Name AS ShelterName, COUNT(P.PetID) AS AvailablePets
FROM Shelters S
LEFT JOIN Pets P ON S.ShelterID = P.ShelterID AND P.AvailableForAdoption = 1
GROUP BY S.ShelterID;

Task 18: Find pairs of pets from the same shelter that have the same breed
SELECT A.PetID AS Pet1_ID, B.PetID AS Pet2_ID, A.Breed, A.ShelterID
FROM Pets A
JOIN Pets B ON A.Breed = B.Breed AND A.ShelterID = B.ShelterID AND A.PetID < B.PetID;

Task 19: List all possible combinations of shelters and adoption events
SELECT S.Name AS ShelterName, E.EventName
FROM Shelters S
CROSS JOIN AdoptionEvents E;

Task 20: Determine the shelter with the highest number of adopted pets
SELECT S.Name, COUNT(*) AS TotalAdopted
FROM Adoption A
JOIN Pets P ON A.PetID = P.PetID
JOIN Shelters S ON P.ShelterID = S.ShelterID
GROUP BY S.ShelterID
ORDER BY TotalAdopted DESC
LIMIT 1;
