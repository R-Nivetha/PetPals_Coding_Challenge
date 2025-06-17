# 🐾 Hexaware PetPals SQL Coding Challenge Solution

This repository contains my complete solution for the **"PetPals - The Pet Adoption Platform"** SQL-based RDBMS challenge provided by Hexaware Technologies.

---

## 📂 Files Included

- `PetPals_Full_SQL_Solution.sql`  
  ✔️ Initializes the database  
  ✔️ Creates all required tables with primary and foreign keys  
  ✔️ Inserts sample data  
  ✔️ Defines the `UpdateShelterInfo` stored procedure  
  ✔️ Solves all 20 SQL tasks in the challenge

- `SQL_Coding_Challenge_Output_Screenshot.docx`  
  📸 Screenshots of query outputs as proof of correctness

---

## 🛠️ How to Use This Solution

1. **Download the SQL script**  
   → [`PetPals_Full_SQL_Solution.sql`](./PetPals_Full_SQL_Solution.sql)

2. **Open with a MySQL client**  
   You can use MySQL Workbench, DBeaver, or command line.

3. **Execute the full script**  
   The file is self-contained and includes everything from setup to query results.

4. **Verify outputs**  
   Open the `.docx` file to view the actual results and match them with each task.

---

## ✅ Task Summary with Sample Queries

| Task No. | Description | Sample SQL |
|----------|-------------|-------------|
| 1 | Initialize DB | `DROP DATABASE IF EXISTS PetPalsDB;` |
| 2–4 | Create Tables & Keys | `CREATE TABLE IF NOT EXISTS Pets (...);` |
| 5 | List available pets | `SELECT Name FROM Pets WHERE AvailableForAdoption = 1;` |
| 6 | Participants in Event 1 | `SELECT ParticipantName FROM Participants WHERE EventID = 1;` |
| 7 | Update Shelter Procedure | `CALL UpdateShelterInfo(1, 'New Shelter', 'New City');` |
| 8 | Total donation per shelter | `SELECT S.Name, SUM(D.DonationAmount)...` |
| 9 | Pets without owners | `SELECT Name FROM Pets WHERE OwnerID IS NULL;` |
| 10 | Monthly donations | `SELECT DATE_FORMAT(DonationDate, '%Y-%m')...` |
| 11 | Breeds of pets age 1–3 or >5 | `SELECT DISTINCT Breed FROM Pets...` |
| 12 | Pets & Shelters (available) | `SELECT P.Name, S.Name FROM Pets P JOIN Shelters S...` |
| 13 | Participants in Chennai | `SELECT COUNT(*) FROM Participants JOIN Events...` |
| 14 | Unique breeds aged 1–5 | `SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 5;` |
| 15 | Unadopted pets | `SELECT * FROM Pets WHERE PetID NOT IN (SELECT PetID FROM Adoption);` |
| 16 | Adopted pets + adopter name | `SELECT P.Name, U.Name FROM Pets P JOIN Adoption A...` |
| 17 | Available pets per shelter | `SELECT S.Name, COUNT(P.PetID)...` |
| 18 | Same breed pairs in same shelter | `SELECT A.PetID, B.PetID FROM Pets A JOIN Pets B...` |
| 19 | All Shelter × Event combinations | `SELECT S.Name, E.EventName FROM Shelters S CROSS JOIN Events E;` |
| 20 | Shelter with most adoptions | `SELECT S.Name, COUNT(*) FROM Adoption A... ORDER BY COUNT(*) DESC LIMIT 1;` |

> 📌 Full logic for each query is inside `PetPals_Full_SQL_Solution.sql`.

---

## 💻 Technologies Used

- MySQL 8.x
- MySQL Workbench

---

## 📸 Output Screenshots

Screenshots of outputs for all 20 tasks and stored procedure call are available in:  
📄 `SQL_Coding_Challenge_Output_Screenshot.docx`

---

## 🏁 Final Note

This project demonstrates my hands-on SQL skills for database design, querying, aggregation, and stored procedure logic as required by the Hexaware challenge.

