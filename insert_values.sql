INSERT INTO typeofaudio (Type)
VALUES ('Song');
INSERT INTO typeofaudio (Type)
VALUES ('AudioBook');
INSERT INTO typeofaudio (Type)
VALUES ('Podcast');

INSERT INTO AudioUser (firstname, lastname, email, pass)
VALUES ('Szymon', 'Tomala','szymon@onet.pl','q');
INSERT INTO AudioUser (firstname, lastname, email, pass)
VALUES ('Adam', 'Bednorz','adam@interia.pl','q');
INSERT INTO AudioUser (firstname, lastname, email, pass)
VALUES ('Piotr', 'Gorzelnik','piotr@wp.pl','q');

INSERT INTO Author (authorname)
VALUES ('B24');
INSERT INTO Author (authorname)
VALUES ('Rammstein');
INSERT INTO Author (authorname)
VALUES ('Crystal Castles');


REM INSERTING into AUDIOLIBRARY.AUDIOFILE
SET DEFINE OFF;
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('24','Kept','3','23','160');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('41','Vanished','3','23','170');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('42','Vietnam','3','23','140');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('43','Mein Land','2','23','210');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('44','Nebel','2','23','200');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('45','Rosenrot','2','23','230');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('46','Mein Teil','2','23','200');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('47','Zalepiony strasznie','1','23','170');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('48','Urodzinowy track','1','23','180');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('49','Butla na DJ','1','23','130');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('50','D¿uma','1','23','200');
Insert into AUDIOLIBRARY.AUDIOFILE (ID,TITLE,AUTHORID,TYPEOFAUDIOID,LENGTH) values ('51','EP','1','23','210');
