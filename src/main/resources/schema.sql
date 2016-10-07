CREATE TABLE USER
(
    USER_ID INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    RFID_ID VARCHAR(10) NOT NULL,
    TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FIRSTNAME VARCHAR(30),
    LASTNAME VARCHAR(30)
);
CREATE UNIQUE INDEX USER_RFID_ID_uindex ON USER (RFID_ID);
CREATE UNIQUE INDEX USER_USER_ID_uindex ON USER (USER_ID);
