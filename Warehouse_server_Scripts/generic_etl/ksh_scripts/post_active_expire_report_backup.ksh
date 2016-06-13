#!/bin/bash

set +x
export pth=`date +%d%b%y`

cd /home/dwhuser/generic_etl/wip
perl -pi -e 's/,,/,\\N,/g' REP*
mysql -udwhuser -pdwhuser tjdwh_staging < /home/dwhuser/generic_etl/txt_files/active_expire_report.txt > /home/dwhuser/generic_etl/logs/active_expire_report_${pth}.log

echo "select '\"',Admin_Login_Id,'\",\"',Company_Name,'\",\"',Company_Cons_Internal,'\",\"',replace(Address,'\"',''),'\",\"',Location_Key,'\",\"',Location,'\",\"',Contact_Person,'\",\"',Designation ,'\",\"',Contact_Alt ,'\",\"',Contact_Off ,'\",\"',Email_Id,'\",\"',Industry,'\",\"',Expiry_Month,'\",\"',Expiry_Date ,'\",\"',Start_Date,'\",\"',Sales_Person_Email ,'\",\"',Vertical_ID ,'\",\"',Account_ID,'\",\"',ZMEmailID ,'\",\"',DB_Search ,'\",\"',Resume_Viewed ,'\",\"',Active_Jobs ,'\",\"',New_Jobs,'\",\"',Expired_Jobs,'\",\"',Excel_download ,'\",\"',DB_LSC_ALLOCATED,'\",\"',WORD_RESUME_DOWNLOAD,'\",\"',AP_Db_Service ,'\",\"',AP_DB_Expiry_Date,'\",\"',AP_DB_Start_Date ,'\",\"',AP_job_Service,'\",\"',AP_job_Expiry_Date ,'\",\"',AP_job_Start_Date,'\",\"',AP_visible_Service ,'\",\"',AP_visible_Expiry_Date	,'\",\"',AP_visible_Start_Date,'\",\"',AP_oth_Service,'\",\"',AP_oth_Expiry_Date ,'\",\"',AP_oth_Start_Date,'\",\"',AP_flag,'\",\"',AT_Db_Service ,'\",\"',AT_DB_Expiry_Date,'\",\"',AT_DB_Start_Date ,'\",\"',AT_job_Service,'\",\"',AT_job_Expiry_Date ,'\",\"',AT_job_Start_Date,'\",\"',AT_visible_Service ,'\",\"',AT_visible_Expiry_Date	,'\",\"',AT_visible_Start_Date,'\",\"',AT_oth_Service,'\",\"',AT_oth_Expiry_Date ,'\",\"',AT_oth_Start_Date,'\",\"',AT_flag ,'\",\"',DP_Db_Service ,'\",\"',DP_DB_Expiry_Date,'\",\"',DP_DB_Start_Date ,'\",\"',DP_job_Service,'\",\"',DP_job_Expiry_Date ,'\",\"',DP_job_Start_Date,'\",\"',DP_visible_Service ,'\",\"',DP_visible_Expiry_Date	,'\",\"',DP_visible_Start_Date,'\",\"',DP_oth_Service,'\",\"',DP_oth_Expiry_Date ,'\",\"',DP_oth_Start_Date,'\",\"',DP_flag ,'\",\"',DT_Db_Service ,'\",\"',DT_DB_Expiry_Date,'\",\"',DT_DB_Start_Date ,'\",\"',DT_job_Service,'\",\"',DT_job_Expiry_Date ,'\",\"',DT_job_Start_Date,'\",\"',DT_visible_Service ,'\",\"',DT_visible_Expiry_Date	,'\",\"',DT_visible_Start_Date,'\",\"',DT_oth_Service,'\",\"',DT_oth_Expiry_Date ,'\",\"',DT_oth_Start_Date,'\",\"',DT_flag,'\"'  into outfile '/tmp/active_report_${pth}.csv' from activeclient_fact where create_date=date(now());" > /home/dwhuser/generic_etl/wip/active_report_sql_${pth}.txt
echo "select '\"',Admin_Login_Id,'\",\"',Company_Name,'\",\"',Company_Cons_Internal,'\",\"',replace(Address,'\"',''),'\",\"',Location_Key,'\",\"',Location,'\",\"',Contact_Person,'\",\"',Designation ,'\",\"',Contact_Alt ,'\",\"',Contact_Off ,'\",\"',Email_Id,'\",\"',Industry,'\",\"',Expiry_Date ,'\",\"',Start_Date,'\",\"',Sales_Person_Email ,'\",\"',Vertical_ID ,'\",\"',Account_ID,'\",\"',ZMEmailID ,'\",\"',DB_Search ,'\",\"',Resume_Viewed ,'\",\"',Active_Jobs ,'\",\"',New_Jobs,'\",\"',Expired_Jobs,'\",\"',AP_Db_Service ,'\",\"',AP_DB_Expiry_Date,'\",\"',AP_DB_Start_Date ,'\",\"',AP_job_Service,'\",\"',AP_job_Expiry_Date ,'\",\"',AP_job_Start_Date,'\",\"',AP_visible_Service ,'\",\"',AP_visible_Expiry_Date	,'\",\"',AP_visible_Start_Date,'\",\"',AP_oth_Service,'\",\"',AP_oth_Expiry_Date ,'\",\"',AP_oth_Start_Date,'\",\"',AP_flag,'\",\"',AT_Db_Service ,'\",\"',AT_DB_Expiry_Date,'\",\"',AT_DB_Start_Date ,'\",\"',AT_job_Service,'\",\"',AT_job_Expiry_Date ,'\",\"',AT_job_Start_Date,'\",\"',AT_visible_Service ,'\",\"',AT_visible_Expiry_Date	,'\",\"',AT_visible_Start_Date,'\",\"',AT_oth_Service,'\",\"',AT_oth_Expiry_Date ,'\",\"',AT_oth_Start_Date,'\",\"',AT_flag ,'\",\"',DP_Db_Service ,'\",\"',DP_DB_Expiry_Date,'\",\"',DP_DB_Start_Date ,'\",\"',DP_job_Service,'\",\"',DP_job_Expiry_Date ,'\",\"',DP_job_Start_Date,'\",\"',DP_visible_Service ,'\",\"',DP_visible_Expiry_Date	,'\",\"',DP_visible_Start_Date,'\",\"',DP_oth_Service,'\",\"',DP_oth_Expiry_Date ,'\",\"',DP_oth_Start_Date,'\",\"',DP_flag ,'\",\"',DT_Db_Service ,'\",\"',DT_DB_Expiry_Date,'\",\"',DT_DB_Start_Date ,'\",\"',DT_job_Service,'\",\"',DT_job_Expiry_Date ,'\",\"',DT_job_Start_Date,'\",\"',DT_visible_Service ,'\",\"',DT_visible_Expiry_Date	,'\",\"',DT_visible_Start_Date,'\",\"',DT_oth_Service,'\",\"',DT_oth_Expiry_Date ,'\",\"',DT_oth_Start_Date,'\",\"',DT_flag,'\"'  into outfile '/tmp/expire_report_${pth}.csv' from expireclient_fact where create_date=date(now());" > /home/dwhuser/generic_etl/wip/expire_report_sql_${pth}.txt

mysql -udwhuser -pdwhuser tjdwh_staging < /home/dwhuser/generic_etl/wip/active_report_sql_${pth}.txt > /home/dwhuser/generic_etl/logs/active_report_sql_${pth}.log
mysql -udwhuser -pdwhuser tjdwh_staging < /home/dwhuser/generic_etl/wip/expire_report_sql_${pth}.txt > /home/dwhuser/generic_etl/logs/expire_report_sql_${pth}.log

mkdir /home/dwhuser/generic_etl/data_archive/active_expire/$pth
gzip /home/dwhuser/generic_etl/wip/REP*.*
mv /home/dwhuser/generic_etl/wip/REP*.gz /home/dwhuser/generic_etl/data_archive/active_expire/$pth/
mv /home/dwhuser/generic_etl/wip/expire_report_sql_${pth}.log /home/dwhuser/generic_etl/data_archive/active_expire/$pth/
mv /home/dwhuser/generic_etl/wip/active_report_sql_${pth}.txt /home/dwhuser/generic_etl/data_archive/active_expire/$pth/
cd /tmp
#echo `perl -pi -e '/s/\t//g' active_report_${pth}.csv`
#echo `perl -pi -e '/s/\\N//g' expire_report_${pth}.csv`

exit
