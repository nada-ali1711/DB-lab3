insert into publisher values ("Simon & schuster", "Chicago, US", "0321344543");
insert into publisher values ("Penguin", "NY, US", "0234356325");
insert into publisher values ("Random House", "WA, US", "04563456082");
insert into publisher values ("Spectra", "Chicago, US", "0593034500");
insert into publisher values ("Move Books", "Montrial, Canada", "033434350056");
insert into publisher values ("Knopf Books", "Vancouver, Canada", "011596621744");

insert into book values (0, "The Lost Tribe", "Move Books");
insert into book values (1, "It", "Simon & schuster");
insert into book values (2, "Doctor Sleep", "Simon & schuster");
insert into book values (3, "Hello World", "Random House");
insert into book values (4, "Humble PI", "Penguin");
insert into book values (5, "Foundation", "Spectra");
insert into book values (6, "The Book Thief", "Knopf Books");
insert into book values (7, "Second Foundation", "Spectra");

insert into book_authors values (0, "C. Taylor Butler");
insert into book_authors values (1, "Stephen King");
insert into book_authors values (2, "Stephen King");
insert into book_authors values (3, "Hannah Fry");
insert into book_authors values (4, "Matt Parker");
insert into book_authors values (5, "Isaac Asimov");
insert into book_authors values (6, "Markus Zusak");
insert into book_authors values (7, "Isaac Asimov");

insert into library_branch values (0, "Sharpstown", "Baker st.");
insert into library_branch values (1, "Central", "Bleak st.");
insert into library_branch values (2, "Torus", "Houston st.");

insert into borrower values (0, "Abdelrahman", null, "01056584921");
insert into borrower values (1, "Nada", null, "01256584921");
insert into borrower values (2, "Maria", null, "01156584921");

insert into book_copies values (0, 0, 6);
insert into book_copies values (1, 0, 11);
insert into book_copies values (2, 0, 7);
insert into book_copies values (3, 0, 12);
insert into book_copies values (4, 0, 4);
insert into book_copies values (5, 0, 6);
insert into book_copies values (0, 1, 12);
insert into book_copies values (6, 1, 10);
insert into book_copies values (2, 1, 2);
insert into book_copies values (3, 1, 5);
insert into book_copies values (7, 1, 5);
insert into book_copies values (5, 1, 15);
insert into book_copies values (6, 2, 12);
insert into book_copies values (1, 2, 10);
insert into book_copies values (2, 2, 2);
insert into book_copies values (5, 2, 5);
insert into book_copies values (4, 2, 5);
insert into book_copies values (7, 2, 15);

insert into book_loans values (0, 1, 0, "2022-11-20", "2022-12-10");
insert into book_loans values (5, 1, 1, "2022-11-3", "2022-12-3");
insert into book_loans values (1, 2, 2, "2022-11-15", "2022-12-15");






