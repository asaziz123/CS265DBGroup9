DROP TABLE;
DROP VIEW;
DROP TRIGGER;

CREATE TABLE `Drinking Water Service Area` (
	`PWSID`	TEXT NOT NULL,
	`County`	TEXT,
	`State`	TEXT,
	`Population_Served`	INTEGER,
	PRIMARY KEY(`PWSID`)
);

