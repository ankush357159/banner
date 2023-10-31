SELECT GORGUID_GUID AS GUID,
PPI_IMAGE FROM
GORGUID, PPI, SPRIDEN
WHERE GORGUID_LDM_NAME='PERSONS' AND
GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN_SURROGATE_ID
AND SPRIDEN_PIDM = PPI_PIDM
AND GORGUID_GUID IN (:GUID_LIST);

-----------------------------------------------------------------
----------INSERT INTO PPI (ppi_id, ppi_image, ppi_pidm)----------
----------VALUES (1, EMPTY_BLOB(), 36841);-----------------------
----------gorguid_guid='1bb55ed3-3772-40a9-be4a-836e871a4416'----
----------gorguid_domain_surrogate_id='378'----------------------
-----------------------------------------------------------------

SELECT GORGUID_GUID AS GUID, IMG_NAME
FROM GORGUID, SPRIDEN, PPI,
WHERE GORGUID_LDM_NAME = LOWER('PERSONS')
AND GORGUID_DOMAIN_SURROGATE_ID = SPRIDEN_SURROGATE_ID
AND SPRIDEN_PIDM = PPI_PIDM
AND GORGUID_GUID IN (:GUID_LIST)