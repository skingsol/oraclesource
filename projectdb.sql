--  관리자 권한
CREATE TABLE authority (
  auth VARCHAR2(50) PRIMARY KEY,
  post_auth NUMBER(1) DEFAULT 0,
  reply_auth NUMBER(1) DEFAULT 0,
  restaurant_auth NUMBER(1) DEFAULT 0,
  review_auth NUMBER(1) DEFAULT 0
);

-- 유저
CREATE TABLE users(
  user_idx NUMBER(10) PRIMARY KEY,
  auth VARCHAR2(50) NOT NULL,
  userid VARCHAR2(50) NOT NULL,
  email VARCHAR2(100) NOT NULL,
  password VARCHAR2(100) NOT NULL,
  phone NUMBER(15),
  introduce VARCHAR2(300) NOT NULL,
  profile_picture VARCHAR2(255),
  enabled NUMBER(1) DEFAULT 1 NOT NULL
);

-- 고객문의 게시판 
CREATE TABLE post (
  post_id NUMBER(10) PRIMARY KEY,
  user_idx NUMBER(10) REFERENCES users(user_idx) NOT NULL,
  post_title VARCHAR2(255) NOT NULL,
  post_content VARCHAR2(4000) NOT NULL,
  post_regdate DATE DEFAULT sysdate NOT NULL,
  reply_cnt number(10) default 0,
  post_auth NUMBER(1) DEFAULT 0 NOT NULL
);


-- 고객문의 댓글
CREATE TABLE reply (
  reply_id NUMBER(10) PRIMARY KEY,
  post_id NUMBER(10) REFERENCES post(post_id) NOT NULL,
  user_idx NUMBER REFERENCES users(user_idx) NOT NULL,
  reply_content VARCHAR2(4000) NOT NULL,
  reply_regdate DATE NOT NULL,
  reply_auth NUMBER(1) DEFAULT 0 NOT NULL
);


-- 맛집
CREATE TABLE restaurant (
  restaurant_id NUMBER(10) PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  adress VARCHAR(255) NOT NULL,
  loadadress VARCHAR(255) ,
  category VARCHAR2(50) ,
  wishlist_count NUMBER(10) ,
  open_hours VARCHAR2(50),
  close_hours VARCHAR2(50),
  mapx NUMBER(10) ,
  mapy NUMBER (10),
  restaurant_auth NUMBER(1) DEFAULT 0 NOT NULL
);


--메뉴 정보 담아줄용
CREATE TABLE restaurant_menu (
  menu_id NUMBER(10) PRIMARY KEY,
  restaurant_id NUMBER(10) REFERENCES restaurant(restaurant_id) NOT NULL,
  menu VARCHAR2(255) NOT NULL,
  price NUMBER(10, 2) NOT NULL
);

-- 위시리스트
CREATE TABLE wishlist (
  user_idx NUMBER(10) REFERENCES users(user_idx),
  restaurant_id NUMBER(10) REFERENCES restaurant(restaurant_id),
  PRIMARY KEY (user_idx, restaurant_id)
);


-- 맛집 리뷰
CREATE TABLE review (
  review_id NUMBER(10) PRIMARY KEY,
  user_idx NUMBER(10) REFERENCES users(user_idx) NOT NULL,
  restaurant_id NUMBER(10) REFERENCES restaurant(restaurant_id) NOT NULL,
  review_content VARCHAR2(4000) NOT NULL,
  review_regdate DATE NOT NULL,
  review_grade NUMBER(2,1),
  review_auth NUMBER(1) DEFAULT 0 NOT NULL
);


-- 검색기록
CREATE TABLE search (
  search_id NUMBER(10) PRIMARY KEY,
  user_idx NUMBER(10) REFERENCES users(user_idx),
  search_name VARCHAR2(255),
  search_date DATE
);

commit;