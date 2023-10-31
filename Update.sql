DECLARE
    PROCEDURE UPDATE_IMAGE_NAME (
        P_GUID GORGUID.GORGUID_GUID%TYPE,
        P_IMG_NAME PPI.IMG_NAME%TYPE
    ) IS
    BEGIN
        IF P_GUID IS NOT NULL THEN
            UPDATE PPI
            SET IMG_NAME = P_IMG_NAME
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
    IF :HTTP_METHOD = ( 'PUT' ) AND :GUID IS NOT NULL THEN
        UPDATE_IMAGE_NAME(:GUID , :IMG_NAME);
    END IF;
END;