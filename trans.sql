DROP SCHEMA IF EXISTS

CREATE TABLE IF NOT EXISTS Annee
(
    an INTEGER,

    CONSTRAINT Annee_pk 
        PRIMARY KEY (an)
);

CREATE TABLE IF NOT EXISTS Groupe_artiste (
    Id_Groupe_Artiste VARCHAR(50),
    nom_groupe_artiste VARCHAR(50) NOT NULL,
    site_web VARCHAR(50) NOT NULL,
    an INTEGER NOT NULL,
    nom_p VARCHAR(50) NOT NULL,


    CONSTRAINT Groupe_artiste_pk 
        PRIMARY KEY (Id_Groupe_Artiste),
    CONSTRAINT Groupe_artiste_Annee_fk
        FOREIGN KEY (an) REFERENCES Annee(an),
    CONSTRAINT Groupe_artiste_Pays_fk
        FOREIGN KEY (nom_p) REFERENCES Pays(nom_p)
);

CREATE TABLE IF NOT EXISTS Pays(
    nom_p VARCHAR(50),

    CONSTRAINT Pays_pk 
        PRIMARY KEY (nom_p)
);

CREATE TABLE IF NOT EXISTS Ville (
    nom_v VARCHAR(50),
    nom_p VARCHAR(50) NOT NULL,

    CONSTRAINT Ville_pk 
        PRIMARY KEY (nom_v),
    CONSTRAINT Ville_Pays_fk
        FOREIGN KEY (nom_p) REFERENCES Pays(nom_p)
);

CREATE TABLE IF NOT EXISTS Lieu (
    id_lieu VARCHAR(50),
    nom_lieu VARCHAR(50) NOT NULL,
    accesPMR BOOLEAN NOT NULL,
    capacite_max INTEGER NOT NULL,
    type_lieu VARCHAR(50) NOT NULL,
    nom_v VARCHAR(50) NOT NULL,


    CONSTRAINT Lieu_pk 
        PRIMARY KEY (id_lieu),
    CONSTRAINT Lieu_Ville_fk
        FOREIGN KEY (nom_v) REFERENCES Ville(nom_v)
);

CREATE TABLE IF NOT EXISTS Representation (
    numero_representation VARCHAR(50),
    heure VARCHAR(50) NOT NULL,
    date_representation DATE NOT NULL,
    Id_Groupe_Artiste VARCHAR(50) NOT NULL,
    id_lieu VARCHAR(50) NOT NULL,
    no_concert VARCHAR(50) NOT NULL,

    CONSTRAINT Representation_pk 
        PRIMARY KEY (numero_representation),
    CONSTRAINT Representation_Groupe_Artiste_fk
        FOREIGN KEY (Id_Groupe_Artiste) REFERENCES Groupe_artiste(Id_Groupe_Artiste),
    CONSTRAINT Representation_Lieu_fk
        FOREIGN KEY (id_lieu) REFERENCES Lieu(id_lieu),
    CONSTRAINT Representation_Concert_fk
        FOREIGN KEY (no_concert) REFERENCES Concert(no_concert)
);

CREATE TABLE IF NOT EXISTS Edition (
    nom_edition VARCHAR(50),
    an INTEGER NOT NULL,

    CONSTRAINT Edition_pk 
        PRIMARY KEY (nom_edition),
    CONSTRAINT Edition_Annee_fk
        FOREIGN KEY (an) REFERENCES Annee(an)
);

CREATE TABLE IF NOT EXISTS Concert (
    no_concert VARCHAR(50),
    titre VARCHAR(50) NOT NULL,
    resumé VARCHAR(50) NOT NULL,
    duree INTEGER NOT NULL,
    tarif DECIMAL NOT NULL,
    type_m VARCHAR(50) NOT NULl,
    nom_edition VARCHAR(50) NOT NULL,
    CONSTRAINT Concert_pk 
        PRIMARY KEY (no_concert),
    CONSTRAINT Concert_Edition_fk
        FOREIGN KEY (nom_edition) REFERENCES Edition(nom_edition),
    CONSTRAINT Concert_Type_musique_fk
        FOREIGN KEY (type_m) REFERENCES Type_musique(type_m)
);

CREATE TABLE IF NOT EXISTS Type_musique (
    type_m VARCHAR(50),
    
    CONSTRAINT Type_musique_pk 
        PRIMARY KEY (type_m)
);

CREATE TABLE IF NOT EXISTS Formation (
    libelle_formation VARCHAR(50),

    CONSTRAINT Formation_pk 
        PRIMARY KEY (libelle_formation)
);

Create table Groupe_artiste_Formation(
    id_Groupe_Artiste VARCHAR(50),
    libelle_formation VARCHAR(50),
    CONSTRAINT Groupe_Formation_pk
            PRIMARY KEY(id_Groupe_Artiste,libelle_formation),
    CONSTRAINT Groupe_Formation_fk1
            FOREIGN KEY(id_Groupe_Artiste) REFERENCES Groupe_artiste(id_Groupe_Artiste),
    CONSTRAINT Groupe_Formation_fk2
            FOREIGN KEY(libelle_formation) REFERENCES Formation(libelle_formation)
    
);

CREATE table Groupe_artiste_Type_Musique(
      id_Groupe_Artiste VARCHAR(50),
      type_m VARCHAR(50),
      CONSTRAINT Groupe_artiste_Type_Musique_pk
            PRIMARY KEY(id_Groupe_Artiste,type_m),
      CONSTRAINT Groupe_artiste_Type_Musique_fk1
            FOREIGN KEY(id_Groupe_Artiste) REFERENCES Groupe_artiste(id_Groupe_Artiste),
      CONSTRAINT Groupe_artiste_Type_Musique_fk2
            FOREIGN KEY(type_m) REFERENCES Type_musique(type_m)
);
