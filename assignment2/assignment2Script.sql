CREATE TABLE School(
name	char(20) NOT NULL,
budget	int(32) NOT NULL,
deanUID int(32) NOT NULL,
PRIMARY KEY(name),
FOREIGN KEY(deanUID) references Faculty(userID)
);

CREATE TABLE Building(
name		char(20) NOT NULL,
xLeftBottom	int(32) NOT NULL,
yLeftBottom	int(32) NOT NULL,
xRightUpper	int(32) NOT NULL,
yRightUpper	int(32) NOT NULL,
PRIMARY KEY(name)
);

create table Visitor(
userID	int(32) NOT NULL,
name	char(20) NOT NULL,
purpose	char(20) NOT NULL,
primary key(userID)
);

create table Student(
userID			int(32) NOT NULL,
name			char(20) NOT NULL,
uciEmailAddress	char(30) NOT NULL,
deptName		char(20) NOT NULL,
type			enum('undergrad', 'grad') not null,
primary key(userID),
foreign key(deptName) references Department(name)
);

create table Staff(
userID			int(32) NOT NULL,
name			char(20) NOT NULL,
uciEmailAddress	char(30) NOT NULL,
deptName		char(20) NOT NULL,
employementtype			char(20) not null,
primary key(userID),
foreign key(deptName) references Department(name)
);

create table Faculty(
userID			int(32) NOT NULL,
name			char(20) NOT NULL,
uciEmailAddress	char(30) NOT NULL,
deptName		char(20) NOT NULL,
researchArea char(20) not null,
primary key(userID),
foreign key(deptName) references Department(name)
);

create table Student(
userID			int(32) NOT NULL,
name			char(20) NOT NULL,
uciEmailAddress	char(30) NOT NULL,
deptName		char(20) NOT NULL,
type			enum('undergrad', 'grad') not null,
primary key(userID),
foreign key(deptName) references Department(name)
);

create table Recycle(
binID			int(32) NOT NULL,
capacity	    int(32) NOT NULL,
xLocation	    int(32) NOT NULL,
yLocation		int(32) NOT NULL,
contaminated			enum('yes', 'no') not null,
primary key(userID)
);

create table Landfill(
binID			int(32) NOT NULL,
capacity	    int(32) NOT NULL,
xLocation	    int(32) NOT NULL,
yLocation		int(32) NOT NULL,
compressionSupport		enum('yes', 'no') not null,
primary key(binID)
);

create table Compost(
binID			int(32) NOT NULL,
capacity	    int(32) NOT NULL,
xLocation	    int(32) NOT NULL,
yLocation		int(32) NOT NULL,
compostingType  char(20) NOT NULL,
primary key(binID)
);

create table LocationSensor(
sensorID	int(32) NOT NULL,
ipAddress	int(32) NOT NULL,
userID	    int(32) NOT NULL,
mode		char(20) NOT NULL,
maxRange	int(32) NOT NULL,
primary key(sensorID),
foreign key(userID) references Visitor(userID),
foreign key(userID) references Faculty(userID), 
foreign key(userID) references Staff(userID),
foreign key(userID) references Student(userID) 
);

create table LoadSensor(
sensorID	int(32) NOT NULL,
ipAddress	int(32) NOT NULL,
batterPower	int(32) NOT NULL,
binID		int(32),
measuremetType	char(32) NOT NULL,
primary key(sensorID),
foreign key(binID) references Recycle(binID),
foreign key(binID) references Landfill(binID),
foreign key(binID) references Compost(binID)
);

create table ObjectRecoSensor(
sensorID	int(32) NOT NULL,
ipAddress	int(32) NOT NULL,
batterPower	int(32) NOT NULL,
binID		int(32),
quantity	int(32) NOT NULL,
primary key(sensorID),
foreign key(binID) references Recycle(binID),
foreign key(binID) references Landfill(binID),
foreign key(binID) references Compost(binID)
);

create table Department(
deptName	char(20) NOT NULL,
schoolName	char(20) NOT NULL,
startDate	char(20) NOT NULL,
phoneNo		int(32) NOT NULL,
buildingName char(20) NOT NULL,
managerUID int(32) NOT NULL,
primary key(deptName, schoolName),
foreign key(schoolName) references School(name),
foreign key(buildingName) references Building(name), 
foreign key(managerUID) references Staff(userID),
foreign key(charUID) references Faculty(userID) 
);

create table ObjectRecoObs(
oid	int(32) NOT NULL,
sensorID	int(32) NOT NULL,
timestamp	int(32) NOT NULL,
trashType		enum('Recycle', 'Landfill', 'Compost') NOT NULL,
primary key(oid, sensorID),
foreign key(sensorID) references ObjectRecoSensor(sensorID)
);

create table LoadObs(
oid	int(32) NOT NULL,
sensorID	int(32) NOT NULL,
timestamp	int(32) NOT NULL,
weight		int(32) NOT NULL,
primary key(oid, sensorID),
foreign key(sensorID) references LoadSensor(sensorID)
);

create table LocationObs(
oid	int(32) NOT NULL,
sensorID	int(32) NOT NULL,
timestamp	int(32) NOT NULL,
xLocation   int(32) NOT NULL,
yLocation   int(32) NOT NULL,
primary key(oid, sensorID),
foreign key(sensorID) references LocationSensor(sensorID)
);

DROP DATABASE IF EXISTS `cs122a`;
CREATE DATABASE `cs122a`;
USE `cs122a`;