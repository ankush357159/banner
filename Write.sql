DECLARE
    lv_pidm spriden.spriden_pidm%TYPE;
    lv_image BLOB; 
    gorguid_ldm_name VARCHAR2(100 CHAR); 

    PROCEDURE insert_ppi_image(
        p_pidm spriden.spriden_pidm%TYPE,
        p_image BLOB 
    ) IS
    BEGIN 
        INSERT INTO PPI (ppi_pidm, ppi_image)
        VALUES (p_pidm, p_image);
    END;

BEGIN
    IF :http_method IN ('POST') THEN
        IF gorguid_ldm_name = 'persons' THEN            
            SELECT spriden_pidm INTO lv_pidm
            FROM spriden
            WHERE spriden_surrogate_id = :spriden_surrogate_id;

            IF lv_pidm = :ppi_pidm AND :GUID_LIST IS NOT NULL THEN
                insert_ppi_image(lv_pidm, :ppi_image);
            END IF;
        END IF;
    END IF;
END;
