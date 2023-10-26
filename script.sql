--Create a Directory Object which points to the physical directory containing file
CREATE OR REPLACE DIRECTORY my_dir AS 'C:\Ankush\MyProjects\pl-sql\blob';
SELECT * FROM all_directories WHERE directory_name = 'MY_DIR';
CREATE OR REPLACE DIRECTORY dir AS '/c/Ankush/MyProjects/pl-sql/blob';
SELECT directory_name, directory_path FROM all_directories;


HOST dir C:\Ankush\MyProjects\pl-sql\blob

select * from ppi;
select SPRIDEN_PIDM, SPRIDEN_FIRST_NAME from spriden;

--Create new image
Set serveroutput on 
DECLARE
    v_blob BLOB;
    v_bfile BFILE := BFILENAME('MY_DIR', 'bee.jpg'); 
BEGIN
    DBMS_LOB.fileopen(v_bfile, DBMS_LOB.file_readonly);
    DBMS_LOB.createtemporary(v_blob, TRUE);
    DBMS_LOB.loadfromfile(v_blob, v_bfile, DBMS_LOB.getlength(v_bfile));

    INSERT INTO ppi(ppi_id, ppi_image) VALUES (2, v_blob);

    DBMS_LOB.fileclose(v_bfile);
    DBMS_LOB.freetemporary(v_blob);
    COMMIT; 
  DBMS_OUTPUT.PUT_LINE('Image inserted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

select CASE dbms_lob.fileexists(bfilename('MY_DIR', 'bee.jpg'))
          WHEN 0 THEN 'File does not exist or it is not accessible'
          WHEN 1 THEN 'File exists'
       END AS check_if_exists
       FROM DUAL;
exec LoadFileIntoBLOB('bee.jpg','MY_DIR');       
--Update image
DECLARE
    v_blob BLOB;
    v_bfile BFILE := BFILENAME('MY_DIR', 'bee.jpg'); -- New image file
    v_ppi_id NUMBER := 1; -- ID of the record to update
BEGIN
    DBMS_LOB.fileopen(v_bfile, DBMS_LOB.file_readonly);
    DBMS_LOB.createtemporary(v_blob, TRUE);
    DBMS_LOB.loadfromfile(v_blob, v_bfile, DBMS_LOB.getlength(v_bfile));

    UPDATE ppi
    SET ppi_image = v_blob
    WHERE ppi_id = v_ppi_id;

    DBMS_LOB.fileclose(v_bfile);
    DBMS_LOB.freetemporary(v_blob);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Image updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

select * from ppi;


select gorguid_guid as guid,
ppi_image from
gorguid, ppi, spriden
where gorguid_ldm_name='persons' and
gorguid_domain_surrogate_id = spriden_surrogate_id
and spriden_pidm = ppi_pidm
and gorguid_guid in (:GUID_LIST);

select * from GTVSQPR where gtvsqpr_code like 'APP%'; --APP_EXTENSIONS
select * from GTVSQRU where gtvsqru_code like 'APP%'; --APP_IMAGE_READ
select * from GTVSQPA where gtvsqpa_code like 'GUID%'; --GUID_LIST, GUID
select * from GORRSQL where GORRSQL_SQPR_CODE like 'APP%'; --APP_EXTENSIONS -> APP_IMAGE_READ
--extension-codes: "id": 122
--extension-definitions: "id": 163
--extension-versions: "id": 195


DECLARE
    lv_pidm spriden.spriden_pidm%TYPE;
    
    PROCEDURE proc_lic_iss_date (
    p_pidm spriden.spriden_pidm%TYPE,
    p_lic_issue_date spbpers.SPBPERS_LICENSE_ISSUED_DATE%TYPE    
    ) IS
    BEGIN
        UPDATE SPBPERS SET SPBPERS_LICENSE_ISSUED_DATE = p_lic_issue_date,
        spbpers_activity_date = sysdate where spbpers_pidm = lv_pidm;
    END;
BEGIN
    IF :HTTP_METHOD IN ('PUT') THEN
        IF (to_char(:LIC_ISSUE_DATE) != dml_common.unspecified_string ) THEN
        SELECT
            to_char(gorguid_domain_key)
        INTO lv_pidm
        FROM gorguid WHERE gorguid_guid IN (:GUID);
        
        proc_lic_iss_date(lv_pidm, to_date(:LIC_ISSUE_DATE, 'YYYY-MM-DD'))
        
        END IF;
    END IF;
END;



