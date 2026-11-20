USE TWDP
SELECT * FROM Patients

          --RETRIEVING & FILTERING DATA.

--1. Retrieve all patients from lagos.
SELECT * FROM [dbo].[Patients] 
WHERE [City] = 'Lagos'

--2. Find all patients with a length of stay greater than 5 days.
SELECT * FROM [dbo].[Patients]
WHERE [Length_of_Stay] >5

--3. Find patients whose age is between 30 and 50 years.
SELECT * FROM [dbo].[Patients] 
WHERE [Age] BETWEEN 30 AND 50

--4. Retrieve all female patients from lagos who were admitted through 
--Emergency admission.
SELECT * FROM [dbo].[Patients]
WHERE [Gender] = 'Female' 
AND [City] ='Lagos' 
AND [Admission_Type] = 'Emergency'

--5. Retrieve all patients who have Diabetes OR Hypertension.
SELECT * FROM [dbo].[Patients]
WHERE [Condition] = 'Diabetes' OR [Condition]= 'Hypertension'

        --SORTING, DISTINCT & BASIC AGGREGATION.

--6. Find the 3 patients with the longest hospital stays, 
--displaying them from longest to shortes. 
SELECT TOP 3 * FROM [dbo].[Patients]
ORDER BY [Length_of_Stay] DESC

--7. List all the unique cities represented in the dataset. 
SELECT DISTINCT [City] FROM [dbo].[Patients]
ORDER BY [City]

--8. Count the total number of patients.
SELECT COUNT ([Patient_ID]) AS Total_patient
FROM [dbo].[Patients]

--9. Calculate the average patient age.
SELECT CAST ( SUM([Age]) * 1.0/COUNT(*) AS DECIMAL(10,1)) AS Average_Patient_Age
FROM[dbo].[Patients]

--10. Count the number of patients for each Medical Condition.
SELECT [Condition],
COUNT ([Patient_ID]) AS MC 
FROM [dbo].[Patients] GROUP BY [Condition]

         --WORKING WITH STRINGS & DATES.

--11. Display each patient's full name in uppercase.
SELECT [Patient_Name], UPPER([Patient_Name]) 
AS PatientsName 
FROM [dbo].[Patients]

--12. Display each patient's full name in lowercase.
SELECT [Patient_Name], LOWER([Patient_Name])
AS PatientsName 
FROM [dbo].[Patients]

--13. Create a new column that combines the patient ID 
--and Patient Name into one value.
SELECT CONCAT([Patient_ID],' ', '-',' ',[Patient_Name]) 
AS Patients_Details 
FROM [dbo].[Patients]

--14. Find all patients who were admitted after January 15 2026.
SELECT * FROM [dbo].[Patients] 
WHERE [Admission_Date] > '2026-01-05'

--15. Display the year and month in which each patient was admitted. 
SELECT [Patient_Name],[Gender],[Admission_Date],
YEAR ([Admission_Date]) AS AdmissionYear, 
DATENAME (MONTH,[Admission_Date]) AS AdmissionMonth
FROM [dbo].[Patients]

          --ADVANCED AGGREGATION  CONDITIONAL ANALYSIS.

-- 16.Calculate the average length of stay for each admission type. 
SELECT [Admission_Type], 
CAST ( SUM([Length_of_Stay]) * 1.0/COUNT(*) AS DECIMAL(10,1)) 
AS LOS
FROM [dbo].[Patients] GROUP BY [Admission_Type]

--17. Find the admission types with an average length of stay greater than 4 days. 
SELECT [Admission_Type],
CAST ( SUM([Length_of_Stay]) * 1.0/COUNT(*) AS DECIMAL(10,1)) AS AVG_LOS
FROM [dbo].[Patients] GROUP BY [Admission_Type]
HAVING AVG ([Length_of_Stay])>4 

--18. Classify patients as Young (under 40), Middle-aged (40-59), 
--or Senior (60 and above).
SELECT [Patient_Name],[Age],[Gender],
CASE 
WHEN [Age]<40 THEN 'Young'
WHEN [Age] BETWEEN 40 AND 59 THEN 'Middle-aged'
ELSE 'Senior' 
END AS Age_Range
FROM [dbo].[Patients]

--19. Count the number of patients in each age group.
SELECT
CASE 
WHEN [Age]<40 THEN 'Young'
WHEN [Age] BETWEEN 40 AND 59 THEN 'Middle-aged'
ELSE 'Senior' 
END AS Age_Range,
COUNT(*) AS Age_Group
FROM [dbo].[Patients]
GROUP BY 
CASE 
WHEN [Age]<40 THEN 'Young'
WHEN [Age] BETWEEN 40 AND 59 THEN 'Middle-aged'
ELSE 'Senior' 
END

--20. Classify patients as Short Stay (3 days or less) or Long Stay (more thaN 3 days).
SELECT [Patient_Name],[Age],[Gender],[Condition],[Length_of_Stay],
CASE 
WHEN [Length_of_Stay]<=3 THEN 'Short Stay'
ELSE 'Long Stay'
END AS Stay
FROM [dbo].[Patients]

--21. Find the medical conditions with more than 1 patients.
SELECT [Condition], 
COUNT(*) AS MC
FROM [dbo].[Patients]
GROUP BY [Condition]
HAVING COUNT(*)>1

       --PRIMARY & FOREIGN KEYS & SQL JOINs.

--22. Import the Doctors table into SQL server and verify that it was loaded correctly.
SELECT * FROM [dbo].[Doctors]

--23. Join the Patients and Doctors tables to display each patient's name and their doctor's specialization. 
SELECT [dbo].[Patients].[Doctor_ID],
[dbo].[Patients].[Patient_Name],
[dbo].[Doctors].[Doctor_ID],
[dbo].[Doctors].[Specialization]
FROM [dbo].[Patients] 
JOIN [dbo].[Doctors] 
ON [dbo].[Patients].[Doctor_ID]= [dbo].[Doctors].[Doctor_ID]

--24. Find all Patients treated by doctors specializing in Internal Medicine.
SELECT [dbo].[Patients].[Doctor_ID],
[dbo].[Patients].[Patient_Name],
[dbo].[Doctors].[Doctor_Name],
[dbo].[Doctors].[Specialization]
FROM [dbo].[Patients] 
JOIN [dbo].[Doctors]
ON [dbo].[Doctors].[Doctor_ID] = [dbo].[Patients].[Doctor_ID]
WHERE [Specialization]= 'Internal Medicine'

--25. Calculate the average length of stay for patients treated by each doctor.
SELECT [dbo].[Doctors].[Doctor_Name],
CAST ( SUM([dbo].[Patients].[Length_of_Stay]) * 1.0/COUNT(*) AS DECIMAL(10,1)) 
AS AVG_LOS
FROM [dbo].[Patients]
JOIN [dbo].[Doctors]
ON [dbo].[Doctors].[Doctor_ID] = [dbo].[Patients].[Doctor_ID]
GROUP BY [Doctor_Name]

--26. Identify the doctor who has treated the highest number of patients.
SELECT TOP 1
[dbo].[Doctors].[Doctor_Name], 
COUNT([dbo].[Patients].[Patient_ID]) AS HNP
FROM[dbo].[Patients]
JOIN [dbo].[Doctors]
ON [dbo].[Doctors].[Doctor_ID] = [dbo].[Patients].[Doctor_ID]
GROUP BY [dbo].[Doctors].[Doctor_Name]
ORDER BY HNP DESC

