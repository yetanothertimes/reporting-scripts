export to /home/datareq/generic_etl/wip/promotional_data_F5.txt of del modified by coldel, datesiso select u.email2,odl.CANDIDATENAME,odl.MOBILE_NUMBER,u.EMAIL2,odl.EXPERIENCEMONTH from OBD_DATA odl, user u where u.LOGIN_ID=odl.LOGIN_ID and (odl.LOGINDATE between current date - 36 month and current date)and odl.FUNCTIONAREAMAS in (15,19,72,77,81,20,23,25,26,27,32) and not exists (select 1 from UNSUBMAIL_TABLE ut where u.email2=ut.EMAIL_ID and ut.PROMO=1) with ur
