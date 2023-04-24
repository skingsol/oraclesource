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





