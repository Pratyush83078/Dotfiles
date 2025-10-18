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
- select [cols_name] from [left_table] left join [right_tablel] on [left_table] [column]=[right_table][col name]
- inner join, left join, right join,

- <> not equal operator

## Union
- just clone two tables (uniquely)
- unique all (can contain duplicate)
- no of attributes should be same in both and should be of same datatypes

### multiple join

- Distinct (unique)


## group by and (count()-> [aggregate function])
- We are summarizing the information based on the groups we are creating
- select from where > group by [cols to group by] having [cond] order by (by default,asc)
- without aggregate(count()) group by works as a distinct

- So count(distinct col_name) counts no of unique value in that column
- group by just make that col distinct like can be one two etc
  - count(*)-> calculate all no of rows including null
  - count(anyRandomValue)-> calc no. of rows excluding null
### Having
- having customer_id=7

## Windows func and ranking func
















