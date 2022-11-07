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

/*day-4*/
CREATE TABLE vets (
    id INT primary key generated always as identity,
    name VARCHAR(80) NOT NULL,
    age INT NOT NULL,
	date_of_graduation DATE
);

CREATE TABLE specializations (
    id INT primary key generated always as identity,
    vets_id INT NULL REFERENCES vets(id),
	species_id INT NULL REFERENCES species(id)
);

CREATE TABLE visits (
    id INT primary key generated always as identity,
    vets_id INT NULL REFERENCES vets(id),
	animals_id INT NULL REFERENCES animals(id),
	visit_date DATE NULL
);

/* Block-2 */
/*Day-1*/
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create index to increase performance speed
CREATE INDEX animal_id_desc ON visits(animal_id DESC);

CREATE INDEX vets_id_desc ON visits(vets_id DESC);
CREATE INDEX owner_email_desc ON owners(email DESC);
