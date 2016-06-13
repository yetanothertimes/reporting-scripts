export to /home/datareq/generic_etl/data_files/WIDGET_CREATE_FACT.txt of del modified by coldel, datesiso select U.LOGIN_CREATE_DATE,VWA.WIDGET_ID, VWA.REGISTRATION_PRECEDENCE,WSM.WIDGET_STATUS_ID, AVG(VWA.WEIGHT) WIDGET_WEIGHT, count(1) USER_COUNT from TCUSER.USER U ,USER_WIDGETS UW, tcadmin.VW_VERTICAL_WIDGET_APPLICABILITY VWA, tcadmin.WIDGET_STATUS_MASTER WSM where U.LOGIN_CREATE_DATE between '2012-06-14' and '2012-06-20' AND U.LOGIN_SRL_NO = UW.LOGIN_SRL_NO AND VWA.WIDGET_ID = UW.WIDGET_ID AND WSM.WIDGET_STATUS_ID = UW.WIDGET_STATUS_ID Group by U.LOGIN_CREATE_DATE,VWA.WIDGET_ID, VWA.REGISTRATION_PRECEDENCE,WSM.WIDGET_STATUS_ID Order by U.LOGIN_CREATE_DATE,VWA.REGISTRATION_PRECEDENCE with ur

export to /home/datareq/generic_etl/data_files/WIDGET_UPDATE_FACT.txt of del modified by coldel, datesiso select date(UW.DATE_MODIFIED) MODIFIED_DATE,VWA.WIDGET_ID, VWA.EDIT_PRECEDENCE,WSM.WIDGET_STATUS_ID, AVG(VWA.WEIGHT) WIDGET_WEIGHT, count(1) USER_COUNT from USER U,USER_AD UA,USER_WIDGETS UW, tcadmin.VW_VERTICAL_WIDGET_APPLICABILITY VWA, tcadmin.WIDGET_STATUS_MASTER WSM where UA.LAST_MODIFIED_TIME between char((current date - 1 day),ISO)||' 00:00:00.00' and char((current date - 1 day),ISO)||' 23:59:59.00' AND U.LOGIN_CREATE_DATE != current date - 1 day  AND U.LOGIN_ID = UA.LOGIN_ID AND U.LOGIN_SRL_NO = UW.LOGIN_SRL_NO AND VWA.WIDGET_ID = UW.WIDGET_ID AND WSM.WIDGET_STATUS_ID = UW.WIDGET_STATUS_ID Group by date(UW.DATE_MODIFIED),VWA.WIDGET_ID, VWA.EDIT_PRECEDENCE,WSM.WIDGET_STATUS_ID Order by date(UW.DATE_MODIFIED),VWA.EDIT_PRECEDENCE with ur

export to /home/datareq/generic_etl/data_files/WIDGET_MASTER.txt of del modified by coldel, datesiso select WIDGET_ID, WIDGET_DESC, ACTIVE_STATUS from TCADMIN.WIDGET_MASTER fetch first 10 rows only with ur

export to /home/datareq/generic_etl/data_files/WIDGET_STATUS_MASTER.txt of del modified by coldel, datesiso select WIDGET_STATUS_ID, WIDGET_STATUS_DESC from TCADMIN.WIDGET_STATUS_MASTER fetch first 10 rows only with ur