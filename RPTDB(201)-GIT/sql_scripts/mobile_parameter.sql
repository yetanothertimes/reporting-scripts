export to /home/datareq/generic_etl/data_files/mobile_parameter.csv of del modified by coldel, datesiso select ID,TITLE,LOGIN_CREATE_DATE,COUNTS from (select 3001 as id, 'unique_logins_last_90_days' as title,current date - 1 day as LOGIN_CREATE_DATE,count(distinct LU.LOGIN_ID) as counts, 1 as order_field from LOGIN_USAGE_HISTORY LU where LU.LOGIN_TIME between current timestamp - 90 days and current timestamp AND LU.LOGIN_TYPE IN ('TJANDRD', 'TJIOS','TJMOB') UNION select 3002 as id, 'logins_exp_less_than_2_year' as title,current date - 1 day as LOGIN_CREATE_DATE,count(distinct LU.LOGIN_ID)as counts, 2 as order_field from LOGIN_USAGE_HISTORY LU, USER_AD UA , RCRT_RESUME_ADS RRA where LU.LOGIN_TIME between current timestamp - 90 days and current timestamp AND LU.LOGIN_TYPE IN ('TJANDRD', 'TJIOS','TJMOB') AND UA.LOGIN_ID = LU.LOGIN_ID AND RRA.AD_ID = UA.AD_ID AND RRA.WORK_EXP <=2 UNION select 3003 as id, 'logins_exp_more_than_2_year' as title,current date - 1 day as LOGIN_CREATE_DATE,count(distinct LU.LOGIN_ID) as counts, 3 as order_field from LOGIN_USAGE_HISTORY LU, USER_AD UA , RCRT_RESUME_ADS RRA where LU.LOGIN_TIME between current timestamp - 90 days and current timestamp AND LU.LOGIN_TYPE IN ('TJANDRD', 'TJIOS','TJMOB') AND UA.LOGIN_ID = LU.LOGIN_ID AND RRA.AD_ID = UA.AD_ID AND RRA.WORK_EXP > 2 UNION select 3004 as id,'logins_more_than_1_times_mob' as title,current date - 1 day as LOGIN_CREATE_DATE,count(distinct T.LOGIN_ID) as counts, 4 as order_field from (select LU.LOGIN_ID from LOGIN_USAGE_HISTORY LU where LU.LOGIN_TIME between current timestamp - 90 days and current timestamp AND LU.LOGIN_TYPE IN ('TJANDRD', 'TJIOS','TJMOB') group by LU.LOGIN_ID HAVING count(LU.LOGIN_ID) > 1) T UNION select 3005 as id,'logins_less_than_2_times_mob' as title, current date - 1 day as LOGIN_CREATE_DATE,count(distinct T.LOGIN_ID) as counts, 5 as order_field from (select LU.LOGIN_ID from LOGIN_USAGE_HISTORY LU where LU.LOGIN_TIME between current timestamp - 90 days and current timestamp AND LU.LOGIN_TYPE IN ('TJANDRD', 'TJIOS','TJMOB') group by LU.LOGIN_ID HAVING count(LU.LOGIN_ID) = 1) T UNION select 3006 as id,'daily_registrations_mobile' as title,current date - 1 day as LOGIN_CREATE_DATE,count(LOGIN_ID) as counts, 6 as order_field from USER where LOGIN_CREATE_DATE = current date - 1 day and REGISTRATION_SOURCE IN ('TJANDRD', 'TJIOS','TJMOB') UNION select 3007 as id, 'total_logins' as title,current date - 1 day as LOGIN_CREATE_DATE,count(distinct LU.LOGIN_ID) as counts, 7 as order_field from LOGIN_USAGE_HISTORY LU where LU.LOGIN_TYPE IN ('TJANDRD', 'TJIOS','TJMOB') order by order_field ) mob_para with ur


