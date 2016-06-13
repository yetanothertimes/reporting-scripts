#!/bin/ksh

set +x

cd $HOME/generic_etl/wip/
echo "Time: $(date +'%d%b%y-%T')"
if [[ $curr_proc == "" ]]
then
    echo ""
    echo "WARNING :Parameter need to pass for Promotional Mailer Data"
    echo ""
    exit
fi

if [[ $curr_proc == F1 ]]
then
    echo "$curr_proc Process begin"
    export proc=1
    limit=200000
    work_exp="2-3"
    server=IMT
fi

if [[ $curr_proc == F2 ]]
then
    echo "$curr_proc Process begin"
    export proc=2
    limit=200000
    work_exp="4-6"
    server=IMT
fi

if [[ $curr_proc == F21 ]]
then
    echo "$curr_proc Process begin"
    export proc=21
    limit=150000
    work_exp="7-9"
    server=IMT
fi

if [[ $curr_proc == F4 ]]
then
    echo "$curr_proc Process begin"
    export proc=4
    limit=200000
    work_exp="10+"
    server=IMT
fi


if [[ $curr_proc == F8 ]]
then
    echo "$curr_proc Process begin"
    export proc=8
    limit=150000
    work_exp="4-99"
    server=IMT
    part=A
fi

if [[ $curr_proc == F8S ]]
then
    curr_proc=F8
    echo "$curr_proc Process begin"
    export proc=8
    limit=150000
    work_exp="4-99"
    server=IMT
    part=B

fi

if [[ $curr_proc == F9 ]]
then
    echo "$curr_proc Process begin"
    export proc=9
    limit=100000
    work_exp="0-99"
    server=IMT
fi


echo "curr_proc: $curr_proc"
echo "proc     : $proc"
echo "limit    : $limit"
echo "work_exp : $work_exp"
echo "server   :$server"

echo "Searching new files for recover data deficiency"
echo "Time: $(date +'%d%b%y-%T')"
echo "File Name :$HOME/generic_etl/wip/promotional_data_${curr_proc}.txt "

if [ -r $HOME/generic_etl/wip/promotional_data_${curr_proc}.txt ]
then

echo "Files found and Loading ....."
echo "-----------------------------"
echo "Time: $(date +'%d%b%y-%T')"
echo "Truncate table promotion_data_stage"
echo "Time: $(date +'%d%b%y-%T')"

       db2 "alter table promotion_data_stage activate not logged initially with empty table"
echo "Delete already shared Data for ${curr_proc}"
echo "Time: $(date +'%d%b%y-%T')"
       db2 "delete from promotion_data_${curr_proc} where FRESSNESS = $proc and SENT ='Y' and POST_DATE < current date - 15 days "
echo "Import file into promotion_data_stage"
echo "Time: $(date +'%d%b%y-%T')"
       db2 "import from $HOME/generic_etl/wip/promotional_data_${curr_proc}.txt of del insert into promotion_data_stage"
echo "Load Data into promotional_data_${curr_proc}"
echo "Time: $(date +'%d%b%y-%T')"
       db2 "INSERT INTO promotion_data_${curr_proc} (EMAIL,CAND_NAME,MOBILE,WORK_EXP,SENT,FRESSNESS,POST_DATE) (select stage.EMAIL,stage.CAND_NAME,max(stage.MOBILE) as MOBILE,max(stage.WORK_EXP) as WORK_EXP,'N',${proc} ,current date from promotion_data_stage stage group by stage.EMAIL,stage.CAND_NAME)"
	db2 " delete from (select row_number() over (partition by Email, CAND_NAME, MOBILE, SENT , POST_DATE, FRESSNESS, WORK_EXP) as RN from  PROMOTION_DATA_${curr_proc} )t  where rn > 1"
       db2 "delete from promotion_data_${curr_proc} where length(trim(EMAIL)) < 1 "
       db2 "reorg table promotion_data_${curr_proc}"

       db2 "commit"
echo "Moving Files ...."
echo "Time: $(date +'%d%b%y-%T')"
mv $HOME/generic_etl/wip/promotional_data_${curr_proc}.txt $HOME/generic_etl/data_archive/promotional_data_${curr_proc}-${today}.txt

echo "---------- LOADING PROCESS END  ---------"
else
     echo "File not found"
fi
 
echo "Checking for Data availability"
echo "Time: $(date +'%d%b%y-%T')"
db2 "select count(1) as total from promotion_data_${curr_proc} pdf where sent = 'N' and not exists (select 1 from fake_email fe where fe.EMAILID = pdf.EMAIL) with ur" > $HOME/generic_etl/wip/data_point_count.txt
data_count=`head -4 $HOME/generic_etl/wip/data_point_count.txt |tail -1 |cut -d',' -f1 | bc`
data_count=`expr $data_count + 1`
echo "processing ..."
echo "Time: $(date +'%d%b%y-%T')"

echo "Data available for ${curr_proc}: $data_count" 
if [ $data_count -gt $limit ]
then

     echo "******** Sufficient Data for the day ********"

     echo "Begin to Data File creation"
     echo "Time: $(date +'%d%b%y-%T')"
     echo "export to $HOME/generic_etl/wip/promotional_data_${curr_proc}.ixf of ixf select pdf.EMAIL,pdf.CAND_NAME,pdf.MOBILE,pdf.EMAIL,pdf.WORK_EXP from promotion_data_${curr_proc} pdf where not exists (select 1 from fake_email fe where fe.EMAILID = pdf.EMAIL) and not exists (select 1 from DELETED_LOGINS_MANUAL u where u.email_id = pdf.EMAIL and pdf.EMAIL is not null) and pdf.SENT = 'N' fetch first $limit rows only with ur" > $HOME/generic_etl/wip/promotional_data_${curr_proc}_ixf.sql
     db2 -vf $HOME/generic_etl/wip/promotional_data_${curr_proc}_ixf.sql
     echo "Time: $(date +'%d%b%y-%T')"
     echo "alter table promotion_data_sent activate not logged initially with empty table" > $HOME/generic_etl/wip/promotional_data_${curr_proc}_sent_trunc.sql
     db2 -vf $HOME/generic_etl/wip/promotional_data_${curr_proc}_sent_trunc.sql
     echo "Time: $(date +'%d%b%y-%T')"
     
     echo "import from $HOME/generic_etl/wip/promotional_data_${curr_proc}.ixf of ixf insert into promotion_data_sent " > $HOME/generic_etl/wip/promotional_data_${curr_proc}_imp.sql
     db2 -vf $HOME/generic_etl/wip/promotional_data_${curr_proc}_imp.sql

     echo "Time: $(date +'%d%b%y-%T')"
     echo "export to $HOME/generic_etl/wip/PD_${today}_${curr_proc}.txt of del modified by coldel, datesiso select EMAIL,CAND_NAME,case when substr(MOBILE,1,2)='91' then substr(MOBILE,3) else MOBILE end as Mobile,EMAIL2,WORK_EXP from promotion_data_sent with ur " > $HOME/generic_etl/wip/PD_${today}_${curr_proc}.sql
     db2 -vf $HOME/generic_etl/wip/PD_${today}_${curr_proc}.sql
     cat $HOME/generic_etl/wip/promo_data_test_mails.txt >> $HOME/generic_etl/wip/PD_${today}_${curr_proc}.txt
     echo "Time: $(date +'%d%b%y-%T')"
#     echo "delete from promotion_data_${curr_proc} pdf where exists (select 1 from promotion_data_sent pds where pds.EMAIL = pdf.EMAIL)" > $HOME/generic_etl/wip/promotional_data_${curr_proc}_sent_del.sql

     echo "update promotion_data_${curr_proc} pdf set pdf.sent = 'Y' where exists (select 1 from promotion_data_sent pds where pds.EMAIL = pdf.EMAIL)" > $HOME/generic_etl/wip/promotional_data_${curr_proc}_sent_del.sql
     echo "update promotion_data_${curr_proc} pdf set post_date=current date where exists (select 1 from promotion_data_sent pds where pds.EMAIL = pdf.EMAIL)" >> $HOME/generic_etl/wip/promotional_data_${curr_proc}_sent_del.sql
     db2 -vf $HOME/generic_etl/wip/promotional_data_${curr_proc}_sent_del.sql
     rm -f promotional_data_${curr_proc}.ixf promotional_data_${curr_proc}_ixf.sql promotional_data_${curr_proc}_imp.sql promotional_data_${curr_proc}_sent_trunc.sql promotional_data_${curr_proc}_sent_del.sql
     echo "Time: $(date +'%d%b%y-%T')"

     perl -pi -e 's/"//g' $HOME/generic_etl/wip/PD_${today}_${curr_proc}.txt
     fdata_count=$(cat $HOME/generic_etl/wip/PD_${today}_${curr_proc}.txt | wc -l) 
     echo "************ FTP FILE FOR DATA REQUEST ************"
     $HOME/generic_etl/ksh_scripts/promotional_data.ftp $server PD_${today}_${curr_proc}.txt
     rm -f PD_${last_day}_${curr_proc}.txt PD_${today}_${last_day}.sql 
     echo "************ FTP COMPLETED ************"

     echo "Hi,

Data has been sent for work exp ${work_exp}:(Sent ${fdata_count} data point)

Thanks,
RPT SERVER
" > $HOME/generic_etl/wip/mail_body.txt

     ${KSH_SCRIPTS_DIR}/mail2 $email "Promotional Data has been sent for Process (${curr_proc}) " $HOME/generic_etl/wip/mail_body.txt

     echo "Process Completed for process ${curr_proc}"
     echo "------------------------------------------------"


fi

if [[ ${part} != "" ]]
then

    mv PD_${today}_${curr_proc}.txt PD_${today}_${curr_proc}_${part}.txt
    #rm -f PD_${last_day}_${curr_proc}_${part}.txt
    part=""

fi

echo " #### Pre-determine data for next day ####"
echo " -------------------------------"
echo "Time: $(date +'%d%b%y-%T')"
rest_data_point=`expr $data_count - 2 \* $limit`
          
if [ $rest_data_point -lt $limit ]
then
     echo " Be Ready to Load Fresh Data for One Year Freshness(${curr_proc})"
     echo "Hi,
     
     Data is available for this process:$data_count
     -Be ready to load fresh data for ${curr_proc}
     
     Thanks,
     RPT SERVER
" > $HOME/generic_etl/wip/mail_body.txt
                ${KSH_SCRIPTS_DIR}/mail2 $email "Be Ready to Load Fresh Data for One Year Freshness(${curr_proc})" $HOME/generic_etl/wip/mail_body.txt
         	touch $HOME/generic_etl/wip/promotional_data_script_${curr_proc}_${today}.need
	        $HOME/generic_etl/ksh_scripts/promotional_data.ftp DWH  promotional_data_script_${curr_proc}_${today}.need
		if [[ $curr_proc == F8 ]]
		then 
			db2 "connect to tjcandb user tcuser using jobusr"
			db2 "export to $HOME/generic_etl/wip/promotional_F8_AD_ID.csv of del modified by coldel, datesiso select RESUME_ID   from SITE_INBOX_RESPONSE    where DATE_RESPONDED between current date -8 month and current date  GROUP BY RESUME_ID HAVING COUNT(1) > 3 Union select RESUME_ID  from EXTERNAL_JOB_RESPONSE   where date(DATE_RESPONDED) between current date -8 month and current date GROUP BY RESUME_ID HAVING COUNT(1) > 3  with ur "
			db2 "terminate"
		$HOME/generic_etl/ksh_scripts/promotional_data.ftp DWH promotional_F8_AD_ID.csv
		rm -f promotional_F8_AD_ID.csv
		fi
         	echo "************ FTP FILE FOR DATA REQUEST ************"
                rm -f promotional_data_script_${curr_proc}_${today}.need

else
     echo "------- Data is Sufficient for the next day ($limit data found out of $data_count)------"

db2 "delete from PROMOTION_DATA_${curr_proc} pd where  pd.email in ( select t.EMAIL_ID from (select EMAIL_ID, CD, HRD, PROMO, CS, EM, LAST_MODIFIED_TIME,  row_number() over (partition by EMAIL_ID order by LAST_MODIFIED_TIME desc) as rank from UNSUBMAIL_TABLE) t where rank = 1  and CS = 1 ) and pd.sent='N'"
 
fi

