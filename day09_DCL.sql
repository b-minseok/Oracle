--day09_DCL.sql
conn system/oracle;
show user;
�ý��� ������ scott���� �ο�����

grant create user,alter user,drop user to scott
with admin option;

--with admin option�� �ָ� scott�� �ٸ� user����
create user,alter user,drop user ������ �ο��� �� �ְ� �ȴ�

revoke create user,alter user,drop user from scott;