select gorguid_guid as guid,
ppi_image IMAGE,spriden.SPRIDEN_LAST_NAME AS Last_Name,
    spriden.SPRIDEN_FIRST_NAME AS First_Name  from
gorguid,ppi,spriden
where gorguid_ldm_name='persons' and
gorguid_domain_surrogate_id = spriden_surrogate_id
and spriden_pidm = ppi_pidm
and gorguid_guid in (:GUID_LIST)