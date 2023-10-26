DECLARE
    lv_pidm spriden.spriden_pidm%TYPE;
    lv_image BLOB; 
    gorguid_ldm_name VARCHAR2(100 CHAR); 

    PROCEDURE update_ppi_image(
        p_pidm spriden.spriden_pidm%TYPE,
        p_image BLOB 
    ) IS
    BEGIN 
        UPDATE PPI
        SET ppi_image = p_image
        WHERE ppi_pidm = p_pidm;
    END;

BEGIN
    IF :http_method IN ('PUT', 'POST') THEN
        IF gorguid_ldm_name = 'persons' THEN            
            SELECT spriden_pidm INTO lv_pidm
            FROM spriden
            WHERE spriden_surrogate_id = :spriden_surrogate_id;

            IF lv_pidm = :ppi_pidm AND :GUID_LIST IS NOT NULL THEN
                update_ppi_image(lv_pidm, :ppi_image);
            END IF;
        END IF;
    END IF;
END;


-- Update only 
DECLARE
    lv_pidm spriden.spriden_pidm%TYPE;
    gorguid_ldm_name VARCHAR2(100 CHAR);

    PROCEDURE update_ppi_image(
        p_pidm spriden.spriden_pidm%TYPE
    ) IS
    BEGIN
        UPDATE PPI
        SET img_name = :NEW_IMAGE_NAME 
        WHERE ppi_pidm = p_pidm;
    END;

BEGIN
    IF :http_method IN ('PUT', 'POST') THEN
        IF gorguid_ldm_name = 'persons' THEN
            SELECT spriden_pidm INTO lv_pidm
            FROM spriden
            WHERE spriden_surrogate_id IN (
                SELECT gorguid_domain_surrogate_id
                FROM gorguid
                WHERE gorguid_ldm_name = 'persons'
                AND gorguid_guid IN (:GUID_LIST)
            );

            IF lv_pidm IS NOT NULL THEN
                update_ppi_image(lv_pidm); 
            END IF;
        END IF;
    END IF;
END;

