alter table HOURLY_APPLICATION_REPORT_TMP activate not logged initially with empty table

IMPORT FROM /home/datareq/generic_etl/wip/Application_Status_Daily_load_v2.csv OF DEL insert into HOURLY_APPLICATION_REPORT_TMP

export to /home/datareq/generic_etl/wip/Application_Status_Daily_v2.csv of del modified by coldel, datesiso select char(current date -1 day,ISO),har.SOURCE_ID as JOB_SOURCE, CASE WHEN har.SOURCE_CODE = 'TOTAL' then '** '||har.SOURCE_CODE||' **' else jas.SOURCE_GROUP end as SOURCE_GROUP, CASE WHEN har.SOURCE_CODE = 'TOTAL' then '-------' else har.SOURCE_CODE end as SOURCE_CODE, CASE WHEN har.SOURCE_CODE = 'TOTAL' then '-------' else jas.SOURCE_DESC end as SOURCE_DESC, har.NATIVE_JOBS_COUNT, har.TRANSCRIBED_JOBS_COUNT AS STR from HOURLY_APPLICATION_REPORT_TMP har left join HOURLY_APPLICATION_SOURCE_GROUP_LOOKUP jas on (har.SOURCE_CODE = jas.SOURCE_CODE) with ur

