
CREATE OR REPLACE PROCEDURE RaportFerma(p_id_ferma IN number) IS
    TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    t_angajati_id tablou_indexat;
    TYPE tablou_imbricat IS TABLE OF NUMBER;
    t_produse_id tablou_imbricat := tablou_imbricat();
    v_index PLS_INTEGER := 1;
    TYPE vector IS VARRAY(105) OF VARCHAR2(255);
    t_utilaje vector := vector();
    BEGIN

     FOR rec IN (SELECT id_angajat FROM ferma_are_angajati WHERE id_ferma = p_id_ferma) LOOP
        t_angajati_id(v_index) := rec.id_angajat;
        v_index := v_index + 1;
     END LOOP;
     v_index := 1;


  FOR rec IN (SELECT id_produs FROM linie_de_productie WHERE id_ferma = p_id_ferma) LOOP
    t_produse_id.EXTEND;
    t_produse_id(v_index) := rec.id_produs;
    v_index := v_index + 1;
  END LOOP;
  
  FOR rec IN (SELECT u.tip, iu.model 
              FROM Utilaj u 
              JOIN Informatii_utilaj iu ON u.id_utilaj = iu.id_utilaj 
              WHERE u.id_ferma = p_id_ferma) LOOP
    
        t_utilaje.EXTEND;
        t_utilaje(t_utilaje.LAST) := 'Tip: ' || rec.tip || ', Model: ' || rec.model;
   
  END LOOP;
     
     FOR i IN 1..t_angajati_id.COUNT LOOP
         FOR rec IN (SELECT nume, prenume, email, telefon FROM Angajat WHERE id_angajat = t_angajati_id(i)) LOOP
             DBMS_OUTPUT.PUT_LINE('Nume: ' || rec.nume || ' Prenume: ' || rec.prenume ||
                           ' Email: ' || rec.email || ' Telefon: ' || rec.telefon);
        END LOOP;
     END LOOP;
     
     FOR i IN 1..t_produse_id.COUNT LOOP
        FOR rec IN (SELECT cod_produs, denumire, pret, descriere FROM Produs WHERE id_produs = t_produse_id(i)) LOOP
              DBMS_OUTPUT.PUT_LINE('Produs - Cod: ' || rec.cod_produs || ', Denumire: ' || rec.denumire ||
                           ', Pret: ' || rec.pret || ', Descriere: ' || rec.descriere);
        END LOOP;
    END LOOP;
    
    FOR i IN 1..t_utilaje.COUNT LOOP
         DBMS_OUTPUT.PUT_LINE('Utilaj ' || i || ': ' || t_utilaje(i));
    END LOOP;
END RaportFerma; 

CREATE OR REPLACE PROCEDURE AfisareSumaComenzi is 
CURSOR c_angajati IS
SELECT id_angajat,nume,prenume,email,telefon FROM Angajat;

CURSOR c_clienti (p_id_angajat NUMBER) IS
SELECT id_client FROM Client WHERE id_angajat = p_id_angajat;

CURSOR c_facturi (p_id_client NUMBER) IS
SELECT suma FROM Factura WHERE id_client = p_id_client;

v_suma NUMBER;
BEGIN
  FOR ang IN c_angajati LOOP
    v_suma := 0;
    FOR cli IN c_clienti(ang.id_angajat) LOOP
        FOR fac IN c_facturi(cli.id_client) LOOP
            v_suma := v_suma + fac.suma;
         END LOOP; 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Angajatul Nume: ' || ang.nume || ' Prenume: ' || ang.prenume ||
                           ' Email: ' || ang.email || ' Telefon: ' || ang.telefon || 'a incheiat comenzi in valoare de: ' || v_suma);
  END LOOP;
END AfisareSumaComenzi;	



CREATE OR REPLACE FUNCTION UsageChart(p_tip_utilaj VARCHAR2, p_an NUMBER)
RETURN VARCHAR2 IS

  v_nr_angajati NUMBER;
  e_input_data exception;
  e_no_use exception;
  e_over_use exception;
  
BEGIN
  --daca nu au fost introduse suficiente date ridicam eroarea de input_data
  IF p_tip_utilaj IS NULL OR p_an IS NULL THEN
    RAISE e_input_data;
  END IF;
  
  --calculam numarul de angajati care au folosit utilajul introdus
  SELECT COUNT(*)
  INTO v_nr_angajati
  FROM Angajat a
  JOIN angajat_foloseste_utilaj afu ON a.id_angajat = afu.id_angajat
  JOIN Utilaj u ON afu.id_utilaj = u.id_utilaj
  WHERE lower(u.tip) = lower(p_tip_utilaj)and EXTRACT(YEAR FROM TO_DATE(afu.data, 'DD-MON-YY')) = p_an;
  --ridicam si erorile de suprasolicitare si nefolosire
  IF v_nr_angajati = 0 THEN
    RAISE e_no_use;
  ELSIF v_nr_angajati > 24 THEN
    RAISE e_over_use;
  END IF;
  --afisam mesajul dorit
  RETURN 'Utilajul ' || p_tip_utilaj || ' in anul ' || p_an|| ' a fost folosit de ' || v_nr_angajati || ' ori';
  --tratam erorile 
  EXCEPTION 
    WHEN e_input_data THEN
        RETURN 'Nu au fost introduse suficiente date!';
    WHEN e_no_use THEN
        RETURN 'Utilajul introdus nu a fost folosit in anul precizat';
    WHEN e_over_use THEN
        RETURN 'Utilajul introdus a fost suprasolicitare in anul precizat, recomandam o revizie!';

END UsageChart;


CREATE OR REPLACE PROCEDURE AfisareComenziClient(nume_client VARCHAR2) IS

  --ne folosim de un cursor sa iteram prin detaliile cerute
  CURSOR comenzi_cursor IS
    SELECT c.id_comanda, f.numar_factura, a.nume || ' ' || a.prenume AS nume_angajat, d.denumire AS nume_departament
    FROM Client cl
    JOIN Comanda c ON cl.id_client = c.id_client
    JOIN Factura f ON c.id_comanda = f.id_comanda
    JOIN Angajat a ON cl.id_angajat = a.id_angajat
    JOIN Departament d ON a.id_departament = d.id_departament
    WHERE lower(cl.nume_pr) = lower(nume_client);


  v_id_comanda Comanda.id_comanda%TYPE;
  v_numar_factura Factura.numar_factura%TYPE;
  v_nume_angajat VARCHAR2(100);
  v_nume_departament Departament.denumire%TYPE;
  v_nr_clienti INT;
  
  e_input EXCEPTION;
BEGIN

  --verificam daca au fost introduse date
  IF nume_client IS NULL THEN
    RAISE e_input;
  END IF;
  
  --calculam numarul de clienti cu acest nume si prenume pentru a ne asigura ca exista doar un client
  SELECT COUNT(*)
  INTO v_nr_clienti
  FROM Client
  WHERE lower(nume_pr) = lower(nume_client);

  --daca nu exista un client cu acest nume sau daca exista mai multi vom ridica erorile corespondente
  IF v_nr_clienti = 0 THEN
    RAISE NO_DATA_FOUND;
  ELSIF v_nr_clienti > 1 THEN
    RAISE TOO_MANY_ROWS;
  END IF;
  
  --deschidem cursorul si iteram prin toate datele, pentru a afisa toate comenzile si facturile clientului
  OPEN comenzi_cursor;
  LOOP
    FETCH comenzi_cursor INTO v_id_comanda, v_numar_factura, v_nume_angajat, v_nume_departament;
    EXIT WHEN comenzi_cursor%NOTFOUND; 
    
   
    DBMS_OUTPUT.PUT_LINE('Comanda ID: ' || v_id_comanda || 
                         ', Numar Factura: ' || v_numar_factura || 
                         ', Angajat: ' || v_nume_angajat || 
                         ', Departament: ' || v_nume_departament);
  END LOOP;
  CLOSE comenzi_cursor;
  --tratam exceptiile
  EXCEPTION
    WHEN e_input THEN
         DBMS_OUTPUT.PUT_LINE('Nu au fost introduse numele si prenumele clientului');
         RETURN;
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista date pentru clientul specificat');
        RETURN;

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi clienti cu acest nume si prenume');
        RETURN;

END AfisareComenziClient;


CREATE OR REPLACE TRIGGER trg_depozit_operations
    BEFORE DELETE OR INSERT ON Depozit
DECLARE
  v_depozit_count NUMBER := 0;
BEGIN

  SELECT COUNT(id_depozit) INTO v_depozit_count FROM Depozit;
  IF DELETING AND v_depozit_count = 1 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nu se pot sterge toate depozitele!');
  END IF;

  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Numarul total de depozite dupa creare va fi: ' || TO_CHAR(v_depozit_count + 1));
  END IF;
END;


CREATE OR REPLACE TRIGGER actualizeaza_suma_factura
AFTER INSERT OR UPDATE  ON Comanda_Contine_Produs
FOR EACH ROW
DECLARE
  pret_unitar NUMBER;
  suma_noua NUMBER;
BEGIN

  SELECT pret INTO pret_unitar FROM Produs WHERE id_produs = :NEW.id_produs;  
  -- calculam suma noua 
  suma_noua := pret_unitar * :NEW.cantitate;
  
  -- actualizam suma in factura
  UPDATE Factura SET suma = suma + suma_noua
  WHERE id_comanda = :NEW.id_comanda;
  
  DBMS_OUTPUT.PUT_LINE('Actualizare efectuata modifica implicit si datele din factura, suma noua este: ' || suma_noua);
END;


CREATE TABLE audit_firma (
  id_modificare NUMBER PRIMARY KEY,
  tip_modificare VARCHAR2(50),
  tip_obiect VARCHAR2(50),
  nume_obiect VARCHAR2(50),
  data_modficare DATE
);
CREATE SEQUENCE audit_firma_seq START WITH 1 INCREMENT BY 1;


CREATE OR REPLACE TRIGGER audit_firma_agricultura
AFTER CREATE OR ALTER OR DROP ON SCHEMA
BEGIN
  -- verificarea pentru utilizator
  IF lower(SYS_CONTEXT('USERENV', 'SESSION_USER')) != 'utilizator' THEN
    --ridicam eroare in caz contrar
    RAISE_APPLICATION_ERROR(-20001, 'Nu aveti autorizatie sa modificati baza de date!!');
  ELSE
    --daca se trece de verificare inseram detatliile modificarilor
    INSERT INTO audit_firma (id_modificare,tip_modificare, tip_obiect, nume_obiect, data_modficare)
    VALUES (audit_firma_seq.NEXTVAL,ora_sysevent, ora_dict_obj_type, ora_dict_obj_name, SYSDATE);
  END IF;
END;


CREATE OR REPLACE PACKAGE pachet_proiect AS
  --6
  PROCEDURE RaportFerma(p_id_ferma IN number);
  --7
  PROCEDURE AfisareSumaComenzi ;
  --8
  FUNCTION UsageChart(p_tip_utilaj VARCHAR2, p_an NUMBER) RETURN VARCHAR2 ;
  --9
  PROCEDURE AfisareComenziClient(nume_client VARCHAR2);
END pachet_proiect;
/
CREATE OR REPLACE PACKAGE BODY pachet_proiect AS
  --6
  PROCEDURE RaportFerma(p_id_ferma IN number) IS
    TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    t_angajati_id tablou_indexat;
    TYPE tablou_imbricat IS TABLE OF NUMBER;
    t_produse_id tablou_imbricat := tablou_imbricat();
    v_index PLS_INTEGER := 1;
    TYPE vector IS VARRAY(105) OF VARCHAR2(255);
    t_utilaje vector := vector();
    BEGIN

     FOR rec IN (SELECT id_angajat FROM ferma_are_angajati WHERE id_ferma = p_id_ferma) LOOP
        t_angajati_id(v_index) := rec.id_angajat;
        v_index := v_index + 1;
     END LOOP;
     v_index := 1;


  FOR rec IN (SELECT id_produs FROM linie_de_productie WHERE id_ferma = p_id_ferma) LOOP
    t_produse_id.EXTEND;
    t_produse_id(v_index) := rec.id_produs;
    v_index := v_index + 1;
  END LOOP;
  
  FOR rec IN (SELECT u.tip, iu.model 
              FROM Utilaj u 
              JOIN Informatii_utilaj iu ON u.id_utilaj = iu.id_utilaj 
              WHERE u.id_ferma = p_id_ferma) LOOP
    
        t_utilaje.EXTEND;
        t_utilaje(t_utilaje.LAST) := 'Tip: ' || rec.tip || ', Model: ' || rec.model;
   
  END LOOP;
     
     FOR i IN 1..t_angajati_id.COUNT LOOP
         FOR rec IN (SELECT nume, prenume, email, telefon FROM Angajat WHERE id_angajat = t_angajati_id(i)) LOOP
             DBMS_OUTPUT.PUT_LINE('Nume: ' || rec.nume || ' Prenume: ' || rec.prenume ||
                           ' Email: ' || rec.email || ' Telefon: ' || rec.telefon);
        END LOOP;
     END LOOP;
     
     FOR i IN 1..t_produse_id.COUNT LOOP
        FOR rec IN (SELECT cod_produs, denumire, pret, descriere FROM Produs WHERE id_produs = t_produse_id(i)) LOOP
              DBMS_OUTPUT.PUT_LINE('Produs - Cod: ' || rec.cod_produs || ', Denumire: ' || rec.denumire ||
                           ', Pret: ' || rec.pret || ', Descriere: ' || rec.descriere);
        END LOOP;
    END LOOP;
    
    FOR i IN 1..t_utilaje.COUNT LOOP
         DBMS_OUTPUT.PUT_LINE('Utilaj ' || i || ': ' || t_utilaje(i));
    END LOOP;
    
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista date pentru ferma introdusa');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare neasteptata: ' || SQLERRM);
    END RaportFerma; 
  
  --7
  PROCEDURE AfisareSumaComenzi is 
CURSOR c_angajati IS
SELECT id_angajat,nume,prenume,email,telefon FROM Angajat;

CURSOR c_clienti (p_id_angajat NUMBER) IS
SELECT id_client FROM Client WHERE id_angajat = p_id_angajat;

CURSOR c_facturi (p_id_client NUMBER) IS
SELECT suma FROM Factura WHERE id_client = p_id_client;

v_suma NUMBER;
BEGIN
  FOR ang IN c_angajati LOOP
    v_suma := 0;
    FOR cli IN c_clienti(ang.id_angajat) LOOP
        FOR fac IN c_facturi(cli.id_client) LOOP
            v_suma := v_suma + fac.suma;
         END LOOP; 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Angajatul Nume: ' || ang.nume || ' Prenume: ' || ang.prenume ||
                           ' Email: ' || ang.email || ' Telefon: ' || ang.telefon || 'a incheiat comenzi in valoare de: ' || v_suma);
  END LOOP;
END AfisareSumaComenzi;	

  --8
  FUNCTION UsageChart(p_tip_utilaj VARCHAR2, p_an NUMBER)
RETURN VARCHAR2 IS

  v_nr_angajati NUMBER;
  e_input_data exception;
  e_no_use exception;
  e_over_use exception;
  
BEGIN
  --daca nu au fost introduse suficiente date ridicam eroarea de input_data
  IF p_tip_utilaj IS NULL OR p_an IS NULL THEN
    RAISE e_input_data;
  END IF;
  
  --calculam numarul de angajati care au folosit utilajul introdus
  SELECT COUNT(*)
  INTO v_nr_angajati
  FROM Angajat a
  JOIN angajat_foloseste_utilaj afu ON a.id_angajat = afu.id_angajat
  JOIN Utilaj u ON afu.id_utilaj = u.id_utilaj
  WHERE lower(u.tip) = lower(p_tip_utilaj)and EXTRACT(YEAR FROM TO_DATE(afu.data, 'DD-MON-YY')) = p_an;
  --ridicam si erorile de suprasolicitare si nefolosire
  IF v_nr_angajati = 0 THEN
    RAISE e_no_use;
  ELSIF v_nr_angajati > 24 THEN
    RAISE e_over_use;
  END IF;
  --afisam mesajul dorit
  RETURN 'Utilajul ' || p_tip_utilaj || ' in anul ' || p_an|| ' a fost folosit de ' || v_nr_angajati || ' ori';
  --tratam erorile 
  EXCEPTION 
    WHEN e_input_data THEN
        RETURN 'Nu au fost introduse suficiente date!';
    WHEN e_no_use THEN
        RETURN 'Utilajul introdus nu a fost folosit in anul precizat';
    WHEN e_over_use THEN
        RETURN 'Utilajul introdus a fost suprasolicitare in anul precizat, recomandam o revizie!';
  END UsageChart;
  --9
  PROCEDURE AfisareComenziClient(nume_client VARCHAR2) IS

  --ne folosim de un cursor sa iteram prin detaliile cerute
  CURSOR comenzi_cursor IS
    SELECT c.id_comanda, f.numar_factura, a.nume || ' ' || a.prenume AS nume_angajat, d.denumire AS nume_departament
    FROM Client cl
    JOIN Comanda c ON cl.id_client = c.id_client
    JOIN Factura f ON c.id_comanda = f.id_comanda
    JOIN Angajat a ON cl.id_angajat = a.id_angajat
    JOIN Departament d ON a.id_departament = d.id_departament
    WHERE lower(cl.nume_pr) = lower(nume_client);


  v_id_comanda Comanda.id_comanda%TYPE;
  v_numar_factura Factura.numar_factura%TYPE;
  v_nume_angajat VARCHAR2(100);
  v_nume_departament Departament.denumire%TYPE;
  v_nr_clienti INT;
  
  e_input EXCEPTION;
BEGIN

  --verificam daca au fost introduse date
  IF nume_client IS NULL THEN
    RAISE e_input;
  END IF;
  
  --calculam numarul de clienti cu acest nume si prenume pentru a ne asigura ca exista doar un client
  SELECT COUNT(*)
  INTO v_nr_clienti
  FROM Client
  WHERE lower(nume_pr) = lower(nume_client);

  --daca nu exista un client cu acest nume sau daca exista mai multi vom ridica erorile corespondente
  IF v_nr_clienti = 0 THEN
    RAISE NO_DATA_FOUND;
  ELSIF v_nr_clienti > 1 THEN
    RAISE TOO_MANY_ROWS;
  END IF;
  
  --deschidem cursorul si iteram prin toate datele, pentru a afisa toate comenzile si facturile clientului
  OPEN comenzi_cursor;
  LOOP
    FETCH comenzi_cursor INTO v_id_comanda, v_numar_factura, v_nume_angajat, v_nume_departament;
    EXIT WHEN comenzi_cursor%NOTFOUND; 
    
   
    DBMS_OUTPUT.PUT_LINE('Comanda ID: ' || v_id_comanda || 
                         ', Numar Factura: ' || v_numar_factura || 
                         ', Angajat: ' || v_nume_angajat || 
                         ', Departament: ' || v_nume_departament);
  END LOOP;
  CLOSE comenzi_cursor;
  --tratam exceptiile
  EXCEPTION
    WHEN e_input THEN
         DBMS_OUTPUT.PUT_LINE('Nu au fost introduse numele si prenumele clientului');
         RETURN;
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista date pentru clientul specificat');
        RETURN;

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi clienti cu acest nume si prenume');
        RETURN;

END AfisareComenziClient;

END pachet_proiect;

