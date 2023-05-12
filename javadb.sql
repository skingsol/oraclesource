-- javadb

-- userTBL 테이블 생성
-- NO(번호 - 숫자(4)), username(이름-한글4자리), birthYear(년도- 숫자4자리), 
-- addr(주소-문자(한글,숫자), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)
CREATE TABLE userTBL(
        no NUMBER(4)CONSTRAINT pk_userTBL PRIMARY KEY,
        username NVARCHAR2(10) NOT NULL,
        birthYear NUMBER(4) NOT NULL,
        addr NVARCHAR2(50) NOT NULL,
        mobile VARCHAR2(13)
);


--(간단 구문 정리) --------------------------------------------------
-- select(+서브쿼리,조인) + DML(insert,delete,update)
-- 전체조회
SELECT * FROM usertbl;

-- 개별조회(특정번호, 특정이름...)
-- 여러행이 나오는 상태냐? 하나의 행이 결과로 나올것이냐?
SELECT * FROM usertbl WHERE no=1;
SELECT * FROM usertbl WHERE username='홍길동';

-- LIKE : _ or % 둘중에 사용 
--(%문자 : %문자로 끝나는 값 알려줘)
--(%문자% : 문자 들어가는 값 알려줘)
--(-문자 : -문으로 시작하는 값 알려줘)
SELECT * FROM usertbl WHERE username LIKE '%홍길동';

--INSERT INTO 테이블명(필드명1, 필드명2...)
--VALUES();

--UPDATE 테이블명
--SET 업데이트할 필드명 = 값, 업데이트할 필드명 = 값,...
--WHERE 조건;

--DELETE 테이블명 WHERE 조건;

--DELETE FROM 테이블명 WHERE 조건;
-- --------------------------------------------------------------


-- 시퀀스 생성
-- user_seq 생성(기본)
CREATE SEQUENCE user_seq;

-- INSERT
INSERT INTO userTBL(no, username, birthYear, addr, mobile)
VALUES ('0047', '히트맨', '1995', '서울 종로구 종로12길 15 코아빌딩9층 901호', '010-1010-1010');

COMMIT;

-- paytype : no(숫자-1), info(문자-영어4)
-- paytype_seq 생성
CREATE TABLE paytype (
        pay_no NUMBER(1) PRIMARY KEY,
        info varchar2(10) NOT NULL
);

CREATE SEQUENCE paytype_seq;

INSERT INTO paytype VALUES(paytype_seq.NEXTVAL, 'card');
INSERT INTO paytype VALUES(paytype_seq.NEXTVAL, 'cash');

SELECT * FROM paytype; --1: card, --2: cash

-- suser : user_id(숫자-4), name(문자-한글4), pay_no(숫자-1 : paytype 테이블에 있는 pay_no 참조해서 사용)
CREATE TABLE suser (
        user_id NUMBER(4) PRIMARY KEY,
        name NVARCHAR2(20) NOT NULL,
        pay_no NUMBER(1) NOT NULL REFERENCES paytype(pay_no)
);

-- product
-- product_id(숫자-8), pname(상품네임 문자-20), price(숫자-10), content(문자-50)
CREATE TABLE product (
        product_id NUMBER(8) PRIMARY KEY,
        pname VARCHAR2(30) NOT NULL,
        price NUMBER(10) NOT NULL,
        content VARCHAR2(50) NOT NULL
);
CREATE SEQUENCE product_seq;

-- sorder
-- order_id(숫자-8), user_id(user 테이블의 user_id 참조),
-- product_id(product 테이블에 있는 product_id 참조해서 사용)
CREATE TABLE sorder (
        order_id NUMBER(8) PRIMARY KEY,
        user_id NUMBER(8) NOT NULL REFERENCES suser(user_id),
        product_id NUMBER(8) NOT NULL REFERENCES product(product_id)
);

ALTER TABLE sorder ADD order_date DATE; --구매날짜

CREATE SEQUENCE order_seq;

-- user_id, name, pay_no, info
SELECT u.user_id, u.name, u.pay_no, p.info 
FROM suser u, paytype p 
WHERE u.pay_no = p.pay_no AND u.user_id =1155;

-- 주문정보 전체 조회
SELECT * FROM sorder;

-- 주문목록 조회
-- user_id, name, card/cash, product_id, pname, price, content

-- 기준 : sorder
-- suser 테이블 : name,
-- paytype 테이블 : card/cash
-- product 테이블 : product_id, pname, price, content

-- 전체 주문목록
SELECT u.user_id, u.name, t.info, p.product_id, p.pname, p.price, p.content, o.order_date
FROM suser u, sorder o, paytype t, product p 
WHERE u.user_id = o.user_id AND u.pay_no = t.pay_no AND p.product_id = o.product_id;


-- 초록이 주문목록 (특정 사람의 주문목록 1개 조회시 사용)
SELECT u.user_id, u.name, t.info, p.product_id, p.pname, p.price, p.content, o.order_date
FROM suser u, sorder o, paytype t, product p 
WHERE u.user_id = o.user_id AND u.pay_no = t.pay_no AND p.product_id = o.product_id AND u.user_id = 1155;


-- 도서 테이블
-- code, title, writer, price
-- code : 1001(pk)
-- title : '자바의 신'
-- writer : '홍길동'
-- price : 25000

-- bookTBL 테이블 생성
CREATE TABLE booktbl (
    code NUMBER(4) PRIMARY KEY,
    title NVARCHAR2(50) NOT NULL,
    writer NVARCHAR2(20) NOT NULL,
    price NUMBER(8) NOT NULL
);

INSERT INTO booktbl (code, title, writer, price) VALUES (1001, '이것이 자바다', '신용균', 25000);
INSERT INTO booktbl (code, title, writer, price) VALUES (1002, '자바의 신', '강신용', 28000);
INSERT INTO booktbl (code, title, writer, price) VALUES (1003, '오라클로 배우는 데이터베이스', '이지훈', 28000);
INSERT INTO booktbl (code, title, writer, price) VALUES (1004, '자바 1000제', '김용만', 29000);
INSERT INTO booktbl (code, title, writer, price) VALUES (1005, '자바 프로그래밍 입문', '박은종', 30000);

commit;

ALTER TABLE booktbl ADD DESCRIPTION NVARCHAR2(100);



--member 테이블
-- userid (영어, 숫자, 특수문자) 최대 12자 허용
-- password (영어, 숫자, 특수문자) 최대 15자 허용
-- name (한글)
-- gender (한글, 남 or 여)
-- email

CREATE TABLE membertbl (
    userid VARCHAR2(15) PRIMARY KEY,
    password VARCHAR2(20) NOT NULL,
    name NVARCHAR2(10) NOT NULL,
    gender NVARCHAR2(2) NOT NULL,
    email VARCHAR2(50) NOT NULL
);

INSERT INTO membertbl VALUES('hong123','hong123@', '홍길동', '남', 'hong123@gmail.com');
COMMIT;



-- 게시판
-- 글번호(숫자, 시퀀스 삽입,  PK), 작성자(한글), 비밀번호(숫자,영문자), 제목(한글), 내용(한글), 파일첨부(파일명)
-- 답변글 작성시 참조되는 글번호(숫자), 답변글 레벨(숫자), 답변글 순서(숫자), 조회수(숫자), 작성날짜

CREATE TABLE board (
    bno NUMBER(8) CONSTRAINT pk_board PRIMARY KEY,
    name NVARCHAR2(10) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    title NVARCHAR2(50) NOT NULL,
    content NVARCHAR2(1000) NOT NULL,
    attach NVARCHAR2(100),
    re_ref NUMBER(8) NOT NULL,
    re_lev NUMBER(8) NOT NULL,
    re_seq NUMBER(8) NOT NULL,
    cnt NUMBER(8) DEFAULT 0,
    regdate DATE DEFAULT sysdate
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

COMMIT;

-- 서브쿼리 -더미데이터 생성하기
INSERT INTO board(bno,name,password,title,content,re_ref,re_lev,re_seq)
(SELECT board_seq.nextval,name,password,title,content,board_seq.currval,re_lev,re_seq FROM board);

COMMIT;
-- 현재 최신글 상태 가져오기
SELECT bno, title, re_ref, re_lev, re_seq FROM board WHERE bno=4115;

INSERT INTO board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'김댓글','12345','Re : 게시글','게시글', null,4115,1,1);

-- 가장 최신글과 댓글 가지고 오기
SELECT bno, title, re_ref, re_lev, re_seq FROM board WHERE re_ref=4115;

-- 두번째 댓글 작성
-- re_seq 가 값이 작을수록 최신글임
-- UPDATE 구문에서 
UPDATE board SET re_seq = re_seq + 1 WHERE re_ref = 4115 AND re_seq >0;

commit;

--가장 최신글과 댓글 가지고 오기(+ re_seq asc : 댓글의 최신)
SELECT bno, title, re_ref, re_lev, re_seq FROM board WHERE re_ref=4115 ORDER BY re_seq;

INSERT INTO board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'김댓글','12345','Re : 게시글','게시글', null,4115,1,1);

-- 댓글의 댓글 작성
-- UPDATE / INSERT
UPDATE board SET re_seq = re_seq + 1 WHERE re_ref = 4115 AND re_seq >2;
INSERT INTO board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'김댓글','12345','ReRe : 게시글','게시글', null,4115,2,3);


--페이지 나누기
-- ROWNUM : 조회된 결과에 번호를 매겨줌
--          ORDER BY 구문에 INDEX 가 들어가지 않는다면 제대로 된 결과를 보장하지 않음
--          PK 가 INDEX로 사용됨
SELECT ROWNUM, bno, title FROM board ORDER BY bno DESC;

SELECT ROWNUM, bno, title, re_ref, re_lev, re_seq 
FROM board
ORDER BY re_ref desc, re_seq ASC;

-- 해결
-- ORDER BY 구문을 먼저 실행한 후 ROWNUM 붙여야 함

SELECT ROWNUM, bno, title, re_ref, re_lev, re_seq
FROM(SELECT bno, title, re_ref, re_lev, re_seq 
     FROM board ORDER BY re_ref desc, re_seq ASC)
WHERE ROWNUM <= 30;

-- 한 페이지에 30개의 목록을 보여준다 할 때
-- 1 2 3 4 5 6 .....
-- 1 page 요청 (1~30)
-- 2 page 요청 (31~60)

SELECT *
FROM (SELECT ROWNUM rnum, bno, title, re_ref, re_lev, re_seq
      FROM(SELECT bno, title, re_ref, re_lev, re_seq 
      FROM board ORDER BY re_ref desc, re_seq ASC)
      WHERE ROWNUM <= 30)
WHERE rnum > 0;

SELECT *
FROM (SELECT ROWNUM rnum, bno, title, re_ref, re_lev, re_seq
      FROM(SELECT bno, title, re_ref, re_lev, re_seq 
      FROM board ORDER BY re_ref desc, re_seq ASC)
      WHERE ROWNUM <= ?)
WHERE rnum > ?;

-- 1 page : rnum > 0, rownum <= 30
-- 1 page : rnum > 30, rownum <= 60
-- 1 page : rnum > 60, rownum <= 90

-- 1, 2, 3
-- n           30 * n-1        30 * n




----- spring_board
-- bon 숫자(10) 제약조건 pk 제약조건명 pk_spring_board
-- title varchar2(200) 제약조건 not null
-- content varchar2(2000) 제약조건 not null
-- writer varchar2(50) 제약조건 not null
-- regdate date defalt 로 현재시스템날짜
-- updatedate date defalt 로 현재시스템날짜
CREATE TABLE spring_board (
    bno NUMBER(10) CONSTRAINT pk_spring_board PRIMARY KEY,
    title varchar2(200) NOT NULL,
    content varchar2(2000) NOT NULL,
    writer varchar2(50) NOT NULL,    
    regdate DATE DEFAULT sysdate,
    updatedate DATE DEFAULT sysdate
);
-- 시퀀스 seq_board
CREATE SEQUENCE seq_board;
-- 커밋
COMMIT;

-- mybatis 연습용 테이블
create table person(
    id varchar(20) primary key,
    name varchar2(30) not null);
    
SELECT * FROM person;

INSERT INTO person VALUES('kim123','김길동');

COMMIT;

SELECT * FROM membertbl;


-- 트랜잭션 테스트 테이블 
-- 트랜잭션 : 하나의 업무에 여러개의 작은 업무들이 같이 묶여 있음 / 하나의 단위로 처리
-- 계좌이체 : 계좌 출금 => 타 계좌 입금
CREATE TABLE tbl_sample1(col1 VARCHAR2(500));
CREATE TABLE tbl_sample2(col1 VARCHAR2(50));

SELECT * FROM tbl_sample1;
SELECT * FROM tbl_sample2;

commit;