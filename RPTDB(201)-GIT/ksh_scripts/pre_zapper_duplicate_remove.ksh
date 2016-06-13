#!/usr/bin/ksh

today=`date +%d%b%y`
echo "export to /home/datareq/generic_etl/wip/resume_zapper_$today.ixf of ixf select T.email_id, CASE WHEN (LOCATE('198',T.pref_country) >0 AND LOCATE('355',T.pref_country) >0) THEN 'B'  WHEN LOCATE('198',T.pref_country) >0 THEN 'I' WHEN LOCATE('355',T.pref_country) >0 THEN 'G' ELSE 'U' END as PRODUCT_TYPE, T.COMPANY_NAME, T.pref_location, T.Functional_area, T.min_work_exp, T.max_work_exp, T.CONTACT_PERSON, T.address, T.Mobile_no, 'TJ' as Source, 'N' as Deleted, current timestamp as CREATED, current timestamp as UPADTED, 0 as UPDATE_BY from (select u.login_id, u.email2 as email_id, a.COMPANY_NAME, a.CONTACT_PERSON, u.tel_other as Mobile_no, u.address1 as address, replace(replace(xml2clob(xmlagg(xmlelement(NAME a, (rja.job_function )))),'<A>',''),'</A>',' ') as Functional_area, replace(replace(xml2clob(xmlagg(xmlelement(NAME a, ( rja.LOCATION )))),'<A>',''),'</A>',' ') as pref_location, replace(replace(xml2clob(xmlagg(xmlelement(NAME a, ( substr(rja.LOCATION,1,3) )))),'<A>',''),'</A>',' ') as pref_country, MIN(rja.work_exp) as min_work_exp, MAX(rja.work_exp2) as max_work_exp from user u, user_ad ua, rcrt_Job_ads rja, agent a where u.COMPANY_CONSULTANT = 'CONS' AND ua.login_id = u.login_id AND ua.posting_date =current date - 1 day AND rja.ad_id = ua.ad_id AND a.LOGIN_ID = u.login_id Group by u.login_id, u.email2, a.COMPANY_NAME, a.CONTACT_PERSON, u.tel_other, u.address1 ) T with ur" > /home/datareq/generic_etl/sql_scripts/zapper_duplicate_remove.sql

echo "alter table ECM_CONSULTANT_MAST_STAGE activate not logged initially with empty table" >> /home/datareq/generic_etl/sql_scripts/zapper_duplicate_remove.sql

echo "IMPORT FROM /home/datareq/generic_etl/wip/resume_zapper_$today.ixf OF IXF insert into ECM_CONSULTANT_MAST_STAGE" >> /home/datareq/generic_etl/sql_scripts/zapper_duplicate_remove.sql

echo "MERGE INTO TCUSER.ECM_CONSULTANT_MAST ecm USING (select EMAIL,PRODUCT_TYPE,NAME,PREF_LOC,FUNC_AREA,WORK_EXP,WORK_EXP2,CONTACT_PERSON,ADDRESS,CONTACT_NUMBER,SOURCE,DELETED,CREATED,UPDATED,UPDATE_BY from (select * FROM (SELECT EMAIL,PRODUCT_TYPE,NAME,PREF_LOC,FUNC_AREA,WORK_EXP,WORK_EXP2,CONTACT_PERSON,ADDRESS,CONTACT_NUMBER,SOURCE,DELETED,CREATED,UPDATED,UPDATE_BY,max(length(FUNC_AREA)) as len, ROWNUMBER() OVER (PARTITION BY EMAIL) AS RN FROM ECM_CONSULTANT_MAST_STAGE group by EMAIL,PRODUCT_TYPE,NAME,PREF_LOC,FUNC_AREA,WORK_EXP,WORK_EXP2,CONTACT_PERSON,ADDRESS,CONTACT_NUMBER,SOURCE,DELETED,CREATED,UPDATED,UPDATE_BY order by 16 desc) AS A WHERE RN = 1 ) tt  ) rz ON (ecm.EMAIL = rz.EMAIL) WHEN MATCHED THEN UPDATE SET ecm.PRODUCT_TYPE = rz.PRODUCT_TYPE,   ecm.NAME = rz.NAME  , ecm.PREF_LOC = rz.PREF_LOC , ecm.FUNC_AREA = rz.FUNC_AREA,ecm.WORK_EXP = rz.WORK_EXP ,  ecm.WORK_EXP2 = rz.WORK_EXP2 ,  ecm.CONTACT_PERSON = rz.CONTACT_PERSON ,ecm.ADDRESS = rz.ADDRESS ,       ecm.CONTACT_NUMBER = rz.CONTACT_NUMBER ,     ecm.SOURCE = rz.SOURCE ,        ecm.DELETED = rz.DELETED,        ecm.CREATED = rz.CREATED ,       ecm.UPDATED = rz.UPDATED  ,      ecm.UPDATE_BY = rz.UPDATE_BY WHEN NOT MATCHED THEN   INSERT (ecm.EMAIL, ecm.PRODUCT_TYPE, ecm.NAME, ecm.PREF_LOC, ecm.FUNC_AREA, ecm.WORK_EXP, ecm.WORK_EXP2, ecm.CONTACT_PERSON, ecm.ADDRESS, ecm.CONTACT_NUMBER, ecm.SOURCE, ecm.DELETED, ecm.CREATED, ecm.UPDATED, ecm.UPDATE_BY)   VALUES (rz.EMAIL, rz.PRODUCT_TYPE, rz.NAME, rz.PREF_LOC, rz.FUNC_AREA, rz.WORK_EXP, rz.WORK_EXP2, rz.CONTACT_PERSON, rz.ADDRESS, rz.CONTACT_NUMBER, rz.SOURCE, rz.DELETED, rz.CREATED, rz.UPDATED, rz.UPDATE_BY) with ur" >> /home/datareq/generic_etl/sql_scripts/zapper_duplicate_remove.sql

echo "update ECM_CONSULTANT_MAST ecm1 set ecm1.FUNC_AREA =(select FUNCTIONAL_ID from (select ecm.CODE,(select replace(replace(xml2clob(xmlagg(xmlelement(NAME a, (FM.FUNCTIONAL_ID )))),'<A>',''),'</A>',' ') from tcadmin.RCRT_FUNCTIONAL_MAS FM where LENGTH(TRIM(char(FM.FUNCTIONAL_ID))) <> -1 AND locate(trim(char(FM.FUNCTIONAL_ID)),ecm.FUNC_AREA) <> 0) AS FUNCTIONAL_ID  from ECM_CONSULTANT_MAST ecm)tt where tt.CODE = ecm1.code ) WHERE ecm1.FUNC_AREA <> '-1'"  >> /home/datareq/generic_etl/sql_scripts/zapper_duplicate_remove.sql

echo "update ECM_CONSULTANT_MAST ecm1 set ecm1.PREF_LOC =(select Prefer_Location from (select ecm.CODE,(select replace(replace(xml2clob(xmlagg(xmlelement(NAME a, (LM.LOCATION_ID )))),'<A>',''),'</A>',' ') from tcadmin.RCRT_LOCATION_MAS LM where LENGTH(TRIM(char(LM.LOCATION_ID))) > 3 AND locate(trim(char(LM.LOCATION_ID)),ecm.PREF_LOC) <> 0) AS Prefer_Location  from ECM_CONSULTANT_MAST ecm)tt where tt.CODE = ecm1.code ) WHERE ecm1.PREF_LOC <> '-1' or ecm1.PREF_LOC is not null" >> /home/datareq/generic_etl/sql_scripts/zapper_duplicate_remove.sql
