# Snowflake Upsert Operation in Boomi

This article will showcase how to perform Upsert (Insert or Update) operation in Boomi based on the Primary/Unique Key of the Snowflake Table. 

The purpose of an Upsert operation is to insert a new record into a database table if it doesn't exist or update the existing record(s) if there is a conflict based on certain criteria, typically defined by a unique key or constraint.

In Snowflake, the "upsert" operation refers to the process of performing an "update" operation when a matching row exists or an "insert" operation when the row does not exist in the target table. This functionality is achieved using the MERGE command.

## Advantages of UPSERT Operation
:small_orange_diamond: It will avoid the necessity of a connector call to Snowflake to check if a given record exists or not, thereby decreasing the turnaround time of the process execution.

:small_orange_diamond: It will reduce the number of steps/shapes being used in the Boomi process because it combines the Insert and Update operations in a single step/shape, thereby simplifying the development/integration logic and putting less load on the Boomi's infrastructure.

:small_orange_diamond: It will streamline the workflow by providing an atomic operation that avoids conflicts and reduces error-prone scenarios.

## Implementation in Boomi
