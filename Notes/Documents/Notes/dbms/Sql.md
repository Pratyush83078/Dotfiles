# Data Dissection

- Set of all combinations, to identify uniquely a row or tuple : superkey (all posible combinations)
- Candidate key: subset of superkey(minimal uniquely identify), not null
- Primary key: Uniquely identifier, not null, (ie S-id)only one, non-repeat (subset of candidate key)
- Unique Key: All unique value, but can be null (like panNO)
- Foreign key:primary key of anohter table

# Relations in Database -
- One - One (car with id)
- One - Many (colleges to student)
- Many - One (cities to states)
- Many - Many (Students with subjects)


# SQL
- Query
  - Types
  - DDL: Data definition language
    - create, drop,alter, truncate
  - DML: Data Manipulation language
    - Insert
    - Update
    - Delete
  - TCL: Transaction Control language
    - Commit
    - save
    - rollback
    -  set tran
    - set constran

  DQL : Data query language
    - Select
  DCL: Data control language
    - Grant
    - Revoke

## Commands

- seleect
  from
  limit

- Why you should not use Select *(as dashboard can crash)

- concat
- upper(concat())
- Select Round(..,1) can be -1,-2,5

- Conditional Statements
- select * From Product where column <value>
  OR, AND operator can be used
- And has more preference than OR

## Wild cards

- Like => where
- %a (any string before a)
- a%
- -a- (any string has a between)
- _a (only one character before a)
- a_
- Select * from [table name] where [column_name] LIke '<wildcard>'
- where [column_name] = somevalue
  - but for null NULL can't be equate to null(both are empty memory space)
  - therefore where is null(is is used here)

## JOINS

