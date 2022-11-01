/* Database schema to keep the structure of entire database. */

/* schema for animals table. */
vet_clinic=# CREATE TABLE IF NOT EXISTS animals (
vet_clinic(# id SERIAL PRIMARY KEY NOT NULL,
vet_clinic(# name VARCHAR(30) NOT NULL,
vet_clinic(# date_of_birth DATE DEFAULT CURRENT_DATE,
vet_clinic(# escape_attempt INT DEFAULT 0,
vet_clinic(# neutered BOOLEAN,
vet_clinic(# weight_kg DECIMAL
vet_clinic(# );
