# TodoDB.sql

## Story

Todo app is an upcoming, lightweight program with which multiple users can track their todos simultaneously.
You are tasked with figuring out the database schema that is going to be used by backend developers to build this tool.
Help them out by creating the necessary SQL scripts to create such a database using basic CRUD operation.

## What are you going to learn?

- How to create a database
- How to connect to a database
- CRUD operations
  - `C` -> Create tables and insert data into them
  - `R` -> Read data from the tables
  - `U` -> Update data in the tables
  - `D` -> Delete data from the tables or drop them

## Tasks

1. Start and configure a VM with a NAT network adapter.
    - Started a VM loaded and configured with an SSH server and PostgreSQL (either an existing one or a fresh one using [this image](https://github.com/CodecoolBase/short-admin-vms/releases/latest/download/ubuntu-18.04-db.ova))
    - The VM's Network settings are configured with a single _NAT_ adapter
    - Port 22 and 5432 is forwarded between the host and the guest in the VM's NAT network adapter's settings
    - The guest VM's OS is reachable via `ssh` using the `ubuntu` user
    - The PostgreSQL server is accessible from outside the guest and the `ubuntu` database superuser exists with the password `ubuntu`

2. Create an empty database on your database server and connect to it
    - The database server version is `10` (i.e. `10.12`) or higher (verify with `SELECT version();`)
    - A superuser's credentials are known (i.e. `postgres` user with password `admin` or `ubuntu` user with password `ubuntu`)
    - A database named `tododb` is created on the database server
    - The database server can be accessed with `psql` or pgAdmin

3. Create an SQL script that creates the necessary tables to store user and todo information
    - Script is saved in `task-1.sql`
    - The script contains exactly 2 `CREATE TABLE` statements
    - After executing the script `user` table exists:
```
+---------+-------------------+
| id(int) | name(varchar(50)) |
+---------+-------------------+
```
    - After executing the script `todo` table exists:
```
+---------+--------------------+--------------+
| id(int) | task(varchar(100)) | user_id(int) |
+---------+--------------------+--------------+
```
    - All `id` columns are defined as `PRIMARY KEY`
    - `user_id` is defined as foreign key (`REFERENCES`)

4. Modify an existing table to add an additional column to the `todo` table to store whether a task is done or not
    - Script is saved in `task-2.sql`
    - The script contains exactly 1 `ALTER TABLE` statement
    - `done` column is added to the `todo` table:
```
+---------+--------------------+--------------+----------------+
| id(int) | task(varchar(100)) | user_id(int) |  done(boolean) |
+---------+--------------------+--------------+----------------+
```
    - The default value of the `done` column is `false`

5. Fill the tables with test data
    - Script is saved in `task-3.sql`
    - The script contains exactly 19 `INSERT` statements
    - `user` table contains the following:
```
+----+--------+
| id | name   |
+----+--------+
| 1  | Jane   |
| 2  | John   |
| 3  | Dave   |
| 4  | Emma   |
| 5  | Robert |
+----+--------+
```
    - `todo` table contains the following:
```
+----+----------------------------+---------+-------+
| id | task                       | user_id | done  |
+----+----------------------------+---------+-------+
| 1  | Setup pgAdmin              | 2       | false |
| 2  | Download Git               | 2       | false |
| 3  | Setup VS Code              | 1       | true  |
| 4  | Download  PostgreSQL       | 2       | false |
| 5  | Install server             | 2       | false |
| 6  | Create superuser           | 2       | false |
| 7  | Create database            | 2       | false |
| 8  | Create tables              | 2       | false |
| 9  | Wash the dishes            | 3       | false |
| 10 | Read the PostgreSQL manual | 4       | false |
| 11 | Exercise                   | 3       | false |
| 12 | Wake up in time!           | 5       | true  |
| 13 | Go to the gym              | 3       | false |
| 14 | Wash the dishes            | 5       | true  |
+----+----------------------------+---------+-------+
```

6. Write a query to see tasks that are already done
    - Script is saved in `task-4.sql`
    - The script contains exactly 1 `SELECT` statement
    - The result of your query should be:
```
+----+----------------------------+---------+-------+
| id | task                       | user_id | done  |
+----+----------------------------+---------+-------+
| 3  | Setup VS Code              | 1       | true  |
| 12 | Wake up in time!           | 5       | true  |
| 14 | Wash the dishes            | 5       | true  |
+----+----------------------------+---------+-------+
```

7. John finished his tasks in time, update his tasks accordingly in the `todo` table. There are two ways to do this:
  - using John's `id` which we know to be `2` (this is the easier method),
  - or by using a (INNER) JOIN (this method is more useful, but also more complicated to master).
Choose whichever suits your current knowledge best.
    - Script is saved in `task-5.sql`
    - The script contains exactly 1 `UPDATE` statement
    - After the `UPDATE` the `todo` table contains the following:
```
+----+----------------------------+---------+-------+
| id | task                       | user_id | done  |
+----+----------------------------+---------+-------+
| 1  | Setup pgAdmin              | 2       | true  |
| 2  | Download Git               | 2       | true  |
| 3  | Setup VS Code              | 1       | true  |
| 4  | Download  PostgreSQL       | 2       | true  |
| 5  | Install server             | 2       | true  |
| 6  | Create superuser           | 2       | true  |
| 7  | Create database            | 2       | true  |
| 8  | Create tables              | 2       | true  |
| 9  | Wash the dishes            | 3       | false |
| 10 | Read the PostgreSQL manual | 4       | false |
| 11 | Exercise                   | 3       | false |
| 12 | Wake up in time!           | 5       | true  |
| 13 | Go to the gym              | 3       | false |
| 14 | Wash the dishes            | 5       | true  |
+----+----------------------------+---------+-------+
```

8. Clean up tasks which are done already to conserve space in the database.
    - Script is saved in `task-6.sql`
    - The script contains exactly 1 `DELETE` statement
    - After the `DELETE` the `todo` table contains the following:
```
+----+----------------------------+---------+-------+
| id | task                       | user_id | done  |
+----+----------------------------+---------+-------+
| 9  | Wash the dishes            | 3       | false |
| 10 | Read the PostgreSQL manual | 4       | false |
| 11 | Exercise                   | 3       | false |
| 13 | Go to the gym              | 3       | false |
+----+----------------------------+---------+-------+
```

9. To clean up the database tables completely write a script that drops them.
    - Script is saved in `task-7.sql`
    - The script contains exactly 2 `DROP` statements
    - After the `DROP` the `tododb` database still exists
    - After the `DROP` the `user` and `todo` tables don't exist

## General requirements

None

## Hints

- You can use the pgAdmin to create a new DB for this assignment.
- You can run your SQL scripts with [pgAdmin](https://www.pgadmin.org/docs/pgadmin4/4.23/query_tool_toolbar.html#file-options), or with [psql](https://kb.objectrocket.com/postgresql/how-to-run-an-sql-file-in-postgres-846)
- **When you are reading background materials:**
  - [General SQL tutorial](https://w3schools.com/sql/default.asp) - Read the following topics: Select, Where, Insert, Update, Delete, Create/Drop DB, Create/Drop Table, Alter table
  - [Interactive SQL tutorial](https://www.w3schools.com/sql/exercise.asp)- Related exercises: Select, Where, Insert, Update, Delete, Database

## Background materials

- <i class="far fa-exclamation"></i> [Introduction to SQL](project/curriculum/materials/tutorials/introduction-to-sql.md)
- <i class="far fa-book-open"></i> [General SQL tutorial](https://w3schools.com/sql/default.asp)
- <i class="far fa-book-open"></i>[Interactive SQL tutorial](https://www.w3schools.com/sql/exercise.asp)
- <i class="far fa-book-open"></i> [Primary key - postgres](https://www.postgresqltutorial.com/postgresql-primary-key/)
- <i class="far fa-book-open"></i> [Foreign key - postgres](https://www.postgresqltutorial.com/postgresql-foreign-key/)
- <i class="far fa-book-open"></i> [Short guide about `psql`](http://postgresguide.com/utilities/psql.html)
- <i class="far fa-book-open"></i> [PostgreSQL documentation about `psql`](https://www.postgresql.org/docs/current/app-psql.html)
