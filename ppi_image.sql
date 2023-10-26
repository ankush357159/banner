CREATE TABLE PPI (
    ppi_id NUMBER PRIMARY KEY,
    ppi_image BLOB,
    ppi_pidm NUMBER(8,0),
    IMG_NAME VARCHAR2(60 BYTE)
);

create public synonym PPI for baninst1.PPI; 
grant select,insert,delete,update on PPI to ban_default_q; 
grant select,insert,delete,update on PPI to ban_default_m; 
grant select,insert,delete,update on PPI to general;

INSERT INTO PPI (ppi_id, ppi_image, ppi_pidm)
VALUES (1, EMPTY_BLOB(), 36841);

gorguid_guid='1bb55ed3-3772-40a9-be4a-836e871a4416'
gorguid_domain_surrogate_id='378'

select * from GTVSQPR where gtvsqpr_code like 'IM%';
select * from GTVSQRU where gtvsqru_code like 'IM%';
select * from GTVSQPA where gtvsqpa_code like 'GUID_LIST%';