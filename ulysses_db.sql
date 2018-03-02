/*
By: Ulysses Yu
Reviewers: Aron and Jack
Description: This select statement checks how many people are hospitalized/aren't in Tennessee

Results: Hospitalized, Count
"No"	"4"
"Yes"	"5"
*/
SELECT Hospitalized, Count(*)
FROM HealthReport
WHERE PWSID LIKE "TN%"
GROUP BY Hospitalized;

/*
By: Ulysses Yu
Reviewers: Aron and Jack
Description: This counts the number of times a certain Health Condition recurs in Tennessee

Results: Count(CaseID), Name
"2"	"Cholera"
"5"	"Lead Poisoning"
"1"	"Measles"
"1"	"Worm Infection"
*/
SELECT COUNT(Caseid), Name
FROMHealthReportWHERE PWSID LIKE "TN%"
GROUP BY Name;

/*
By: Ulysses Yu
Reviewers: Aron and Jack
Description: This lists the descriptions of the locations/symptons of lead related illnesses

Results: CASEID, PWSID, Symptoms
"2"	"TN1230001"	"headaches, fever"
"5"	"TN1230000"	"headache, abdominal pain"
"6"	"TN1230002"	"headache, vomitting"
"8"	"TN1234567"	"fever"
"9"	"TN1230002"	"headache, vomitting"
*/
SELECT CASEID, PWSID, Symptoms
FROM HealthReport
WHERE Name LIKE "Lead%";

/*
By: Ulysses Yu
Reviewers: Aron and Jack
Description: This view shows all of the documented violations of all types
*/
CREATE VIEW violation_data AS
SELECT *
FROM Violation, EPAViolation, PointViolation, UtilityViolation;

/*
By: Ulysses Yu
Reviewers: Aron and Jack
Description: This removes every member of location polygon's PWSID when one point from a PWSID is removed
*/
CREATE TRIGGER locationRemoval
ON LocationPolygon AFTER DELETE
FOR EACH ROW 
BEGIN
    WHEN LocationPolygon.PWSID = old.PWSID
    DELETE FROM LocationPolygon; 
END;

/*
Author: Ulysses Yu
*/
INSERT INTO HealthReport VALUES (1,'TN1230000','Measles','123 Brook Lane','12/1/2016','12/2/2016','fever','Yes','None');
INSERT INTO HealthReport VALUES (2,'TN1230001','Lead Poisoning','234 Brook','12/2/2016','12/3/2016','headaches, fever','Yes','High Lead');
INSERT INTO HealthReport VALUES (3,'TN1230002','Cholera','345 Brook Lane','12/10/2016','12/23/2016','fever','Yes','None');
INSERT INTO HealthReport VALUES (4,'CA1240000','Cholera','455 Beverly Hills','3/3/2017','5/2/2017','fever, diarrhea, sweating','Yes','None');
INSERT INTO HealthReport VALUES (5,'TN1230000','Lead Poisoning','891 West End','4/4/2016','4/8/2016','headache, abdominal pain','No','High Lead');
INSERT INTO HealthReport VALUES (6,'TN1230002','Lead Poisoning','334 Broadway','2/2/2016','2/3/2016','headache, vomitting','No','None');
INSERT INTO HealthReport VALUES (7,'CA1240000','Salmonella','442 Melrose Ave','6/6/2017','6/9/2017','vomitting','Yes','None');
INSERT INTO HealthReport VALUES (8,'TN1234567','Lead Poisoning','222 Beale St','1/1/2018','1/3/2018','fever','No','High Lead');
INSERT INTO HealthReport VALUES (9,'TN1230002','Lead Poisoning','444 Demonbruen','2/4/2016','2/7/2016','headache, vomitting','No','None');
INSERT INTO HealthReport VALUES (10,'CA1240000','Cholera','123 Sesame St','5/5/2017','7/7/2017','diarrhea','Yes','None');
INSERT INTO HealthReport VALUES (11,'TN1230000','Worm Infection','545 12 South','10/9/2017','10/11/2017','abdominal poain','Yes','Low Blood Count');
INSERT INTO HealthReport VALUES (12,'TN1230003','Cholera','334 Natchez Trace','7/8/2017','7/26/2017','fever, vommiting','Yes','None');
INSERT INTO HealthReport VALUES (13,'CA1240002','Salmonella','353 Malibu Drive','4/4/2013','5/22/2013','chills, sweat','Yes','None');

/*
Author: Ulysses Yu
*/
INSERT INTO CensusReport VALUES (TN1230000, Davidson, TN, 2010, M, 3, 15, 20.0, 7181, 21924, 32.8, 123);
INSERT INTO CensusReport VALUES (TN1230001, Davidson, TN, 2010, I, 6, 10, 60.0, 5237, 8485, 61.7, 234)
INSERT INTO CensusReport VALUES (TN1230000, Davidson, TN, 2000, I, 1, 17, 5.9, 1213, 28438, 4.3, 345);
INSERT INTO CensusReport VALUES (CA1231111, LosAngleles,CA, 2010, MIE, 11, 22, 50.0, 14166, 37819, 37.5, 456);
INSERT INTO CensusReport VALUES (TN1230002, Rutherford, TN, 2010, M, 2, 20, 10.0, 2957, 33201, 8.9, 567);
INSERT INTO CensusReport VALUES (TN1230002,	Rutherford, TN, 2010, M, 1, 1, 100.0, 311, 311, 100.0, 678);