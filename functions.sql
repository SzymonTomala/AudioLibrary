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
