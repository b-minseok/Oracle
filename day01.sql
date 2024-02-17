-- 단문 주석
/* 복문 주석
    여러 라인 주석 처리
    컨트롤 +슬래시 주석처리됨
*/
--select count(*) from tab;
--select * from tab;
--select * from dept;
--select * from emp;
--select * from salgrade;
--select * from category;
--select * from products;
--select * from member;
--select * from supply_comp;
--day01.sql

--학생 테이블
create table student(
    no number(4) primary key, --unique + not null
    name varchar2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate,
    sclass varchar2(30),
    sroom number(3)
);
desc student;
insert into student (no,name,tel)
values(1,'이철수','010-2222-3333');
commit;
--오라클은 수동 commit,mysql은 auto commit

select * from student;
--c: create=>insert
--r: read==>select
--u: update==>update
--d: delete==>delete
--2 김영희 주소 연락처 '백앤드개발자반' 201호
insert into student (no,name,addr,tel,sclass,sroom)
values(3,'김길동','서울 강동구','010-5333-4444','백엔드 개발자반',201);
rollback; --취소
select * from student;
commit;
delete from student where no=3;

--프런트 개발자반 학생 2명 정보를 insert하세요
--202호
--컬럼명을 생략하고 insert할 때는 테이블을 create했을떄 만든 컬럼순서대로
--값을 넣어주어야 함
insert into student
values(5,'홍길동','수원','010-7323-7232',sysdate,'프런트 개발자반',202);
select * from student;
commit;
--1번 학생의 주소,학급,교실번호를 수정합시다
--update 테이블명 set 컬럼명1=값,컬럼명2=값2 where 조건절
update student set addr='서울 강남구', sclass='백앤드 개발자', sroom=201
where no=1;
rollback;

select * from student where sclass='백엔드 개발자반';
select * from student where sroom=201;

--학생 테이블을 삭제하고 다시 만들어보자
--drop table 테이블명
drop table student;
select * from student;

학급 테이블 생성 
테이블명: sclass
학급번호(snum) number(4) primary key
학급명(sname) varchar2(30)
교실번호(sroom) number(3)

create table sclass(
    snum number(4) primary key,
    sname varchar2(30) not null,
    sroom number(3)
);
create table student(
    no number(4) primary key,
    name varchar2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate,
    snum_fk number(4) references sclass(snum)
);
insert into sclass(snum,sname,sroom)
values(10,'백엔드 개발자반',201);
insert into sclass
values(20,'프런트엔드 개발자반',202);
insert into sclass
values(30,'빅데이터반',203);
select * from sclass;

insert into student(no,name,addr,tel,snum_fk)
values(2,'김철수','서울 강서구','010-2111-2222',20);
select * from student;
--join
select student.*, sclass.*
from sclass join student
on sclass.snum = student.snum_fk;

10번 학급 학생정보 3명 등록
20번 학급 학생정보 3명 등록
30번 학급 학생정보 1명 등록

insert,update,delete