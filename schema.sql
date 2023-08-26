/* Database schema to keep the structure of entire database. */

PSQL
CREATE DATABASE vet_clinic /* Creating vet clinic database */
\c vet_clinc /* Connect to the vet_clinic db using psql*/
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);
/* Create column called species */
ALTER TABLE animals
ADD species VARCHAR(255);