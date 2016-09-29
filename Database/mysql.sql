CREATE TABLE USER
(
    USER_ID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    RFID_ID VARCHAR(10) NOT NULL,
    TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FIRSTNAME VARCHAR(30),
    LASTNAME VARCHAR(30)
);
CREATE UNIQUE INDEX USER_RFID_ID_uindex ON USER (RFID_ID);
CREATE UNIQUE INDEX USER_USER_ID_uindex ON USER (USER_ID);
CREATE TABLE USER_DETAIL
(
    DETAIL_ID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    USER_ID INT(11),
    EMAIL_ADDRESS VARCHAR(100),
    ADDRESS1 VARCHAR(50),
    ADDRESS2 VARCHAR(50),
    CITY VARCHAR(50),
    STATE VARCHAR(2),
    ZIPCODE VARCHAR(10),
    CONSTRAINT USER_DETAIL_USER_USER_ID_fk FOREIGN KEY (USER_ID) REFERENCES USER (USER_ID)
);
CREATE UNIQUE INDEX USER_DETAIL_DETAIL_ID_uindex ON USER_DETAIL (DETAIL_ID);
CREATE UNIQUE INDEX USER_DETAIL_USER_ID_uindex ON USER_DETAIL (USER_ID);
CREATE TABLE DEVICE
(
    DEVICE_ID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LOCATION VARCHAR(50) NOT NULL,
    DESCRIPTION TEXT
);
CREATE UNIQUE INDEX DEVICE_DEVICE_ID_uindex ON DEVICE (DEVICE_ID);
CREATE TABLE ACCESS
(
    ACCESS_ID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    USER_ID INT(11),
    DEVICE_ID INT(11),
    STATUS TINYINT(1) DEFAULT '0',
    TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT ACCESS_USER_USER_ID_fk FOREIGN KEY (USER_ID) REFERENCES USER (USER_ID),
    CONSTRAINT ACCESS_DEVICE_DEVICE_ID_fk FOREIGN KEY (DEVICE_ID) REFERENCES DEVICE (DEVICE_ID)
);
CREATE UNIQUE INDEX ACCESS_ACCESS_ID_uindex ON ACCESS (ACCESS_ID);
CREATE INDEX ACCESS_DEVICE_DEVICE_ID_fk ON ACCESS (DEVICE_ID);
CREATE INDEX ACCESS_USER_USER_ID_fk ON ACCESS (USER_ID);
CREATE TABLE ACTIVITY_LOG
(
    LOG_ID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    USER_ID INT(11) NOT NULL,
    DEVICE_ID INT(11) NOT NULL,
    TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DETAILS JSON,
    CONSTRAINT ACTIVITY_LOG_USER_USER_ID_fk FOREIGN KEY (USER_ID) REFERENCES USER (USER_ID),
    CONSTRAINT ACTIVITY_LOG_DEVICE_DEVICE_ID_fk FOREIGN KEY (DEVICE_ID) REFERENCES DEVICE (DEVICE_ID)
);
CREATE INDEX ACTIVITY_LOG_DEVICE_DEVICE_ID_fk ON ACTIVITY_LOG (DEVICE_ID);
CREATE UNIQUE INDEX ACTIVITY_LOG_LOG_ID_uindex ON ACTIVITY_LOG (LOG_ID);
CREATE INDEX ACTIVITY_LOG_USER_USER_ID_fk ON ACTIVITY_LOG (USER_ID);
