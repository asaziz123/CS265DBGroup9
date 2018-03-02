DROP TABLE;
DROP VIEW;
DROP TRIGGER;

CREATE TABLE IF NOT EXISTS DrinkingWaterServiceArea (
	PWSID	TEXT NOT NULL,
	PopulationServed	INTEGER,
	PRIMARY KEY(PWSID)
);

CREATE TABLE IF NOT EXISTS LocationPolygon (
	PWSID	TEXT NOT NULL,
	Latitude	INTEGER,
	Longitude	INTEGER,
	PRIMARY KEY(PWSID,Latitude,Longitude),
	FOREIGN KEY(PWSID) REFERENCES DrinkingWaterServiceArea(PWSID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PrimaryCountyServed (
	County	TEXT NOT NULL,
	State	TEXT NOT NULL,
	PWSID	TEXT NOT NULL,
	CountyFIPSCode	INTEGER,
	Municipality	TEXT,
	PRIMARY KEY(PWSID, County, State),
	FOREIGN KEY(PWSID) REFERENCES DrinkingWaterServiceArea(PWSID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CensusReport (
	PWSID	TEXT NOT NULL,
	County	TEXT NOT NULL,
	State	TEXT NOT NULL,
	Year	INTEGER,
	EnvJusticeCriteria	TEXT,
	EJBlockGroups	TEXT,
	TotalBlockGroups	TEXT,
	PrecentEJBlockGroups	INTEGER,
	EJBGPopulation	INTEGER,
	Population	INTEGER,
	PercentEJBGPopulation	INTEGER,
	FIPSCode	INTEGER,
	FOREIGN KEY(PWSID) REFERENCES PrimaryCountyServed (PWSID),
	PRIMARY KEY(Year, PWSID, County, State)
);

CREATE TABLE IF NOT EXISTS Violation (
	PWSID	INTEGER NOT NULL,
	ViolationID	INTEGER NOT NULL,
	Year INTEGER,
	Quarter	INTEGER,
	Type	TEXT,
	PRIMARY KEY(ViolationID,PWSID),
	FOREIGN KEY(PWSID) REFERENCES DrinkingWaterServiceArea (PWSID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS UtilityViolation (
	VDate	TEXT,
	Time	TEXT,
	Quality	TEXT,
	ViolationID	INTEGER NOT NULL,
	PRIMARY KEY(ViolationID)
	FOREIGN KEY(ViolationID) REFERENCES Violation (ViolationID)
	FOREIGN KEY(PWSID) REFERENCES DrinkingWaterServiceArea (PWSID) ON UPDATE CASCADE ON DELETE cascade
);

CREATE TABLE IF NOT EXISTS PointViolation (
	VDate	TEXT,
	Time	TEXT,
	Latitude	INTEGER,
	Longitude	INTEGER,
	Quality	TEXT,
	ViolationID	INTEGER NOT NULL,
	PointType	TEXT,
	PWSID	TEXT NOT NULL,
	PRIMARY KEY(PWSID,ViolationID),
	FOREIGN KEY(ViolationID) REFERENCES Violation (ViolationID) ON DELETE CASCADE ON UPDATE CASCADE 
	FOREIGN KEY(PWSID) REFERENCES DrinkingWaterServiceArea (PWSID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS EPAViolation (
	PWSID		TEXT NOT NULL,
	ViolationID		INTEGER NOT NULL,
	Quality		TEXT,
	PRIMARY KEY(Violation ID, PWSID)
	FOREIGN KEY(ViolationID) REFERENCES Violation (ViolationID) ON DELETE CASCADE ON UPDATE CASCADE 
	FOREIGN KEY(PWSID) REFERENCES DrinkingWaterServiceArea (PWSID) ON UPDATE CASCADE ON DELETE cascade	
);

CREATE TABLE IF NOT EXISTS HealthReport (
	CaseID	INTEGER NOT NULL,
	PWSID	TEXT,
	Name	TEXT,
	Address	TEXT,
	OnsetDate	TEXT,
	EndDate	TEXT,
	Symptoms	TEXT,
	Hospitalized	TEXT,
	LabResults	TEXT,
	PRIMARY KEY(CaseID),
	FOREIGN KEY(PWSID) REFERENCES DrinkingWaterServiceArea(PWSID) ON UPDATE CASCADE ON DELETE CASCADE
);


-- VIEWS 

/* 
 * Primary Author: Jack Ding 
 */
CREATE VIEW QualityViolationInQuarter3 AS
SELECT E.Quality, P.Quality, U.Quality
FROM EPAViolation E, PointViolation P, UtilityViolation U, Violation V
WHERE V.Quarter = 3 AND V.ViolationID = E.ViolationID AND V.ViolationID = P.ViolationID AND V.ViolationID = U.ViolationID

/* 
 * Primary Author: Aron Aziz 
 * Description: View health reports in which patient was hospitalized
 */
CREATE VIEW HospitalizationReports AS 
SELECT H.CaseID, H.PWSID, H.Name, H.Address, H.OnsetDate, H.EndDate, H.Symptoms, H.LabResults
FROM HealthReport H
WHERE H.Hospitalized = "Y"

-- TRIGGERS

/* 
 * Primary Author of Violation Update Triggers: Jack Ding
 */
CREATE TRIGGER OnUpdateEPAViolation 
Before INSERT ON EPAViolation
FOR EACH ROW
BEGIN
	INSERT INTO Violation VALUES (NEW.PWSID, NULL, NULL, NEW.Violation ID);
END;

CREATE TRIGGER OnUpdateUtilityViolation 
Before INSERT ON UtilityViolation
FOR EACH ROW
BEGIN
	INSERT INTO Violation VALUES (NEW.PWSID, NULL, NULL, NEW.Violation ID);
END;

CREATE TRIGGER OnUpdatePointViolation 
Before INSERT ON PointViolation
FOR EACH ROW
BEGIN
	INSERT INTO Violation VALUES (NEW.PWSID, NULL, NULL, NEW.Violation ID);
END;

/*
 * Primary Author: Aron Aziz
 * Update Drinking Water Service Area population based upon census population data
 */
CREATE TRIGGER UpdatePopulation
After INSERT ON CensusReport
FOR EACH ROW
BEGIN
	UPDATE DrinkingWaterServiceArea 
	SET PopulationServed = (PopulationServed + NEW.TotalPopulation)
	WHERE PWSID = NEW.PWSID;
END;

-- QUERIES 

/* 
 * Primary Author: Jack Ding 
 * see the quality of the chemical violations 
 */
SELECT E.Quality, P.Quality, U.Quality
FROM EPAViolation E, PointViolation P, UtilityViolation U, Violation V
WHERE V.Type = “Chemical” AND V.ViolationID = E.ViolationID AND V.ViolationID = P.ViolationID AND V.ViolationID = U.ViolationID

/* 
 * Primary Author: Jack Ding 
 * get the YEAR and PWSIDs for PointViolations where 2 or more violations in a year
 */
SELECT ViolationID, PWSIDs, YEAR
FROM Violation JOIN PointViolation USING (PWSID, ViolationID)
GROUP BY Year
HAVING COUNT (*) > 1;

/* 
 * Primary Author: Jack Ding 
 * get the number of bacteria violations in year 2005
 */
SELECT COUNT (Type)
FROM Violation
WHERE Type = “bacteria” AND Year = 2005;



DROP TABLE;
DROP VIEW;
DROP TRIGGER;
