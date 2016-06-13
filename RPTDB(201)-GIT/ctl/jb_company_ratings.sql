alter table jb_company_overall_ratings_stg activate not logged initially with empty table

import from /home/datareq/generic_etl/wip/jb_company_ratings.csv of del insert into jb_company_overall_ratings_stg

MERGE INTO jb_company_overall_ratings AS jc USING (select * from  jb_company_overall_ratings_stg ) AS jcs ON (jc.COMPANY_ID = jcs.COMPANY_ID) WHEN MATCHED THEN UPDATE SET jc.COMPANY_ID= jcs.COMPANY_ID,jc.RATING_1 = jcs.RATING_1,jc.RATING_2 = jcs.RATING_2,jc.RATING_3 = jcs.RATING_3,jc.RATING_4 = jcs.RATING_4,jc.OVERALL_RATING =jcs.OVERALL_RATING,jc.COUNT_OF_REVIEWS=jcs.COUNT_OF_REVIEWS,jc.LAST_MODIFIED_TIME=jcs.LAST_MODIFIED_TIME,jc.CREATED_DATE=jcs.CREATED_DATE WHEN NOT MATCHED THEN INSERT (COMPANY_ID,RATING_1,RATING_2,RATING_3,RATING_4,OVERALL_RATING,COUNT_OF_REVIEWS,LAST_MODIFIED_TIME,CREATED_DATE) VALUES(jcs.COMPANY_ID,jcs.RATING_1,jcs.RATING_2,jcs.RATING_3 ,jcs.RATING_4,jcs.OVERALL_RATING,jcs.COUNT_OF_REVIEWS,jcs.LAST_MODIFIED_TIME,jcs.CREATED_DATE)
