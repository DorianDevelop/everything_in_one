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
DROP TABLE IF EXISTS day_foods;
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
    FOREIGN KEY (id_day) REFERENCES days(id)
        ON DELETE CASCADE
);

CREATE TABLE day_foods(
	id_day int not null,
    id_food int not null,
    id_meal int,
    quantity int not null  default 0,
    FOREIGN KEY (id_day) REFERENCES days(id)
        ON DELETE CASCADE,
    FOREIGN KEY (id_food) REFERENCES foods(id)
        ON DELETE CASCADE,
    FOREIGN KEY (id_meal) REFERENCES meals(id)
        ON DELETE CASCADE,
    PRIMARY KEY(id_day, id_food)
);


/*Workouts types : FACILE, MOYEN, DUR, TRÈS DUR*/

CREATE TABLE workouts(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    start_min float not null  default 780,
    duration_min float not null  default 30,
    type varchar(10) not null  default "MOYEN",
    id_day int not null,
    FOREIGN KEY (id_day) REFERENCES days(id)
        ON DELETE CASCADE
);


/*Exercices types : BRAS, ÉPAULES, PECTORAUX, DOS, ABDOMINAUX, JAMBES*/
/*Exercices sub_types : BRAS, ÉPAULES, PECTORAUX, DOS, ABDOMINAUX, JAMBES*/

CREATE TABLE muscles(
    id int not null AUTO_INCREMENT PRIMARY KEY,
    muscle_group varchar(50) not null default "INCONNUE"
);

INSERT INTO muscles (muscle_group) VALUES
("BICEPS"),
("TRICEPS"),
("QUADRICEPS"),
("ABDOMINAUX"),
("OBLIQUES"),
("AVANT-BRAS"),
("ABDUCTEURS"),
("ADDUCTEURS"),
("MOLLETS"),
("FESSIERS"),
("ISCHIO-JAMBIER"),
("GRAND-DORSAL"),
("TRAPÈZES"),
("LOMBAIRES"),
("COUP"),
("ÉPAULES"),
("PECTORAUX");

CREATE TABLE exercices(
    id int not null AUTO_INCREMENT PRIMARY KEY,
    name varchar(150) not null,
    online_image varchar(1024)
);

INSERT INTO exercices(name, online_image) VALUES
/*Chest*/
("Barbell Bench Press", "https://static.strengthlevel.com/images/exercises/bench-press/howto/bench-press-howto-2-400.avif"),
("Incline Bench Press", "https://static.strengthlevel.com/images/exercises/incline-bench-press/howto/incline-bench-press-howto-2-400.avif"),
("Decline Bench Press", "https://static.strengthlevel.com/images/exercises/decline-bench-press/howto/decline-bench-press-howto-2-400.avif"),
("Smith Bench Press", "https://static.strengthlevel.com/images/exercises/smith-machine-bench-press/smith-machine-bench-press-400.avif"),
("Smith Incline Bench Press", "UUUUUUUUUUUUUU"),
("Dumbbell Flys", "https://static.strengthlevel.com/images/exercises/dumbbell-fly/howto/dumbbell-fly-howto-1-400.avif"),
("Dumbbell Bench Press", "https://static.strengthlevel.com/images/exercises/dumbbell-bench-press/howto/dumbbell-bench-press-howto-2-400.avif"),
("Incline Dumbbell Bench Press", "https://static.strengthlevel.com/images/exercises/incline-dumbbell-bench-press/howto/incline-dumbbell-bench-press-howto-1-400.avif"),
("Decline Dumbbell Bench Press", "https://static.strengthlevel.com/images/exercises/decline-dumbbell-bench-press/decline-dumbbell-bench-press-400.avif"),
("Dumbbell Pullover", "https://static.strengthlevel.com/images/exercises/dumbbell-pullover/dumbbell-pullover-400.avif"),
("Machine Chest Fly", "https://static.strengthlevel.com/images/exercises/machine-chest-fly/machine-chest-fly-400.avif"),
("Cable fly", "https://static.strengthlevel.com/images/exercises/cable-fly/cable-fly-400.avif"),
("Chest Dip", "https://static.strengthlevel.com/images/exercises/dips/howto/dips-howto-2-400.avif"),
("Push Up", "https://static.strengthlevel.com/images/exercises/push-ups/howto/push-ups-howto-2-400.avif"),
/*Abs*/
("Cable Crunch", "https://static.strengthlevel.com/images/exercises/cable-crunch/cable-crunch-400.avif"),
("Ab Crunch", "https://static.strengthlevel.com/images/exercises/crunches/crunches-400.avif"),
("Standing Cable Crunch", "https://static.strengthlevel.com/images/exercises/standing-cable-crunch/standing-cable-crunch-400.avif"),
("Bicycle Crunch", "https://static.strengthlevel.com/images/exercises/bicycle-crunch/bicycle-crunch-400.avif"),
("Sit Up", "UUUUUUUUUUUUUU"),
("Machine Seated Crunch", "https://static.strengthlevel.com/images/exercises/machine-seated-crunch/machine-seated-crunch-400.avif"),
("Reverse Crunches", "https://static.strengthlevel.com/images/exercises/reverse-crunches/reverse-crunches-400.avif"),
("Straight Leg Toe Touch", "UUUUUUUUUUUUUU"),
("Decline Crunch", "https://static.strengthlevel.com/images/exercises/decline-crunch/decline-crunch-400.avif"),
/*Biceps*/
("Standing Dumbbell Curl", "https://static.strengthlevel.com/images/exercises/dumbbell-curl/howto/dumbbell-curl-howto-2-400.avif"),
("Incline Dumbbell Curl", "https://static.strengthlevel.com/images/exercises/incline-dumbbell-curl/incline-dumbbell-curl-400.avif"),
("Concentration Curl", "https://static.strengthlevel.com/images/exercises/dumbbell-concentration-curl/dumbbell-concentration-curl-400.avif"),
("Incline Cable Curl", "https://static.strengthlevel.com/images/exercises/incline-cable-curl/incline-cable-curl-400.avif"),
("Standing Barbell Curl", "https://static.strengthlevel.com/images/exercises/barbell-curl/howto/barbell-curl-howto-2-400.avif"),
("Standing Hammer Curl", "https://static.strengthlevel.com/images/exercises/hammer-curl/hammer-curl-400.avif"),
("Bar Preacher Curl", "https://static.strengthlevel.com/images/exercises/preacher-curl/preacher-curl-400.avif"),
("Cable Curl", "https://static.strengthlevel.com/images/exercises/cable-bicep-curl/cable-bicep-curl-400.avif"),
("One Hand Cable Curl", "https://static.strengthlevel.com/images/exercises/one-arm-cable-bicep-curl/one-arm-cable-bicep-curl-400.avif"),
("Machine Bicep Curl", "https://static.strengthlevel.com/images/exercises/machine-bicep-curl/machine-bicep-curl-400.avif"),
("Reverse Curl", "https://static.strengthlevel.com/images/exercises/reverse-barbell-curl/reverse-barbell-curl-400.avif"),
("Overhead Cable Curl", "https://static.strengthlevel.com/images/exercises/overhead-cable-curl/overhead-cable-curl-400.avif"),
("Spider Curl", "https://static.strengthlevel.com/images/exercises/spider-curl/spider-curl-400.avif"),
/*Triceps*/
("Straight Bar Tricep Extension", "https://static.strengthlevel.com/images/exercises/tricep-pushdown/tricep-pushdown-400.avif"),
("Rope Tricep Extension", "https://static.strengthlevel.com/images/exercises/tricep-rope-pushdown/tricep-rope-pushdown-400.avif"),
("Dumbbell Tricep Extension", "https://static.strengthlevel.com/images/exercises/dumbbell-tricep-extension/dumbbell-tricep-extension-400.avif"),
("Bar Skullcrusher", "UUUUUUUUUUUUUU"),
("Dip Machine", "https://static.strengthlevel.com/images/exercises/seated-dip-machine/seated-dip-machine-400.avif"),
("Close Grip Bench Press", "UUUUUUUUUUUUUU"),
("Cable Overhead Tricep Extension", "https://static.strengthlevel.com/images/exercises/cable-overhead-tricep-extension/cable-overhead-tricep-extension-400.avif"),
("Rope Overhead Tricep Extension", "UUUUUUUUUUUUUU"),
("Close Grip Push Up", "UUUUUUUUUUUUUU"),
("Machine Tricep Extension", "https://static.strengthlevel.com/images/exercises/machine-tricep-extension/machine-tricep-extension-400.avif"),
("One-Arm Cable Tricep Extension", "UUUUUUUUUUUUUU"),
("Cable Tricep Kickback", "UUUUUUUUUUUUUU"),
("Dumbell Tricep Kickback", "https://static.strengthlevel.com/images/exercises/dumbbell-tricep-kickback/dumbbell-tricep-kickback-400.avif"),
/*Avant-bras*/
("Barbell Reverse Wrist Curl", "https://static.strengthlevel.com/images/exercises/dumbbell-reverse-wrist-curl/dumbbell-reverse-wrist-curl-400.avif"),
("Barbell Wrist Curl", "https://static.strengthlevel.com/images/exercises/dumbbell-wrist-curl/dumbbell-wrist-curl-400.avif"),
("Dumbbell Farmers Carry", "UUUUUUUUUUUUUU"),
("Reverse Grip Barbell Curl", "UUUUUUUUUUUUUU"),
("Reverse Grip Cable Curl", "UUUUUUUUUUUUUU"),
("Wrist Rollers", "UUUUUUUUUUUUUU"),
("One Hand Cable Forearm Curl", "UUUUUUUUUUUUUU"),
/*Fessiers*/
("Barbell Hip Thrust", "https://static.strengthlevel.com/images/exercises/hip-thrust/hip-thrust-400.avif"),
("Machine Hip Thrust", "UUUUUUUUUUUUUU"),
("Wide Smith Machine Squat", "UUUUUUUUUUUUUU"),
("Cable Kickback", "https://static.strengthlevel.com/images/exercises/cable-kickback/cable-kickback-400.avif"),
/*Abducteurs*/
("Machine Abductors", "https://static.strengthlevel.com/images/exercises/hip-abduction/hip-abduction-400.avif"),
/*Adducteurs*/
("Machine Adductors", "https://static.strengthlevel.com/images/exercises/hip-adduction/hip-adduction-400.avif"),
/*Mollets*/
("Seated Calf Raise", "UUUUUUUUUUUUUU"),
("Leg Press Calf Raise", "https://static.strengthlevel.com/images/exercises/sled-press-calf-raise/sled-press-calf-raise-400.avif"),
("Standing Machine Calf Raise", "https://static.strengthlevel.com/images/exercises/machine-calf-raise/machine-calf-raise-400.avif"),
("Standing Calf Raise", "https://static.strengthlevel.com/images/exercises/dumbbell-calf-raise/dumbbell-calf-raise-400.avif"),
("Smith Machine Calf Raise", "UUUUUUUUUUUUUU"),
/*Ischio Jambiers*/
("Dumbbell Stiff Leg Deadlift", "UUUUUUUUUUUUUU"),
("Conventional Deadlift", "UUUUUUUUUUUUUU"),
("Nordic Hamstring Curl", "https://static.strengthlevel.com/images/exercises/nordic-hamstring-curl/nordic-hamstring-curl-400.avif"),
("Leg Curl", "https://static.strengthlevel.com/images/exercises/lying-leg-curl/lying-leg-curl-400.avif"),
("Seated Leg Curl", "https://static.strengthlevel.com/images/exercises/seated-leg-curl/seated-leg-curl-400.avif"),
("Dumbbell Hamstring Curl", "UUUUUUUUUUUUUU"),
("Standing Cable Hamstring Curl", "UUUUUUUUUUUUUU"),
/*Quadriceps*/
("Belt Squat", "https://static.strengthlevel.com/images/exercises/belt-squat/belt-squat-400.avif"),
("Barbell Back Squat", "https://static.strengthlevel.com/images/exercises/squat/squat-400.avif"),
("Smith Back Squat", "https://static.strengthlevel.com/images/exercises/smith-machine-squat/smith-machine-squat-400.avif"),
("Dumbbell Goblet Squat", "https://static.strengthlevel.com/images/exercises/goblet-squat/goblet-squat-400.avif"),
("Leg Press", "https://static.strengthlevel.com/images/exercises/sled-leg-press/sled-leg-press-400.avif"),
("Leg Extension", "https://static.strengthlevel.com/images/exercises/leg-extension/leg-extension-400.avif"),
("Front Squat", "https://static.strengthlevel.com/images/exercises/front-squat/front-squat-400.avif"),
("Machine Hack Squat", "https://static.strengthlevel.com/images/exercises/hack-squat/hack-squat-400.avif"),
("Smith Machine Leg Press", "UUUUUUUUUUUUUU"),
("Vertical Leg Press", "https://static.strengthlevel.com/images/exercises/vertical-leg-press/vertical-leg-press-400.avif"),
("Horizontal Leg Press", "https://static.strengthlevel.com/images/exercises/horizontal-leg-press/horizontal-leg-press-400.avif"),
("Horizontal Hack Squat Press", "UUUUUUUUUUUUUU"),
("Safety Bar Squat", "https://static.strengthlevel.com/images/exercises/safety-bar-squat/safety-bar-squat-400.avif"),
/*Épaules*/
("Dumbbell Lateral Raise", "https://static.strengthlevel.com/images/exercises/dumbbell-lateral-raise/dumbbell-lateral-raise-400.avif"),
("Cable Lateral Raise", "https://static.strengthlevel.com/images/exercises/cable-lateral-raise/cable-lateral-raise-400.avif"),
("Seated Dumbell Shoulder Press", "https://static.strengthlevel.com/images/exercises/seated-dumbbell-shoulder-press/seated-dumbbell-shoulder-press-400.avif"),
("Overhead Press", "https://static.strengthlevel.com/images/exercises/shoulder-press/shoulder-press-400.avif"),
("Smith Machine Shoulder Press", "UUUUUUUUUUUUUU"),
("Handstand Push Ups", "https://static.strengthlevel.com/images/exercises/handstand-push-ups/handstand-push-ups-400.avif"),
("Cable Face Pull", "https://static.strengthlevel.com/images/exercises/face-pull/face-pull-400.avif"),
("Seated Bent Over Dumbbell Reverse Fly", "https://static.strengthlevel.com/images/exercises/dumbbell-reverse-fly/dumbbell-reverse-fly-400.avif"),
("Standing Cable Reverse Fly", "https://static.strengthlevel.com/images/exercises/cable-reverse-fly/cable-reverse-fly-400.avif"),
("Machine Reverse Fly", "https://static.strengthlevel.com/images/exercises/machine-reverse-fly/machine-reverse-fly-400.avif"),
("Arnold Press", "https://static.strengthlevel.com/images/exercises/arnold-press/arnold-press-400.avif"),
("Machine Shoulder Press", "https://static.strengthlevel.com/images/exercises/machine-shoulder-press/machine-shoulder-press-400.avif"),
("Cable Upright Row", "https://static.strengthlevel.com/images/exercises/upright-row/upright-row-400.avif"),
("Barbell Upright Row", "https://static.strengthlevel.com/images/exercises/upright-row/upright-row-400.avif"),
/*Trapèzes*/
("Dumbbell Shrug", "https://static.strengthlevel.com/images/exercises/dumbbell-shrug/dumbbell-shrug-400.avif"),
("Barbell Shrug", "https://static.strengthlevel.com/images/exercises/barbell-shrug/howto/barbell-shrug-howto-2-400.avif"),
("Seated Dumbbell Shrug", "https://static.strengthlevel.com/images/exercises/dumbbell-shrug/dumbbell-shrug-400.avif"),
("Trap Bar Shrug", "https://static.strengthlevel.com/images/exercises/hex-bar-shrug/hex-bar-shrug-400.avif"),
("Barbel High Pull", "https://static.strengthlevel.com/images/exercises/clean-high-pull/clean-high-pull-400.avif"),
("Cable High Pull", "https://static.strengthlevel.com/images/exercises/clean-high-pull/clean-high-pull-400.avif"),
/*Coup*/
("Neck Curl", "https://static.strengthlevel.com/images/exercises/neck-curl/neck-curl-400.avif"),
("Band Neck Curl", "UUUUUUUUUUUUUU"),
/*Obliques*/
("Side Crunch", "https://static.strengthlevel.com/images/exercises/side-crunch/side-crunch-400.avif"),
("Dumbbell Side Bends", "https://static.strengthlevel.com/images/exercises/dumbbell-side-bend/dumbbell-side-bend-400.avif"),
("Wide Stance Cable Anti-Rotation", "UUUUUUUUUUUUUU"),
/*Grand dorsal*/
("Lat Pull Down", "https://static.strengthlevel.com/images/exercises/lat-pulldown/lat-pulldown-400.avif"),
("Close Grip Lat Pull Down", "https://static.strengthlevel.com/images/exercises/close-grip-lat-pulldown/close-grip-lat-pulldown-400.avif"),
("Chin Up", "https://static.strengthlevel.com/images/exercises/chin-ups/chin-ups-400.avif"),
("Pull Up", "https://static.strengthlevel.com/images/exercises/pull-ups/pull-ups-400.avif"),
("V-Bar Pull Down", "UUUUUUUUUUUUUU"),
("Straight Arm Pull Down", "https://static.strengthlevel.com/images/exercises/straight-arm-pulldown/straight-arm-pulldown-400.avif"),
("One Arm Lateral Pulldown", "https://static.strengthlevel.com/images/exercises/one-arm-lat-pulldown/one-arm-lat-pulldown-400.avif"),
/*Grand dorsal - haut*/
("Bent Over Row", "https://static.strengthlevel.com/images/exercises/bent-over-row/bent-over-row-400.avif"),
("Seated Cable Row", "https://static.strengthlevel.com/images/exercises/seated-cable-row/seated-cable-row-400.avif"),
("Machine Row", "https://static.strengthlevel.com/images/exercises/machine-row/machine-row-400.avif"),
("T-Bar Row", "https://static.strengthlevel.com/images/exercises/t-bar-row/t-bar-row-400.avif"),
("Smith Machine Bent-Over Row", "https://static.strengthlevel.com/images/exercises/bent-over-row/bent-over-row-400.avif"),
("Machine T-Bar Row", "https://static.strengthlevel.com/images/exercises/t-bar-row/t-bar-row-400.avif"),
("One Arm Dumbell Row", "https://static.strengthlevel.com/images/exercises/dumbbell-row/dumbbell-row-400.avif"),
("Wide Grip Cable Row", "https://static.strengthlevel.com/images/exercises/seated-cable-row/seated-cable-row-400.avif"),
("One Arm Cable Row", "https://static.strengthlevel.com/images/exercises/one-arm-seated-cable-row/one-arm-seated-cable-row-400.avif"),
/*Lombaires*/
("Superman", "https://static.strengthlevel.com/images/exercises/superman/superman-400.avif"),
("Deadlift", "https://static.strengthlevel.com/images/exercises/deadlift/deadlift-400.avif"),
("Hyper Extensions", "https://static.strengthlevel.com/images/exercises/back-extension/back-extension-400.avif");

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

INSERT INTO notes(id_user, title, description) VALUES (1, "Test", "Je test");

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
("Huile d'olive", "LIQUID", "FAT", 100, 100, 0, 0, 0, 0);

