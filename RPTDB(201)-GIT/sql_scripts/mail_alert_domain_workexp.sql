EXPORT TO /home/datareq/generic_etl/data_files/mail_alerts_exp_wise_one_week.csv OF DEL MODIFIED BY coldel, DATESISO  select A.COMBINATION_ID, CASE WHEN csr.EXP_IN_MONTH between 0 and 24 then '0_2' WHEN csr.EXP_IN_MONTH between 25 and 60 then '2_5' WHEN csr.EXP_IN_MONTH between 61 and 96 then '5_8'  WHEN csr.EXP_IN_MONTH between 97 and 144 then '8_12'  WHEN csr.EXP_IN_MONTH between 145 and 10000 then '12_plus'  ELSE 'NOT DEFINED'  END as experience , count(distinct ua.AD_ID) as sent, sum(case when A.WAS_OPEN= 1 then 1 else 0 end) as open from mail_track A , USER_AD UA, CAndidate_selected_roles csr  where A.CREATE_DATETIME between char((current date - 1 day),ISO)||' 00:00:00.00' and char((current date - 1 day),ISO)||' 23:59:59.99' and UA.Login_id = A.login_id and csr.AD_ID = ua.ad_id Group by  A.COMBINATION_ID, CASE WHEN csr.EXP_IN_MONTH between 0 and 24 then '0_2' WHEN csr.EXP_IN_MONTH between 25 and 60 then '2_5' WHEN csr.EXP_IN_MONTH between 61 and 96 then '5_8' WHEN csr.EXP_IN_MONTH between 97 and 144 then '8_12' WHEN csr.EXP_IN_MONTH between 145 and 10000 then '12_plus' ELSE 'NOT DEFINED'  END with ur

