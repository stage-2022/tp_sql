-- SQLite
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ingredients_recipes;
DROP TABLE IF EXISTS ingredients;
DROP TABLE IF EXISTS categories_recipes;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS users;



CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username VARCHAR(150) ,
    email VARCHAR(150) 
   
); 


CREATE TABLE recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    date DATETIME,
    duration INTEGER DEFAULT 0 NOT NULL,
    user_id INTEGER NOT NULL ,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
); 


CREATE TABLE categories (
id integer PRIMARY KEY AUTOINCREMENT NOT NULL,
title varchar(150) NOT NULL
);

CREATE TABLE categories_recipes (
recipe_id integer NOT NULL,
category_id integer NOT NULL,
FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE ingredients (
id integer PRIMARY KEY AUTOINCREMENT NOT NULL,
name varchar(150)
);

CREATE TABLE ingredients_recipes (
recipe_id integer NOT NULL,
ingredient_id integer NOT NULL,
quantity integer,
unit varchar(20),
FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
PRIMARY KEY (recipe_id, ingredient_id),
UNIQUE (recipe_id, ingredient_id)
);


INSERT INTO users (username, email) VALUES
    ('hajer zitouni', 'hajer@gmail.com');


INSERT INTO categories (title) VALUES
  ('plats'),
  ('dessert'),
  ('gateau');

INSERT INTO recipes (title, slug, duration, user_id) VALUES
     ('soupe' , 'soupe',10, 1),
     ('madeleine' , 'madeleine',30, 1);

INSERT INTO categories_recipes (recipe_id, category_id) VALUES
      (1, 1),
      (2, 2),
      (2, 3);

INSERT INTO ingredients (name) VALUES
('sucre'),
('farine'),
('beurre'),
('lait'),
('oeuf');


INSERT INTO ingredients_recipes (recipe_id, ingredient_id, quantity, unit) VALUES
(2,1,150,'g'),
(2,2,200,'g'),
(2,3,8,'g'),
(2,4,100,'g'),
(2,5,50,NULL);


SELECT *
FROM recipes r 
JOIN categories_recipes cr ON cr.recipe_id = r.id;


select *
FROM ingredients i
JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
JOIN recipes r ON ir.recipe_id = r.id
WHERE i.name='oeuf';

DELETE FROM ingredients WHERE id=3;

SELECT r.title, ir.quantity, ir.unit, i.name as ingredient
FROM recipes r 
JOIN ingredients_recipes ir ON ir.recipe_id = r.id
JOIN ingredients i ON ir.ingredient_id = i.id;

UPDATE ingredients_recipes
SET quantity = 10
WHERE recipe_id = 2 AND ingredient_id = 3;


