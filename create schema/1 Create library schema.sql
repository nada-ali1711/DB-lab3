create schema SAMPLEx;
use SAMPLEx;


create table PUBLISHER(
PName varchar(20),
Address varchar(50),
Phone varchar(15),

constraint PUBpk
primary key (Pname)
);

create Table Book(
Book_id integer,
Title varchar(20) not null,
Publisher_name varchar(30) not null,

Constraint BOOKpk
Primary key (Book_id),
Constraint BOOKfk
foreign key (Publisher_name) references PUBLISHER(PName)
);

create table BOOK_AUTHORS(
Book_id integer,
Author_name varchar(20) not null,

constraint AUTHfk
foreign key (Book_id) references BOOK(Book_id)
);

create table LIBRARY_BRANCH(
Branch_id integer,
Branch_name varchar(10) not null unique,
Address varchar(20) not null,

constraint BRANCHpk
primary key (Branch_id)
);

create table BORROWER(
Card_no integer,
Borrower_name varchar(20) not null,
Address varchar(20),
Phone varchar(15) unique,

constraint BORROWpk
primary key (Card_no)
);

create table BOOK_COPIES(
Book_id integer,
Branch_id integer,
No_of_copies integer not null,

constraint BOOKCPpk
primary key (Book_id, Branch_id),
constraint BOOKCPfkBOOK
foreign key (Book_id) references BOOK(Book_id),
constraint BOOKCPfkBRANCH
foreign key (Branch_id) references LIBRARY_BRANCH(Branch_id)
);

create table BOOK_LOANS(
Book_id integer,
Branch_id integer,
Card_no integer,
Date_out date not null,
Due_date date not null,

constraint BOOKLNpk
primary key (Book_id, Branch_id, Card_no),
constraint BOOKLNfkBOOK
foreign key (Book_id) references BOOK(Book_id),
constraint BOOKLNfkBRANCH
foreign key (Branch_id) references LIBRARY_BRANCH(Branch_id),
constraint BOOKLNfkBORROW
foreign key (Card_no) references BORROWER(Card_no)
);
