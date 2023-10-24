CREATE TABLE PPI (
    ppi_id NUMBER PRIMARY KEY,
    ppi_image BLOB,
    ppi_pidm NUMBER(8,0)
);

create public synonym PPI for baninst1.PPI; 
grant select,insert,delete,update on PPI to ban_default_q; 
grant select,insert,delete,update on PPI to ban_default_m; 
grant select,insert,delete,update on PPI to general;

INSERT INTO PPI (ppi_id, ppi_image, ppi_pidm)
VALUES (1, EMPTY_BLOB(), 36841);

select * from GTVSQPR where gtvsqpr_code like 'IM%';
select * from GTVSQRU where gtvsqru_code like 'IM%';
select * from GTVSQPA where gtvsqpa_code like 'GUID_LIST%';