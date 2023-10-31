DECLARE
    LV_IMAGE_NAME PPI.IMG_NAME%TYPE;

    PROCEDURE UPDATE_IMAGE_NAME (
        P_GUID GORGUID.GORGUID_GUID%TYPE,
        P_IMAGE_NAME PPI.IMG_NAME%TYPE
    ) IS
    BEGIN
        IF P_GUID IS NOT NULL THEN
            UPDATE PPI
            SET IMG_NAME = P_IMAGE_NAME
            WHERE PPI_PIDM IN (
                SELECT SPRIDEN_PIDM
                FROM SPRIDEN
                WHERE SPRIDEN_SURROGATE_ID = (
                    SELECT GORGUID_DOMAIN_SURROGATE_ID
                    FROM GORGUID
                    WHERE GORGUID_GUID = P_GUID
                    AND GORGUID_LDM_NAME = LOWER('PERSONS')
                )
            );
            COMMIT;
        END IF;
    END UPDATE_IMAGE_NAME;

BEGIN
    IF :HTTP_METHOD = ('PUT') THEN
        IF :GUID_LIST IS NOT NULL THEN
            LV_IMAGE_NAME := :IMAGE_NAME ;
            UPDATE_IMAGE_NAME(:GUID_LIST, LV_IMAGE_NAME);
        END IF;
    END IF;
END;