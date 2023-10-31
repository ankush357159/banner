-- GUID and LEGACY_CODE
SELECT gorguid_guid AS guid,
       SPBPERS_LGCY_CODE AS LEGACY_CODE
FROM gorguid, SPBPERS, spriden
WHERE gorguid_ldm_name = 'persons'
AND gorguid_domain_surrogate_id = spriden_surrogate_id
AND spriden_pidm = spbpers_pidm
AND gorguid_guid IN (:GUID_LIST);