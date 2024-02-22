--day09_DCL.sql
conn system/oracle;
show user;
시스템 권한을 scott에게 부여하자

grant create user,alter user,drop user to scott
with admin option;

--with admin option을 주면 scott도 다른 user에게
create user,alter user,drop user 권한을 부여할 수 있게 된다

revoke create user,alter user,drop user from scott;