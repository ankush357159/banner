-- GUID, IMAGE, LAST_NAME, FIRST_NAME
select gorguid_guid as guid,
ppi_image IMAGE,spriden.SPRIDEN_LAST_NAME AS Last_Name,
    spriden.SPRIDEN_FIRST_NAME AS First_Name  from
gorguid,ppi,spriden
where gorguid_ldm_name='persons' and
gorguid_domain_surrogate_id = spriden_surrogate_id
and spriden_pidm = ppi_pidm
and gorguid_guid in (:GUID_LIST)


-- GUID AND IMAGE_NAME AS IMAGE
SELECT gorguid_guid AS guid,
       img_name AS IMAGE
FROM gorguid, ppi, spriden
WHERE gorguid_ldm_name = 'persons'
  AND gorguid_domain_surrogate_id = spriden_surrogate_id
  AND spriden_pidm = ppi_pidm
  AND gorguid_guid IN (:GUID_LIST);
  

-- GUID and LEGACY_CODE
SELECT gorguid_guid AS guid,
       SPBPERS_LGCY_CODE AS LEGACY_CODE
FROM gorguid, SPBPERS, spriden
WHERE gorguid_ldm_name = 'persons'
AND gorguid_domain_surrogate_id = spriden_surrogate_id
AND spriden_pidm = spbpers_pidm
AND gorguid_guid IN (:GUID_LIST);