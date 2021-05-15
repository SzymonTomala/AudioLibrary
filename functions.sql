CREATE OR REPLACE FUNCTION SIGNUP(
    a_firstname VARCHAR2,
    a_lastname VARCHAR2,
    a_email VARCHAR2,
    a_pass VARCHAR2
    ) RETURN NUMBER
AS
    a_id NUMBER;
BEGIN
    SELECT id into a_id FROM AudioUser WHERE firstname = a_firstname AND
        lastname = a_lastname AND email = a_email AND a_pass = pass;
    RETURN a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN    
        INSERT INTO AudioUser (firstname, lastname, email, pass)
            VALUES (a_firstname, a_lastname, a_email, a_pass);
        SELECT id INTO a_id FROM AudioUser WHERE rownum = 1
            ORDER BY id DESC;    
        RETURN a_id;    
END;
/

var user_signup number;
call SIGNUP('Marcin', 'Najman', 'eltost@interia.pl', 'haslo1')
into :user_signup;
PRINT user_signup;

CREATE OR REPLACE FUNCTION SIGNIN(
    a_firstname VARCHAR2,
    a_lastname VARCHAR2,
    a_email VARCHAR2,
    a_pass VARCHAR2
    ) RETURN NUMBER
AS
    a_id NUMBER;
BEGIN
    SELECT id into a_id FROM AudioUser WHERE firstname = a_firstname AND
        lastname = a_lastname AND email = a_email AND a_pass = pass;
    RETURN SIGN(a_id);
        
    EXCEPTION WHEN NO_DATA_FOUND THEN      
        RETURN 0;    
END;
/

var user_signin number;
call SIGNIN('Piotr', 'Kuczera', 'rybnik@wp.pl', 'haslo12')
into :user_signin;
PRINT user_signin;


CREATE OR REPLACE FUNCTION ADDAUTHOR(
    a_authorname VARCHAR2
    ) RETURN NUMBER
AS
    a_id NUMBER;
BEGIN
    SELECT id into a_id FROM Author WHERE authorname =  a_authorname;
    RETURN a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN    
        INSERT INTO Author (authorname)
            VALUES (a_authorname);
        SELECT id INTO a_id FROM Author WHERE rownum = 1
            ORDER BY id DESC;    
        RETURN a_id;    
END;
/

var add_author number;
call ADDAUTHOR('Calvin Harris')
into :add_author;
PRINT add_author;


CREATE OR REPLACE FUNCTION DELETEAUTHOR(
    a_authorname VARCHAR2
    ) RETURN NUMBER
AS
    a_id NUMBER;
BEGIN
    SELECT id into a_id FROM Author WHERE authorname =  a_authorname;
    DELETE FROM Author WHERE id = a_id;
    return a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN       
        RETURN 0;    
END;
/

var delete_author number;
call DELETEAUTHOR('Calvin Harris')
into :delete_author;
PRINT delete_author;


CREATE OR REPLACE FUNCTION ADDAUDIOFILE(
    a_title VARCHAR2,
    a_authorName VARCHAR2,
    a_typeOfAudio VARCHAR2,
    a_length INT
    ) RETURN NUMBER
AS
    a_id NUMBER;
    a_TypeOfAudioId NUMBER;
    a_AuthorId NUMBER;
BEGIN
    SELECT id into a_TypeOfAudioId FROM TypeOfAudio WHERE Type = a_typeOfAudio;
    SELECT id into a_AuthorId FROM Author WHERE AuthorName = a_authorName;
    SELECT id into a_id FROM AudioFile WHERE title = a_title AND
        authorId = a_AuthorId AND typeOfAudioId = a_typeOfAudioId AND length = a_length;
    RETURN a_id;    
    EXCEPTION WHEN NO_DATA_FOUND THEN
        IF a_TypeOfAudioId IS NULL then
            return 0;
        END IF;
        IF a_AuthorId IS NULL then
            return 0;
        END IF;
        INSERT INTO AudioFile (title, authorId, typeOfAudioId, length)
            VALUES (a_title, a_AuthorId, a_TypeOfAudioId, a_length);
        SELECT id INTO a_id FROM AudioFile WHERE rownum = 1
            ORDER BY id DESC;    
        RETURN a_id;    
END;
/

var add_audiofile number;
call ADDAUDIOFILE('Viva la vida', 'Coldplay', 'Song', '170')
into :add_audiofile;
PRINT add_audiofile;


CREATE OR REPLACE FUNCTION DELETEAUDIOFILE(
    a_title VARCHAR2,
    a_authorName VARCHAR2,
    a_typeOfAudio VARCHAR2,
    a_length INT
    ) RETURN NUMBER
AS
    a_id NUMBER;
    a_TypeOfAudioId NUMBER;
    a_AuthorId NUMBER;
BEGIN
    SELECT id into a_TypeOfAudioId FROM TypeOfAudio WHERE Type = a_typeOfAudio;
    SELECT id into a_AuthorId FROM Author WHERE AuthorName = a_authorName;
    SELECT id into a_id FROM AudioFile WHERE title = a_title AND
        authorId = a_AuthorId AND typeOfAudioId = a_typeOfAudioId AND length = a_length;
    DELETE FROM audiofile WHERE id = a_id;    
    RETURN a_id;    
    EXCEPTION WHEN NO_DATA_FOUND THEN
        IF a_TypeOfAudioId IS NULL then
            return 0;
        END IF;
        IF a_AuthorId IS NULL then
            return 0;
        END IF;
        RETURN 0;
END;
/

var delete_audiofile number;
call DELETEAUDIOFILE('Viva la vida', 'Coldplay', 'Songs', '170')
into :delete_audiofile;
PRINT delete_audiofile;

-- FUNKCJE SZYMONA --
-- deleteUser -- changeUserPassword -- 
-- addPlaylist -- addFileOnPlaylist -- deleteFileFromPlaylist

-- poprawione, przetestowane - adam
CREATE OR REPLACE FUNCTION ADDPLAYLIST(
    a_audiouserid NUMBER,
    a_playlistname VARCHAR2
) RETURN NUMBER
AS 
    a_id NUMBER;
    is_added NUMBER;
BEGIN 
    SELECT id into a_id FROM Playlist WHERE playlistname =  a_playlistname AND
    audiouserid = a_audiouserid;
    RETURN a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO Playlist(audiouserid, playlistname)
            VALUES (a_audiouserid, a_playlistname);
        SELECT id INTO a_id FROM Playlist WHERE rownum = 1
            ORDER BY id DESC;
    RETURN a_id;
END;
/

var add_playlist number;
call ADDPLAYLIST(5, 'Elektroniczna')
into :add_playlist;
PRINT add_playlist;

-- poprawione, przetestowane - adam
CREATE OR REPLACE FUNCTION DELETEUSER(
    a_firstname VARCHAR2,
    a_lastname VARCHAR2,
    a_email VARCHAR2,
    a_pass VARCHAR2
) RETURN NUMBER
AS
    a_id NUMBER;
BEGIN
    SELECT id into a_id FROM AudioUser WHERE firstname = a_firstname AND
    lastname = a_lastname AND email = a_email AND pass = a_pass;
    DELETE FROM AudioUser WHERE id = a_id;
    RETURN a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/


var delete_user NUMBER;
call DELETEUSER('Marcin', 'Najman', 'eltost@interia.pl', 'haslo1')
into :delete_user;
print delete_user;
    
-- poprawione, lekki refactor id dodane , przetestowane - adam
CREATE OR REPLACE FUNCTION CHANGEPASSWORD(
    a_email VARCHAR2,
    a_pass VARCHAR2,
    a_newpass VARCHAR2
) RETURN NUMBER
AS 
    a_id NUMBER;
BEGIN
    SELECT id into a_id FROM AudioUser WHERE email = a_email AND pass = a_pass;
    UPDATE AudioUser SET pass = a_newpass WHERE email = a_email AND id = a_id;
        RETURN a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN 
        RETURN 0;
END;
/

var change_password number;
call CHANGEPASSWORD('szymon@onet.pl', 'q', 'blad')
into :change_password;
PRINT change_password;


-- poprawione, przetestowane - adam
CREATE OR REPLACE FUNCTION ADDFILETOPLAYLIST(
    a_audiouserid NUMBER,
    a_audiofileid NUMBER,
    a_playlistid NUMBER
) RETURN NUMBER
AS
    a_id NUMBER;
BEGIN 
    SELECT id into a_id FROM Likes WHERE audiouserid = a_audiouserid AND
    audiofileid = a_audiofileid AND playlistid = a_playlistid;
    RETURN a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO Likes(audiouserid, audiofileid, playlistid)
            VALUES (a_audiouserid, a_audiofileid, a_playlistid);
        SELECT id INTO a_id FROM Likes WHERE rownum = 1
            ORDER BY id DESC;
        RETURN a_id;
END;
/

var add_toplaylist number;
call ADDFILETOPLAYLIST(5, 44, 21)
into :add_toplaylist;
PRINT add_toplaylist;

-- poprawione, przetestowane dziala
CREATE OR REPLACE FUNCTION DELETEFILEFROMPLAYLIST(
    a_audiouserid NUMBER,
    a_audiofileid NUMBER,
    a_playlistid NUMBER    
) RETURN NUMBER
AS 
    a_id NUMBER;
BEGIN 
    SELECT id into a_id FROM Likes WHERE audiouserid = a_audiouserid AND
    audiofileid = a_audiofileid AND playlistid = a_playlistid;
    DELETE FROM Likes WHERE id = a_id;
    RETURN a_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

var delete_toplaylist number;
call DELETEFILEFROMPLAYLIST(1, 1, 2)
into :delete_toplaylist;
PRINT delete_toplaylist;

