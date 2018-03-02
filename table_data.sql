/*
PWSIDs: 
*/

/*
By: Ulysses
*/
INSERT INTO LocationPolygon('TN1230000', 5, 10);
INSERT INTO LocationPolygon('TN1230000', 10, 10);
INSERT INTO LocationPolygon('TN1230000', 5, 5);
INSERT INTO LocationPolygon('TN1230001', 5, 0);
INSERT INTO LocationPolygon('TN1230001', 0, 0);
INSERT INTO LocationPolygon('TN1230001', 0, 5);
INSERT INTO LocationPolygon('TN1230002', 10, 15);
INSERT INTO LocationPolygon('TN1230002', 10, 10);
INSERT INTO LocationPolygon('TN1230002', 15, 15);

/*
By: Jack
Reviewed: Ulysses
*/
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('TN1230000', 1000000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('TN1230001',100000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('TN1230002',200000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('TN1230003',300000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('CA1231111',300000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('TN1234567',100000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('CA1240000',10000000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('CA1240001', 200000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('CA1240002',100000);
INSERT INTO DrinkingWaterServiceArea (PWSID, Population_Served) VALUES ('CA1240003',500000);

/*
By: Ulysses
*/

-- PWS, Quarter, Type, ViolationID
INSERT INTO Violation VALUES ('TN1230000', 1, 'Point', 123);
INSERT INTO Violation VALUES ('TN1230001', 2, 'Point', 234);
INSERT INTO Violation VALUES ('TN1230002', 3, 'EPA', 345);
INSERT INTO Violation VALUES ('TN1230003', 4, 'EPA', 456);
INSERT INTO Violation VALUES ('TN1230000', 2, 'EPA', 567);
INSERT INTO Violation VALUES ('TN1230002', 2, 'Utility', 678);
INSERT INTO Violation VALUES ('TN1230001', 1, 'Utility', 789);

/*
By: Ulysses
UtilityViolations: VDate, Time, quality, vID
*/

INSERT INTO UtilityViolations VALUES ('1/2/18', '12:00', 'Low', 678);
INSERT INTO UtilityViolations VALUES ('2/2/18', '4:20', 'High', 789);

/*
By: Ulysses
PointViolation: VDate, Time, lat, long, quality, vID, pointtype, PWSID
*/

INSERT INTO PointViolation VALUES ('1/2/18', '12:00', 1, 2, 'High', 123, 'Float', 'TN1230000');
INSERT INTO PointViolation VALUES ('1/2/18', '12:00', 2, 2, 'High', 234, 'Float', 'TN1230000');