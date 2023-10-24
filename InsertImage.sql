CREATE OR REPLACE DIRECTORY my_dir AS 'C:\Ankush\MyProjects\pl-sql\blob';
SELECT * FROM all_directories WHERE directory_name = 'MY_DIR';

select * from ppi;
INSERT INTO binary_data (id, image)
VALUES (1, empty_blob());

--Create new image
DECLARE
    v_blob BLOB;
    v_bfile BFILE := BFILENAME('MY_DIR', 'bee.jpg'); 
BEGIN
    DBMS_LOB.fileopen(v_bfile, DBMS_LOB.file_readonly);
    DBMS_LOB.createtemporary(v_blob, TRUE);
    DBMS_LOB.loadfromfile(v_blob, v_bfile, DBMS_LOB.getlength(v_bfile));

    INSERT INTO ppi(ppi_id, ppi_image) VALUES (1, v_blob);

    DBMS_LOB.fileclose(v_bfile);
    DBMS_LOB.freetemporary(v_blob);
END;

SELECT * from binary_data;