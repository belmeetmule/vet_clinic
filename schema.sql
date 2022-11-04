/* Database schema to keep the structure of entire database. */

/* schema for animals table. */

DROP TABLE IF EXISTS animals;

CREATE TABLE animals (
id integer primary key generated always as identity,
name VARCHAR(30) NOT NULL,
date_of_birth DATE DEFAULT CURRENT_DATE,
escape_attempts INT DEFAULT 0,
neutered BOOLEAN,
weight_kg DECIMAL
);

/*day-2*/
ALTER TABLE animals
ADD species VARCHAR(80);

/*day-3*/
CREATE TABLE owners (
    id INT primary key generated always as identity,
    full_name VARCHAR(80) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE species (
    id INT primary key generated always as identity,
    name VARCHAR(80) NOT NULL
);

BEGIN;
ALTER TABLE animals 
    DROP COLUMN species,
    ADD species_id INT NULL REFERENCES species(id) ON DELETE CASCADE,
    ADD owner_id INT NULL REFERENCES owners(id) ON DELETE CASCADE;
COMMIT;
SELECT * FROM animals;


