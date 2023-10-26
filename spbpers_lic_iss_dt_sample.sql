-- Example of UPDATE METHOD
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