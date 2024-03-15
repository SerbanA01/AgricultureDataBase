CREATE TABLE Departament (
    id_departament NUMBER PRIMARY KEY,
    denumire VARCHAR2(100) NOT NULL,
    telefon VARCHAR2(15)
);
 CREATE TABLE Angajat (
    id_angajat NUMBER PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    prenume VARCHAR2(50) NOT NULL,
    email VARCHAR2(100),
    telefon VARCHAR2(15),
    id_departament NUMBER,
    CONSTRAINT fk_angajat_departament FOREIGN KEY (id_departament)
    REFERENCES Departament (id_departament)
);

CREATE TABLE Client (
    id_client NUMBER PRIMARY KEY,
    nume_pr VARCHAR2(100) NOT NULL,
    telefon VARCHAR2(15),
    id_angajat NUMBER,
    CONSTRAINT fk_client_angajat FOREIGN KEY (id_angajat)
    REFERENCES Angajat (id_angajat)
);


CREATE TABLE Comanda (
    id_comanda NUMBER PRIMARY KEY,
    cantitate NUMBER NOT NULL,
    data_comanda DATE NOT NULL,
    id_client NUMBER,
    CONSTRAINT fk_comanda_client FOREIGN KEY (id_client)
    REFERENCES Client (id_client)
);


CREATE TABLE Factura (
    id_comanda NUMBER ,
    id_client NUMBER ,
    PRIMARY KEY (id_comanda,id_client),
    numar_factura VARCHAR2(50) NOT NULL,
    data_factura DATE NOT NULL,
    suma NUMBER NOT NULL,
    CONSTRAINT fk_factura_client FOREIGN KEY (id_client)
    REFERENCES Client (id_client),
    CONSTRAINT fk_factura_client_2 FOREIGN KEY (id_comanda)
    REFERENCES Comanda (id_comanda)
);


CREATE TABLE Produs (
    id_produs NUMBER PRIMARY KEY,
    cod_produs VARCHAR2(50) NOT NULL,
    denumire VARCHAR2(100) NOT NULL,
    pret NUMBER NOT NULL,
    descriere VARCHAR2(255),
    unitate_de_masura VARCHAR2(50)
);


CREATE TABLE Depozit (
    id_depozit NUMBER PRIMARY KEY,
    locatie VARCHAR2(100) NOT NULL,
    capacitate NUMBER NOT NULL,
    continut VARCHAR2(255)
);


CREATE TABLE Ferma (
    id_ferma NUMBER PRIMARY KEY,
    locatie VARCHAR2(100) NOT NULL,
    nume VARCHAR2(100) NOT NULL,
    marime NUMBER NOT NULL
);


CREATE TABLE Utilaj (
    id_utilaj NUMBER PRIMARY KEY,
    tip VARCHAR2(100) NOT NULL,
    id_ferma NUMBER,
    CONSTRAINT fk_utilaj_ferma FOREIGN KEY (id_ferma)
    REFERENCES Ferma (id_ferma)
);


CREATE TABLE Informatii_Utilaj (
    id_utilaj NUMBER PRIMARY KEY,
    greutate NUMBER NOT NULL,
    conditie VARCHAR2(100),
    data_cumparare DATE,
    model VARCHAR2(100),
    CONSTRAINT fk_utilaj_informatii FOREIGN KEY (id_utilaj)
    REFERENCES Utilaj (id_utilaj)
);


CREATE TABLE Angajat_Foloseste_Utilaj (
    id_angajat NUMBER,
    id_utilaj NUMBER,
    data DATE NOT NULL,
    PRIMARY KEY (id_angajat, id_utilaj),
    CONSTRAINT fk_afu_angajat FOREIGN KEY (id_angajat)
    REFERENCES Angajat (id_angajat),
    CONSTRAINT fk_afu_utilaj FOREIGN KEY (id_utilaj)
    REFERENCES Utilaj (id_utilaj)
);


CREATE TABLE Ferma_Are_Angajati (
    id_ferma NUMBER,
    id_angajat NUMBER,
    PRIMARY KEY (id_ferma, id_angajat),
    CONSTRAINT fk_faa_ferma FOREIGN KEY (id_ferma)
    REFERENCES Ferma (id_ferma),
    CONSTRAINT fk_faa_angajat FOREIGN KEY (id_angajat)
    REFERENCES Angajat (id_angajat)
);


CREATE TABLE Ferma_Are_Produse_In_Depozit (
    id_ferma NUMBER,
    id_depozit NUMBER,
    PRIMARY KEY (id_ferma, id_depozit),
    CONSTRAINT fk_fapd_ferma FOREIGN KEY (id_ferma)
    REFERENCES Ferma (id_ferma),
    CONSTRAINT fk_fapd_depozit FOREIGN KEY  (id_depozit)
    REFERENCES Depozit (id_depozit)
);


CREATE TABLE Linie_De_Productie (
    id_produs NUMBER,
    id_ferma NUMBER,
    PRIMARY KEY (id_produs, id_ferma),
    CONSTRAINT fk_ldp_produs FOREIGN KEY (id_produs)
    REFERENCES Produs (id_produs)
    CONSTRAINT fk_ldp_ferma FOREIGN KEY (id_ferma)
    REFERENCES Ferma (id_ferma)
);


CREATE TABLE Comanda_Contine_Produs (
    id_comanda NUMBER,
    id_produs NUMBER,
    cantitate NUMBER NOT NULL,
    PRIMARY KEY (id_comanda, id_produs),
    CONSTRAINT fk_ccp_comanda FOREIGN KEY (id_comanda)
    REFERENCES Comanda (id_comanda),
    CONSTRAINT fk_ccp_produs FOREIGN KEY (id_produs)
    REFERENCES Produs (id_produs)
);


