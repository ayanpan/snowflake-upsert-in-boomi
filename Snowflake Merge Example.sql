MERGE INTO your_table_name AS t
USING (
    SELECT $source_id AS id,
           $current_date AS cd
) AS s
ON t.SOURCE_ID = s.id
WHEN MATCHED THEN
    UPDATE SET
        t.STATUS = 'U',
        t.LAST_MODIFIED_DATE = s.value
WHEN NOT MATCHED THEN
    INSERT (CREATED_DATE, LAST_MODIFIED_DATE, SOURCE_ID, STATUS)
    VALUES (s.cd, s.cd, s.id, 'I');