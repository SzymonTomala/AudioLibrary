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
