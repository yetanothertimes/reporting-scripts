#!/usr/bin/ksh

set +x
mv $LOAD_DIR/JobAlert_count.csv $LOAD_DIR/JobAlert_count_${todate}.csv
cd ${LOAD_DIR}
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
echo "#!/bin/ksh" > $ftp_file
echo "HOST=$ip" >> $ftp_file
echo "USER=$user" >> $ftp_file
echo "PASSWD=$pswd" >> $ftp_file
echo "ftp -in \$HOST <<EOF" >> $ftp_file
echo "quote USER \$USER" >> $ftp_file
echo "quote PASS \$PASSWD" >> $ftp_file
echo "binary" >> $ftp_file
echo "cd $ftp_dir" >> $ftp_file
echo "pwd" >> $ftp_file
echo "put JobAlert_count_${todate}.csv" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

perl -pi -e 's/172.16.84.220/115.112.206.220/g' ${ftp_file}
${ftp_file}

echo "All Files are created successfully"
touch $LOAD_DIR/${cur_proc}_${today}.done
