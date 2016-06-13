export to /home/datareq/generic_etl/data_files/dial_bpo_cand.csv of del modified by coldel, datesiso select date(current date - 1 DAY) as REPORT_DATE, 1 as PARAMETER_KEY, 'Total Resume' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID UNION select date(current date - 1 DAY) as REPORT_DATE, 2 as PARAMETER_KEY, 'Active Resume (3 Months)' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND U.LAST_LOGIN_DATE >= current date - 3 month UNION select date(current date - 1 DAY) as REPORT_DATE, 3 as PARAMETER_KEY, 'Active Resume (1 Month)' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND U.LAST_LOGIN_DATE >= current date - 1 month UNION select date(current date - 1 DAY) as REPORT_DATE, 4 as PARAMETER_KEY, 'Active Resume (1 Month)- VC' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND U.LAST_LOGIN_DATE >= current date - 1 month AND BVU.HAS_UPLOADED_VOICE IN ('Y','y') UNION select date(current date - 1 DAY) as REPORT_DATE, 5 as PARAMETER_KEY, 'Active Resume (1 Month)- w/o VC' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND U.LAST_LOGIN_DATE >= current date - 1 month AND BVU.HAS_UPLOADED_VOICE NOT IN ('Y','y') UNION select date(current date - 1 DAY) as REPORT_DATE, 6 as PARAMETER_KEY, 'Active Resume (7 Days)' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND U.LAST_LOGIN_DATE >= current date - 7 days UNION select date(current date - 1 DAY) as REPORT_DATE, 7 as PARAMETER_KEY, 'Active Resume (7 Days) - VC' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND U.LAST_LOGIN_DATE >= current date - 7 days AND BVU.HAS_UPLOADED_VOICE IN ('Y','y') UNION select date(current date - 1 DAY) as REPORT_DATE, 8 as PARAMETER_KEY, 'Active Resume (7 Days) - w/o VC' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND U.LAST_LOGIN_DATE >= current date - 7 days AND BVU.HAS_UPLOADED_VOICE NOT IN ('Y','y') UNION select date(current date - 1 DAY) as REPORT_DATE, 9 as PARAMETER_KEY, 'Profiles w/o Voice Clips' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER BVU, USER U Where U.LOGIN_ID = BVU.LOGIN_ID AND BVU.HAS_UPLOADED_VOICE NOT IN ('Y','y') UNION select date(current date - 1 DAY) as REPORT_DATE, 10 as PARAMETER_KEY, '% Complete Resumes' as PARAMETER_NAME, 0 as PARAMETER_VALUE from sysibm.sysdummy1 UNION select date(current date - 1 DAY) as REPORT_DATE, 11 as PARAMETER_KEY, 'New Registrations' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER Where Date(CREATED_DATE) = current date - 1 day UNION select date(current date - 1 DAY) as REPORT_DATE, 12 as PARAMETER_KEY, 'New Registrations (IVR)' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER Where Date(CREATED_DATE) = current date - 1 day and CALL_USERXML_ID IS NOT NULL UNION select date(current date - 1 DAY) as REPORT_DATE, 13 as PARAMETER_KEY, 'New Registrations (Online)' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER Where Date(CREATED_DATE) = current date - 1 day and CALL_USERXML_ID IS NULL UNION select date(current date - 1 DAY) as REPORT_DATE, 14 as PARAMETER_KEY, 'New Registrations (Profiles with Voice Clips)' as PARAMETER_NAME, coalesce(count(1), 0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER Where Date(CREATED_DATE) = current date - 1 day and HAS_UPLOADED_VOICE IN ('Y','y') UNION select date(current date - 1 DAY) as REPORT_DATE, 15 as PARAMETER_KEY, 'Total Applications Received' as PARAMETER_NAME, coalesce(count(SIR.RESUME_ID),0) as PARAMETER_VALUE from tcuser.VERTICAL_JOB_DETAIL VJD, USER_AD UA, tcuser.SITE_INBOX_RESPONSE SIR WHERE UA.AD_ID = VJD.JOB_ID AND UA.NET_STATUS = 11 AND SIR.AD_ID = UA.AD_ID AND SIR.DATE_RESPONDED = Current date - 1 day UNION select date(current date - 1 DAY) as REPORT_DATE, 16 as PARAMETER_KEY, 'Unique Candidate Applied' as PARAMETER_NAME, coalesce(count(distinct SIR.RESUME_ID),0) as PARAMETER_VALUE from tcuser.VERTICAL_JOB_DETAIL VJD, USER_AD UA, tcuser.SITE_INBOX_RESPONSE SIR WHERE UA.AD_ID = VJD.JOB_ID AND UA.NET_STATUS = 11 AND SIR.AD_ID = UA.AD_ID AND SIR.DATE_RESPONDED = Current date - 1 day UNION select date(current date - 1 DAY) as REPORT_DATE, 17 as PARAMETER_KEY, 'Profiles Edit/Update' as PARAMETER_NAME, coalesce(count(1),0) as PARAMETER_VALUE from tcuser.BPO_VARTICAL_USER Where Date(MODIFIED_DATE) = current date - 1 day AND date(CREATED_DATE) < current date - 1 day UNION select date(current date - 1 DAY) as REPORT_DATE, 28 as PARAMETER_KEY, 'Total SMS Alerts Sent' as PARAMETER_NAME, coalesce(count(1),0) as PARAMETER_VALUE from MAIL_TRACK MT,tcuser.BPO_VARTICAL_USER BVU WHERE MT.LOGIN_ID = BVU.LOGIN_ID AND MT.COMBINATION_ID = 23004 and date(MT.CREATE_DATETIME) = current date - 1 day with ur