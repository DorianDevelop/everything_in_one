/*DROP*/
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS hours;
DROP TABLE IF EXISTS weeks;
DROP TABLE IF EXISTS notes;

DROP TABLE IF EXISTS meal_foods;
DROP TABLE IF EXISTS sleeps;
DROP TABLE IF EXISTS workouts;
DROP TABLE IF EXISTS busy_times;
DROP TABLE IF EXISTS meal_prep;
DROP TABLE IF EXISTS meal_prep_foods;
DROP TABLE IF EXISTS weights;
DROP TABLE IF EXISTS meals;
DROP TABLE IF EXISTS days;
DROP TABLE IF EXISTS foods;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

/*GENERAL*/

CREATE TABLE users (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    pseudo varchar(50) not null
);

CREATE TABLE notes (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    id_user int not null,
    title varchar(150) not null,
    description varchar(1084),
    FOREIGN KEY (id_user) REFERENCES users(id) 
        ON DELETE CASCADE
);

CREATE TABLE weeks (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    id_user int not null,
    begin_date DATE not null,
    hours decimal default 0,
    FOREIGN KEY (id_user) REFERENCES users(id) 
        ON DELETE CASCADE   
);

CREATE TABLE hours (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    id_week int not null,
    input_hour decimal not null,
    FOREIGN KEY (id_week) REFERENCES weeks(id) 
        ON DELETE CASCADE   
);

/*Diet*/

/*FOOD TYPES : CUSTOM : MEAT : VEGGIE : FRUIT : CARB : PROCESSED : GRAINS : LIQUID : DAIRY*/
/*MAIN NUTRIENT : BALANCED : FAT : CARBS : PROTEIN : SUGAR : FIBER*/

CREATE TABLE foods(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) not null,
    type varchar(10) not null default 'CUSTOM',
    main_nutrient varchar(10) not null default 'BALANCED',
    serving_quantity int not null default 100,
    fat float DEFAULT 0,
    carbs float DEFAULT 0,
    sugar float DEFAULT 0,
    fiber float DEFAULT 0,
    protein float DEFAULT 0
);

CREATE TABLE days(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    day_date DATE not null,
    id_user int not null,
    all_fat float DEFAULT 0,
    all_carbs float DEFAULT 0,
    all_protein float DEFAULT 0,
    FOREIGN KEY (id_user) REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE meals(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) not null default "Meal",
    id_day int not null,
    total_fat float DEFAULT 0,
    total_carbs float DEFAULT 0,
    total_protein float DEFAULT 0,
    FOREIGN KEY (id_day) REFERENCES days(id)
        ON DELETE CASCADE
);

CREATE TABLE meal_foods(
	id_meal int not null,
    id_food int not null,
    quantity int not null  default 0,
    FOREIGN KEY (id_meal) REFERENCES meals(id)
        ON DELETE CASCADE,
    FOREIGN KEY (id_food) REFERENCES foods(id)
        ON DELETE CASCADE,
    PRIMARY KEY(id_meal, id_food)
);

CREATE TABLE workouts(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    start_min float not null  default 780,
    duration_min float not null  default 30,
    type int not null  default 0,
    id_day int not null,
    FOREIGN KEY (id_day) REFERENCES days(id)
        ON DELETE CASCADE
);

CREATE TABLE sleeps(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    start_min float not null  default 1410,
    duration_min float not null  default 480,
    id_day int not null,
    FOREIGN KEY (id_day) REFERENCES days(id)
        ON DELETE CASCADE
);

CREATE TABLE busy_times(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    start_min float not null  default 780,
    duration_min float not null  default 0,
    id_day int not null,
    FOREIGN KEY (id_day) REFERENCES days(id)
        ON DELETE CASCADE
);

CREATE TABLE meal_prep(
	id int not null AUTO_INCREMENT PRIMARY KEY,
	name varchar(255) not null,
    id_user int not null,
    FOREIGN KEY (id_user) REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE meal_prep_foods(
	id_meal int not null,
    id_food int not null,
    quantity int not null  default 0,
    FOREIGN KEY (id_meal) REFERENCES meals(id)
        ON DELETE CASCADE,
    FOREIGN KEY (id_food) REFERENCES foods(id) 
        ON DELETE CASCADE,
    PRIMARY KEY(id_meal, id_food)
);

CREATE TABLE weights(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    weight float not null,
    weight_date DATE not null,
    id_user int not null,
    FOREIGN KEY (id_user) REFERENCES users(id) 
    	ON DELETE CASCADE
);

/*INSERT*/

INSERT INTO users(pseudo) VALUES ("_Dorian");

/*FOOD TYPES : CUSTOM : MEAT : VEGGIE : FRUIT : CARB : PROCESSED : GRAINS : LIQUID : DAIRY*/
/*MAIN NUTRIENT : BALANCED : FAT : CARBS : PROTEIN : SUGAR : FIBER*/

INSERT INTO foods (name, type, main_nutrient, serving_quantity, fat, carbs, sugar, fiber, protein) VALUES 
("Pomme", "FRUIT", "SUGAR", 100, 0.1, 13, 10, 2.5, 0.2),
("Banane", "FRUIT", "SUGAR", 100, 0.3, 23, 12, 2.5, 1),
("Fraise", "FRUIT", "SUGAR", 100, 0.3, 7.6, 5, 2, 0.6),
("Mûre", "FRUIT", "FIBER", 100, 0.5, 9.6, 4.9, 5.3, 1.3),
("Ananas", "FRUIT", "SUGAR", 100, 0.1, 13, 9.8, 1.4, 0.5),
("Mangue", "FRUIT", "SUGAR", 100, 0.4, 15, 13.6, 1.6, 0.8),
("Myrtille", "FRUIT", "SUGAR", 100, 0.3, 14.5, 10, 2.4, 0.7),
("Avocat", "FRUIT", "FAT", 100, 14.6, 8.5, 0.7, 6.7, 2),
("Raisin", "FRUIT", "SUGAR", 100, 0.3, 17.1, 16.2, 0.9, 0.6),
("Kiwi", "FRUIT", "SUGAR", 100, 0.5, 14.6, 9, 3, 1.1),
("Citron", "FRUIT", "FIBER", 100, 0.3, 9.3, 2.5, 2.8, 1.1),
("Citron vert", "FRUIT", "FIBER", 100, 0.2, 10.5, 1.7, 2.8, 0.7),
("Orange", "FRUIT", "SUGAR", 100, 0.1, 11.7, 9.3, 2.4, 0.9),
("Poulet - fillet", "MEAT", "PROTEIN", 100, 4.7, 0.5, 0, 0, 33.4),
("Dinde - fillet", "MEAT", "PROTEIN", 100, 7, 0, 0, 0, 22),
("Poulet - haché", "MEAT", "PROTEIN", 100, 10.9, 0, 0, 0, 23),
("Dinde - haché", "MEAT", "PROTEIN", 100, 10.4, 0, 0, 0, 27),
("Boeuf - haché", "MEAT", "PROTEIN", 100, 15.3, 0, 0, 0, 23.9),
("Boeuf - steak", "MEAT", "PROTEIN", 100, 19, 0, 0, 0, 25),
("Boeuf", "MEAT", "PROTEIN", 100, 6.5, 0, 0, 0, 27.5),
("Porc - bacon", "MEAT", "FAT", 100, 43.2, 1.3, 0, 0, 35.7),
("Porc - cotelette", "MEAT", "PROTEIN", 100, 14.3, 0, 0, 0, 23.7),
("Boeuf - boulette", "MEAT", "PROTEIN", 100, 22.2, 8, 3.4, 2.3, 14.4),
("Oeuf", "DAIRY", "PROTEIN", 100, 10.6, 1.1, 1.1, 0, 12.5),
("Oeuf - blanc", "DAIRY", "PROTEIN", 100, 0.2, 0.7, 0.7, 0, 10.9),
("Oeuf - jaune", "DAIRY", "FAT", 100, 26.54, 3.6, 0.5, 0, 15.86),
("Cheddar", "DAIRY", "FAT", 100, 33.3, 0.5, 0.5, 0, 22.9),
("Brie", "DAIRY", "FAT", 100, 27.7, 0.4, 0.4, 0, 20.7),
("Camembert", "DAIRY", "FAT", 100, 24.3, 0.4, 0.4, 0, 19.8),
("Frommage bleu", "DAIRY", "FAT", 100, 28.7, 2.3, 0.5, 0, 21.4),
("Yaourt grec", "DAIRY", "PROTEIN", 100, 5, 4, 4, 0, 9),
("Mozzarella", "DAIRY", "FAT", 100, 17, 3.1, 1.2, 0, 27.5),
("Parmigiano-reggiano", "DAIRY", "FAT", 100, 20, 1.3, 0, 0, 20),
("Beurre", "DAIRY", "FAT", 100, 81.1, 0, 0, 0, 0.8),
("Huile d'olive", "LIQUID", "FAT", 100, 100, 0, 0, 0, 0)