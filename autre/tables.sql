/*DROP*/
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS hours;
DROP TABLE IF EXISTS weeks;
DROP TABLE IF EXISTS notes;

DROP TABLE IF EXISTS meal_foods;
DROP TABLE IF EXISTS sleeps;
DROP TABLE IF EXISTS exercice_muscles;
DROP TABLE IF EXISTS muscles;
DROP TABLE IF EXISTS sets;
DROP TABLE IF EXISTS workout_exercices;
DROP TABLE IF EXISTS exercices;
DROP TABLE IF EXISTS workouts;
DROP TABLE IF EXISTS busy_times;
DROP TABLE IF EXISTS meal_prep;
DROP TABLE IF EXISTS meal_prep_foods;
DROP TABLE IF EXISTS weights;
DROP TABLE IF EXISTS day_foods;
DROP TABLE IF EXISTS meals;
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
    description varchar(4096),
    FOREIGN KEY (id_user) REFERENCES users(id) 
        ON DELETE CASCADE
);

ALTER TABLE notes CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

CREATE TABLE hours (
	id int not null AUTO_INCREMENT PRIMARY KEY,
    id_user int not null,
    input_hour int not null,
    FOREIGN KEY (id_user) REFERENCES users(id) 
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

CREATE TABLE meals(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) not null default "Meal",
    the_date DATE NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE day_foods(
    the_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    id_food int not null,
    id_meal int,
    quantity int not null  default 0,
    FOREIGN KEY (id_food) REFERENCES foods(id)
        ON DELETE CASCADE,
    FOREIGN KEY (id_meal) REFERENCES meals(id)
        ON DELETE CASCADE,
    PRIMARY KEY(the_date, id_food)
);


/*Workouts types : FACILE, MOYEN, DUR, TRÈS DUR*/

CREATE TABLE workouts(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    start_min float not null  default 780,
    duration_min float not null  default 30,
    name varchar(150) not null default "Weightlifting",
    type varchar(10) not null  default "MOYEN",
    the_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    id_user int not null,
    FOREIGN KEY (id_user) REFERENCES users(id)
        ON DELETE CASCADE
);



/*Exercices types : BRAS, ÉPAULES, PECTORAUX, DOS, ABDOMINAUX, JAMBES*/
/*Exercices sub_types : BRAS, ÉPAULES, PECTORAUX, DOS, ABDOMINAUX, JAMBES*/

CREATE TABLE muscles(
    id int not null AUTO_INCREMENT PRIMARY KEY,
    muscle_group varchar(50) not null default "INCONNUE"
);

CREATE TABLE exercices(
    id int not null AUTO_INCREMENT PRIMARY KEY,
    name varchar(150) not null,
    online_image varchar(1024)
);


/*exercice_muscles roles {0: idk, 1: a little, 2: also trained, 3: mainly trained, 4: only trained}*/

CREATE TABLE exercice_muscles(
	id_exercice int not null,
    id_muscle int not null,
    role int not null  default 0,
    FOREIGN KEY (id_exercice) REFERENCES exercices(id)
        ON DELETE CASCADE,
    FOREIGN KEY (id_muscle) REFERENCES muscles(id)
        ON DELETE CASCADE,
    PRIMARY KEY(id_exercice, id_muscle)
);

CREATE TABLE workout_exercices(
    id int not null AUTO_INCREMENT,
	id_exercice int not null,
    id_workout int not null,
    sets_number int not null default 3,
    notes varchar(255),
    FOREIGN KEY (id_exercice) REFERENCES exercices(id)
        ON DELETE CASCADE,
    FOREIGN KEY (id_workout) REFERENCES workouts(id)
        ON DELETE CASCADE,
    PRIMARY KEY(id, id_exercice, id_workout)
);

/*sets_feelings : {0: nothing special, 1: near faillur, 2:faillur, 3:past faillur, 4:hurted wasn't able to finish}*/

CREATE TABLE sets(
    id int not null AUTO_INCREMENT,
    id_workout_exercice int not null,
    reps_number int not null default 10,
    weight_used int not null default 0,
    feelings int default 0,
    FOREIGN KEY (id_workout_exercice) REFERENCES workout_exercices(id)
        ON DELETE CASCADE,
    PRIMARY KEY(id, id_workout_exercice)
);


CREATE TABLE sleeps(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    start_min float not null  default 1410,
    duration_min float not null  default 480,
    the_date DATE NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE busy_times(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    start_min float not null  default 780,
    duration_min float not null  default 0,
    the_date DATE NOT NULL DEFAULT (CURRENT_DATE)
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