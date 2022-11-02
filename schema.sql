/* Database schema to keep the structure of entire database. */

/* schema for animals table. */
CREATE TABLE IF NOT EXISTS animals (
id integer primary key generated always as identity,
name VARCHAR(30) NOT NULL,
date_of_birth DATE DEFAULT CURRENT_DATE,
escape_attempts INT DEFAULT 0,
neutered BOOLEAN,
weight_kg DECIMAL
);
