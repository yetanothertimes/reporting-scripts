export to /home/datareq/generic_etl/wip/coverage_alert.txt of del modified by coldel, datesiso select 100,'Unique candidates sent job alerts',year(mt.CREATE_DATETIME),month(mt.CREATE_DATETIME) as LOGIN_CREATE_DATE ,count(distinct mt.LOGIN_ID) as candidate_count from tcuser.MAIL_TRACK mt where mt.COMBINATION_ID in (1002, 1005, 1006, 1009, 20000, 20100, 20400, 20500, 20600, 21000, 22000, 23015, 30000, 35000, 40000, 60000) and mt.CREATE_DATETIME between char(((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS) - 1 MONTH),ISO)||' 00:00:00.00' and char((((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS)) - 1 DAY) ,ISO)||' 23:59:59.99' group by year(mt.CREATE_DATETIME),month(mt.CREATE_DATETIME) with ur
