MERGE INTO CALLING_RPC_DATA crd USING (select max(SUBSTR(UPDATED_DATE, 7, 4) ||'-'|| SUBSTR(UPDATED_DATE, 4, 2) ||'-'||SUBSTR(UPDATED_DATE, 1, 2)) as UPDATED_DATE , max(CENTER_NAME) as CENTER_NAME, max(CAMPAIGN_NAME) as CAMPAIGN_NAME, MOBILE_NO , max(RESPONSE) as RESPONSE, max(DISPOSITION_STATUS) as DISPOSITION_STATUS from CALLING_RPC_DATA_STAGE group by MOBILE_NO) crds ON (crd.MOBILE_NO = crds.MOBILE_NO) WHEN NOT MATCHED THEN    INSERT (crd.UPDATED_DATE, crd.CENTER_NAME, crd.CAMPAIGN_NAME, crd.MOBILE_NO, crd.STATUS, crd.DISPOSITION_STATUS)    VALUES (crds.UPDATED_DATE,crds.CENTER_NAME,crds.CAMPAIGN_NAME,crds.MOBILE_NO,crds.RESPONSE,crds.DISPOSITION_STATUS)

--export to /home/datareq/generic_etl/wip/REC_LOADED.txt of del modified by coldel, datesiso select distinct CHAR(UPDATED_DATE,ISO) from CALLING_RPC_DATA where CENTER_NAME='Effort' with ur
