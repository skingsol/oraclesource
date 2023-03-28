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
-- order_id(숫자-8), user_id(user 테이블의 user_id 참조), product_id(product 테이블에 있는 product_id 참조해서 사용)
CREATE TABLE sorder (
        order_id NUMBER(8) PRIMARY KEY,
        user_id NUMBER(8) NOT NULL REFERENCES suser(user_id),
        product_id NUMBER(8) NOT NULL REFERENCES product(product_id)
);
CREATE SEQUENCE order_seq;