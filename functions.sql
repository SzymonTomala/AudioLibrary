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

var solution number;
call SIGNUP('Marcin', 'Najman', 'eltost@interia.pl', 'haslo1')
into :solution;
