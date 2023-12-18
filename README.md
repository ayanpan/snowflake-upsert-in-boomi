# Snowflake Upsert Operation in Boomi

This article will showcase how to perform Upsert (Insert or Update) operation in Boomi based on the Primary/Unique Key of the Snowflake Table. 

The purpose of an Upsert operation is to insert a new record into a database table if it doesn't exist or update the existing record(s) if there is a conflict based on certain criteria, typically defined by a unique key or constraint.

In Snowflake, the "upsert" operation refers to the process of performing an "update" operation when a matching row exists or an "insert" operation when the row does not exist in the target table. This functionality is achieved using the MERGE command.

## Advantages of UPSERT Operation
:small_orange_diamond: It will avoid the necessity of a connector call to Snowflake to check if a given record exists or not, thereby decreasing the turnaround time of the process execution.

:small_orange_diamond: It will reduce the number of steps/shapes being used in the Boomi process because it combines the Insert and Update operations in a single step/shape, thereby simplifying the development/integration logic and putting less load on the Boomi's infrastructure.

:small_orange_diamond: It will streamline the workflow by providing an atomic operation that avoids conflicts and reduces error-prone scenarios.

## Implementation in Boomi
Snowflake's MERGE operation/command has USING operator which essentially requires a source table from which the records will be merged with the target/required table. Since we need to upsert records based on primary/unique key instead of using a source table, we have to use a SQL SELECT Statement to replicate a source table. In this SQL SELECT Statement, we have to pass the values which need to be inserted or updated in our required target table as JSON key-value pairs, shown in the below sample JSON.
```json
{
   "source _id": "123",
   "current_date": "2023.12.16"
}
```
Since there isn't any MERGE Action in the Boomi's native Snowflake Connector, we can perform the MERGE operation using the SnowSQL Action, shown in the below sample SQL Statement.
```sql
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
```
In the USING operator of the above SQL Statement, we need to fetch the value of fields/columns from the JSON profile by setting parameters. The parameters should be defined by prefixing the $ symbol with the parameter's name. In this example, we have set 2 parameters, $source_id and $current_date, and the 2 respective keys of the incoming JSON document are source_id and current _date.
