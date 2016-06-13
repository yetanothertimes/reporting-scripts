export to /home/datareq/generic_etl/wip/Chandan_data_Total_ab_test.csv of del modified by coldel, datesiso  select u.login_create_date,ua.SOURCE,         CASE WHEN lc.NET_STATUS IN (-3,20) THEN 'STAGE_1' ELSE 'STAGE2' END , count(distinct u.login_id)  from user u,       user_ad ua,       lead_capture lc  where u.login_create_date = current date - 1 day    and ua.login_id = u.login_id    and lc.ad_id = ua.ad_id    and lc.CAMPAIGN_ID = '3p9901'    and ua.SOURCE IN ('versionA_B','versionA_J','versionB_B','versionB_J')    and u.NET_STATUS IN (1,5,7)  group by u.login_create_date,ua.SOURCE,CASE WHEN lc.NET_STATUS IN (-3,20) THEN 'STAGE_1' ELSE 'STAGE2' END with ur

export to /home/datareq/generic_etl/wip/Chandan_data_with_resume_ab_test.csv of del modified by coldel, datesiso  select u.login_create_date,ua.SOURCE,         CASE WHEN lc.NET_STATUS IN (-3,20) THEN 'STAGE_1' ELSE 'STAGE2' END , count(distinct u.login_id)  from user u,       user_ad ua,       lead_capture lc,       rcrt_resume_ads rra  where u.login_create_date = current date - 1 day    and ua.login_id = u.login_id    and lc.ad_id = ua.ad_id    and lc.CAMPAIGN_ID = '3p9901'    and ua.SOURCE IN ('versionA_B','versionA_J','versionB_B','versionB_J')    and u.NET_STATUS IN (1,5,7)    and rra.ad_id = ua.ad_id    and rra.saved_resume_path is not null    and rra.view in ('y','Y') group by u.login_create_date,ua.SOURCE,CASE WHEN lc.NET_STATUS IN (-3,20) THEN 'STAGE_1' ELSE 'STAGE2' END with ur

