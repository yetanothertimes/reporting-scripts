select Admin_Login_Id,Company_Name,Company_Cons_Internal,'' as Address,Location_Key,Location,Contact_Person,Designation ,'' as Contact_Alt ,'' as Contact_Off ,'' as Email_Id,Industry,Expiry_Month,Expiry_Date ,Start_Date,Sales_Person_Email ,Vertical_ID ,Account_ID,ZMEmailID ,DB_Search ,Resume_Viewed ,Active_Jobs ,New_Jobs,Expired_Jobs,Excel_download ,DB_LSC_ALLOCATED,WORD_RESUME_DOWNLOAD,AP_Db_Service ,AP_DB_Expiry_Date,AP_DB_Start_Date ,AP_job_Service,AP_job_Expiry_Date ,AP_job_Start_Date,AP_visible_Service ,AP_visible_Expiry_Date    ,AP_visible_Start_Date,AP_oth_Service,AP_oth_Expiry_Date ,AP_oth_Start_Date,AP_flag,AT_Db_Service ,AT_DB_Expiry_Date,AT_DB_Start_Date ,AT_job_Service,AT_job_Expiry_Date ,AT_job_Start_Date,AT_visible_Service ,AT_visible_Expiry_Date  ,AT_visible_Start_Date,AT_oth_Service,AT_oth_Expiry_Date ,AT_oth_Start_Date,AT_flag ,DP_Db_Service ,DP_DB_Expiry_Date,DP_DB_Start_Date ,DP_job_Service,DP_job_Expiry_Date ,DP_job_Start_Date,DP_visible_Service ,DP_visible_Expiry_Date ,DP_visible_Start_Date,DP_oth_Service,DP_oth_Expiry_Date ,DP_oth_Start_Date,DP_flag ,DT_Db_Service ,DT_DB_Expiry_Date,DT_DB_Start_Date ,DT_job_Service,DT_job_Expiry_Date ,DT_job_Start_Date,DT_visible_Service ,DT_visible_Expiry_Date ,DT_visible_Start_Date,DT_oth_Service,DT_oth_Expiry_Date ,DT_oth_Start_Date,DT_flag,PAY_MODE from activeclient_fact_v2 where create_date=date(now()) into outfile '/tmp/active_report_v2_01Jun16.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
