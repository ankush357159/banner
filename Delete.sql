-------------------------------
--Below Script Is Not Required 
-------------------------------
DECLARE
    v_blob BLOB;
    v_bfile BFILE := BFILENAME('MY_DIR', 'sample-text.txt');
BEGIN
    DBMS_LOB.fileopen(v_bfile, DBMS_LOB.file_readonly);
    DBMS_LOB.createtemporary(v_blob, TRUE);
    DBMS_LOB.loadfromfile(v_blob, v_bfile, DBMS_LOB.getlength(v_bfile));

    -- Delete image with id = 2
    DELETE FROM binary_data WHERE id = 2;
--    Delete image with image name 'sample-text.txt'
--    DELETE FROM binary_data WHERE image_name = 'sample-text.txt';

    DBMS_LOB.fileclose(v_bfile);
    DBMS_LOB.freetemporary(v_blob);
END;