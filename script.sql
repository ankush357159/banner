--Create a Directory Object which points to the physical directory containing file
CREATE OR REPLACE DIRECTORY my_dir AS 'C:\Ankush\MyProjects\pl-sql\blob';
SELECT * FROM all_directories WHERE directory_name = 'MY_DIR';
CREATE OR REPLACE DIRECTORY dir AS '/c/Ankush/MyProjects/pl-sql/blob';
SELECT directory_name, directory_path FROM all_directories;
select * from all_directories;


HOST dir C:\Ankush\MyProjects\pl-sql\blob

select * from ppi;
INSERT into ppi (ppi_id, ppi_pidm, img_name) values (2, 36842, 'hi.gif');
select SPRIDEN_PIDM, SPRIDEN_FIRST_NAME from spriden;
delete from ppi where ppi_pidm='36842';

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
Set serveroutput on 
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
select * from GTVSQRU where gtvsqru_code like 'APP%'; --APP_PPI_RULE_READ, APP_PPI_RULE_UPDATE
select * from GTVSQPA where gtvsqpa_code like 'GUID%'; --GUID_LIST, GUID
select * from GORRSQL where GORRSQL_SQPR_CODE like 'APP%'; --APP_EXTENSIONS -> APP_PPI_RULE_READ, APP_PPI_RULE_UPDATE
--extension-codes:    "id": 142
--extension-definitions: "id": 182, "id": 185,
--extension-versions: "id": 195, "id": 129,

select * from GTVSQPR where gtvsqpr_code like 'APP%'; --APP_EXTENSIONS
select * from GTVSQRU where gtvsqru_code like 'IPP%'; --IPP_READ
select * from GTVSQPA where gtvsqpa_code like 'GUID%'; --GUID_LIST, GUID
select * from GORSQPA where GORSQPA_SQPR_CODE like 'APP%';--APP_EXTENSIONS -> GUID_LIST, GUID
select * from GORRSQL where GORRSQL_SQPR_CODE like 'APP%'; --APP_EXTENSIONS -> IPP_READ
--extension-codes:    "id": 41
--extension-definitions: "id": 202 
--extension-versions: "id": 62
--extension-versions
--{
--        "id": 62,
--        "extensionCode": "ANK_IMAGE_EXTEND",
--        "comment": "Extend image to persons",
--        "resourceName": "persons",
--        "knownMediaType": "application/vnd.hedtech.integration.v12.3.0+json"
--}

SELECT GORGUID_GUID AS GUID,
IPP_IMAGE FROM
GORGUID, IPP, SPRIDEN
WHERE GORGUID_LDM_NAME='PERSONS' AND
GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN_SURROGATE_ID
AND SPRIDEN_PIDM = IPP_PIDM
AND GORGUID_GUID IN (:GUID_LIST)

select * from gorguid where GORGUID_GUID='1bb55ed3-3772-40a9-be4a-836e871a4416'
describe gorguid;
describe GORSQPA
--Example code for UPDATE operation
--Similar code is required for 

CREATE TABLE IPP (
    ipp_id NUMBER PRIMARY KEY,
    ipp_image VARCHAR2(4000 BYTE),
    ipp_cimage CLOB,
    ipp_bimage BLOB,    
    ipp_pidm NUMBER(8,0),
    ipp_name VARCHAR2(60 BYTE),
    ipp_type VARCHAR2(60 BYTE)
);
create public synonym IPP for baninst1.IPP;
grant select,insert,delete,update on IPP to ban_default_q; 
grant select,insert,delete,update on IPP to ban_default_m; 
grant select,insert,delete,update on IPP to general;

INSERT into ipp (ipp_id, ipp_image, ipp_pidm, ipp_type) values (2, 36842, 'gif');
INSERT into ipp (ipp_id, ipp_image, ipp_pidm, ipp_type) values (1, :ipp_image, :ipp_pidm, :ipp_type);
select * from ipp;
select * from ppi;

select gorguid_guid as guid,
ipp_image from
gorguid, ipp, spriden
where gorguid_ldm_name='persons' and
gorguid_domain_surrogate_id = spriden_surrogate_id
and spriden_pidm = ipp_pidm
and gorguid_guid in (:GUID_LIST)



SELECT GORGUID_GUID AS GUID,
IPP_IMAGE FROM
GORGUID, IPP, SPRIDEN
WHERE GORGUID_LDM_NAME=LOWER('PERSONS') AND
GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN_SURROGATE_ID
AND SPRIDEN_PIDM = IPP_PIDM
AND GORGUID_GUID IN (:GUID_LIST);

SELECT GORGUID_GUID AS GUID,
IPP_IMAGE FROM
GORGUID, IPP, SPRIDEN
WHERE GORGUID_LDM_NAME=LOWER('PERSONS') AND
GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN_SURROGATE_ID
AND SPRIDEN_PIDM = IPP_PIDM
AND GORGUID_GUID IN (:GUID_LIST);

SELECT GORGUID_GUID AS GUID, IMG_NAME
FROM GORGUID, PPI, SPRIDEN
WHERE GORGUID_LDM_NAME = LOWER('PERSONS')
AND GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN.SPRIDEN_SURROGATE_ID
AND SPRIDEN_PIDM = PPI.PPI_PIDM
AND GORGUID.GORGUID_GUID IN (:GUID_LIST)

update ipp set ipp_image = 'Testing done' where ipp_id='1'
UPDATE ppi SET img_name = :TEXT WHERE ppi_id = '1';
UPDATE ppi SET img_name = :TEXT WHERE ppi_id = '1';


select * from spriden where spriden_pidm='36842'
select * from gorguid where GORGUID_DOMAIN_SURROGATE_ID = '379'
and gorguid_ldm_name='persons';
select * from gorguid where gorguid_guid='779c0252-9a51-4283-b2d6-73207991a3cd';
select * from spriden where spriden_surrogate_id='2';

select * from ipp;
select * from ppi where ppi_id=2;
ALTER TABLE PPI MODIFY IMG_NAME VARCHAR2(4000);
describe ppi;
SELECT * FROM gurapvr;
select * from spriden where SPRIDEN_SURROGATE_ID = '1';




DECLARE
    LV_PIDM SPRIDEN.SPRIDEN_PIDM%TYPE;
    LV_IMAGE_NAME PPI.IMG_NAME%TYPE;

    PROCEDURE PROC_IMAGE_NAME (
        P_PIDM SPRIDEN.SPRIDEN_PIDM%TYPE,
        P_IMAGE_NAME PPI.IMG_NAME%TYPE
    ) IS
    BEGIN
        UPDATE PPI
        SET IMG_NAME = P_IMAGE_NAME
        WHERE PPI_PIDM = P_PIDM;

        COMMIT;
    END PROC_IMAGE_NAME;

BEGIN
    IF :HTTP_METHOD IN ('PUT') THEN
        IF :IMG_NAME IS NOT NULL OR DBMS_LOB.GETLENGTH(:IMG_NAME) > 0 THEN
            SELECT TO_CHAR(GORGUID_DOMAIN_KEY), PPI.IMG_NAME AS IMAGE_NAME
            INTO LV_PIDM, LV_IMAGE_NAME
            FROM GORGUID
            JOIN SPRIDEN ON GORGUID.GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN.SPRIDEN_SURROGATE_ID
            JOIN IPP ON SPRIDEN.SPRIDEN_PIDM = IPP.IPP_PIDM
            JOIN PPI ON SPRIDEN.SPRIDEN_PIDM = PPI.PPI_PIDM
            WHERE GORGUID.GORGUID_LDM_NAME = LOWER('PERSONS')
            AND GORGUID.GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN.SPRIDEN_SURROGATE_ID
            AND SPRIDEN.SPRIDEN_PIDM = IPP.IPP_PIDM
            AND GORGUID.GORGUID_GUID IN (:GUID_LIST);

            PROC_IMAGE_NAME(LV_PIDM, LV_IMAGE_NAME);
        END IF; 
    END IF;
END;




select * from ppi
UPDATE ppi
SET img_name = :img
WHERE ppi_pidm = '36503';
INSERT into ppi (ppi_id, ppi_pidm, img_name) values (9, 37178, 'I am nube');
select * from spriden where SPRIDEN_pidm = '37130';
select * from gorguid where GORGUID_DOMAIN_SURROGATE_ID = '2' and gorguid_ldm_name='persons';
select * from gorguid where gorguid_guid = '49e72211-3c8a-4ef8-836c-425e2308c675';
select * from spriden where spriden_surrogate_id='6567';
select * from spriden where spriden_surrogate_id='5';
select * from gorguid where gorguid_guid = '961bbf64-31bc-4d06-85c7-a06c3a67984b';
select * from gorguid where gorguid_guid = '49e72211-3c8a-4ef8-836c-425e2308c675';
select * from gorguid where gorguid_guid = '7be4ec28-846b-42d1-931c-4e1c0e44d60d';


