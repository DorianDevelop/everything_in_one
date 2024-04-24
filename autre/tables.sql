CREATE TABLE users (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    pseudo varchar(50) not null
);

CREATE TABLE notes (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    id_user int not null,
    title varchar(150) not null,
    description varchar(1084),
    FOREIGN KEY id_user REFERENCES users(id)
);

CREATE TABLE weeks (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    id_user int not null,
    begin_date DATE not null,
    hours decimal default 0,
    FOREIGN KEY id_user REFERENCES users(id)   
);

CREATE TABLE hours (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    id_week int not null,
    input_hour decimal not null,
    FOREIGN KEY id_week REFERENCES weeks(id)   
);
