CREATE TABLE members (
	mid INT PRIMARY KEY,
	lastname VARCHAR(40),
	firstname VARCHAR(40),
	address VARCHAR(100),
	contact INT,
	dob DATE,
	email VARCHAR(100)
);

CREATE TABLE membership (
	doj DATE,
	mid INT,
	borrowcount INT,
	latefees DECIMAL,
	FOREIGN KEY(mid) REFERENCES members(mid) ON UPDATE CASCADE,
	PRIMARY KEY(doj, mid)
);

CREATE TABLE loginAccess (
	aid INT,
	pwd VARCHAR(20),
	PRIMARY KEY(aid)
);

CREATE TABLE memLogin (
	mid INT,
	aid INT,
	FOREIGN KEY(mid) REFERENCES members(mid) ON UPDATE CASCADE,
	PRIMARY KEY(aid)
);

CREATE TABLE documentType (
	dtid INT PRIMARY KEY,
	doctype VARCHAR(20)
);
	
CREATE TABLE documents (
	did INT PRIMARY KEY,
	title VARCHAR(100),
	publisher VARCHAR(40),
	publishyear INT,
	edition INT,
	issueno INT,
	issuedate DATE,
	editor VARCHAR(100),
	docname VARCHAR(100),
	dtid INT,
	author VARCHAR(50),
	genre VARCHAR(50),
	FOREIGN KEY(dtid) REFERENCES documentType(dtid) ON UPDATE CASCADE
);

CREATE TABLE record (
	recid INT PRIMARY KEY,
	total INT,
	issued INT,
	remaining INT GENERATED ALWAYS AS (total - issued) STORED
);

CREATE TABLE details (
	recid INT PRIMARY KEY,
	did INT,
	FOREIGN KEY(recid) REFERENCES record(recid) ON UPDATE CASCADE,
	FOREIGN KEY(did) REFERENCES documents(did) ON UPDATE CASCADE
);

CREATE TABLE librarians (
	lid INT PRIMARY KEY,
	lastname VARCHAR(40),
	firstname VARCHAR(40),
	address VARCHAR(100),
	contact INT,
	doj DATE,
	dob DATE,
	email VARCHAR(100)
);
	
CREATE TABLE libLogin (
	lid INT,
	aid INT,
	FOREIGN KEY(lid) REFERENCES librarians(lid) ON UPDATE CASCADE,
	PRIMARY KEY(aid)
);

alter table documents add column lid int;
alter table documents add foreign key(lid) references librarians(lid) on update cascade;

INSERT INTO documenttype VALUES(1, 'Book');
INSERT INTO documenttype VALUES(2, 'Journal Article');
INSERT INTO documenttype VALUES(3, 'Magazine');
INSERT INTO documenttype VALUES(4, 'Thesis');
INSERT INTO documenttype VALUES(5, 'Technical Report');

INSERT INTO librarians VALUES(1, 'Felix', 'Anthony', 'yadayada', '3344', '2015-08-15', '1998-11-30', 'anthonyf@g.com');
INSERT INTO librarians VALUES(2, 'DeWitt', 'Booker', 'hibijibi', '99999', '2019-12-25', '1975-05-02', 'dbooker@yuhu.com');
INSERT INTO librarians VALUES(3, 'Dawn', 'Jonty', 'cicily', '420', '2021-01-01', '1994-10-10', 'jdawg@bic.com');


INSERT INTO documents VALUES(1, 'Of Mice and Men', 'Puffin', 2001, 2, 5, '2008-04-12', 'John Douglas', null, 1, 'John', 'Fiction', 1);
INSERT INTO documents VALUES(2, 'The Big Bang', 'Sc.Edu', 2020, 1, 1, '2020-01-25', 'Paul Scott', 'Science Journal', 2, 'Bob', 'Science', 2);
INSERT INTO documents VALUES(3, 'The 4th Issue', 'Dunkin', 1956, 1, 4, '1956-09-05', 'Adam Dunn', 'Vogue', 3, 'Stan Edgar', 'Fashion', 3);
INSERT INTO documents VALUES(4, 'What goes on in a cats mind?', 'Scholastic', 1989, null, null, '21-03-11', 'paddy', 'Tech Magazine', 5, 'RGB', 'Technology', 1);


ALTER TABLE members add duedate DATE;
ALTER TABLE members add returndate DATE;
ALTER TABLE members add did INT;
ALTER TABLE members add ontime boolean;
ALTER TABLE members add FOREIGN KEY(did) REFERENCES documents(did) on update cascade;


INSERT INTO members VALUES(1, 'Deshpande', 'Paddyesh', 'abcd', '1234', '2000-04-05', 'padyesh@padri.com', '2022-12-10', '2022-12-5', 2, 'YES');
INSERT INTO members VALUES(2, 'Ganguli', 'Rix', 'cdef', '5678', '2000-03-08', 'rix@rik.com', '2022-11-11', '2022-12-1', 1, 'NO');
INSERT INTO members VALUES(3, 'Bone', 'V', '401 E', '2468', '1999-10-01', 'vbone@bub.com', '2021-06-12', '2021-06-11', 3, 'YES');

INSERT INTO loginaccess VALUES(1, '123');
INSERT INTO loginaccess VALUES(2, '456');

ALTER TABLE memlogin add FOREIGN KEY(aid) references loginaccess(aid) ON UPDATE CASCADE;
ALTER TABLE liblogin add FOREIGN KEY(aid) references loginaccess(aid) ON UPDATE CASCADE;

INSERT INTO liblogin VALUES(1, 2);
INSERT INTO memlogin VALUES(2, 1);

INSERT INTO record VALUES(1, 5, 3);
INSERT INTO record VALUES(2, 3, 3);
INSERT INTO record VALUES(3, 4, 1);
INSERT INTO record VALUES(4, 3, 0);

INSERT INTO details VALUES(1, 3);
INSERT INTO details VALUES(3, 2);
INSERT INTO details VALUES(2, 1);
INSERT INTO details VALUES(4, 4);


INSERT INTO membership VALUES('2007-02-28', 1, 5, 5);
INSERT INTO membership VALUES('2010-11-03', 2, 10, 1);
INSERT INTO membership VALUES('1992-08-18', 3, 32, 12);