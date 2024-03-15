
INSERT INTO Departament VALUES (1, 'Contabilitate', '0312345679');
    INSERT INTO Departament VALUES (2, 'Vanzari', '0312345681');
    INSERT INTO Departament VALUES (3, 'IT', '0312345682');
    INSERT INTO Departament VALUES (4, 'Intretinere si Reparatii', '0312345683');
    INSERT INTO Departament VALUES (5, 'Intretinere Culturi Agricole', '0312345684');

    INSERT INTO Angajat VALUES (1, 'Popescu', 'Ion', 'ion.popescu@example.com', '0722345678', 5); 
    INSERT INTO Angajat VALUES (2, 'Ionescu', 'Maria', 'maria.ionescu@example.com', '0722345679', 1);
    INSERT INTO Angajat VALUES (3, 'Georgescu', 'Andrei', 'andrei.georgescu@example.com', '0722345680', 4);
    INSERT INTO Angajat VALUES (4, 'Dumitrescu', 'Elena', 'elena.dumitrescu@example.com', '0722345681', 1);
    INSERT INTO Angajat VALUES (5, 'Stanescu', 'Mihai', 'mihai.stanescu@example.com', '0722345682', 5);
    INSERT INTO Angajat VALUES (6, 'Ilie', 'Andrei', 'andrei.ilie@example.com', '0723000011', 2);
    INSERT INTO Angajat VALUES (7, 'Popa', 'Ioana', 'ioana.popa@example.com', '0723000012', 4);
    INSERT INTO Angajat VALUES (8, 'Nicolae', 'Raluca', 'raluca.nicolae@example.com', '0723000013', 3);
    INSERT INTO Angajat VALUES (9, 'Marin', 'Dan', 'dan.marin@example.com', '0723000014', 2);
    INSERT INTO Angajat VALUES (10, 'Dobre', 'Elena', 'elena.dobre@example.com', '0723000015', 3);

    INSERT INTO Ferma VALUES (1, 'Craiova', 'Ferma legumicola din Craiova', '3');
    INSERT INTO Ferma VALUES (2, 'Iasi', 'Ferma viticola din Iasi', '150');
    INSERT INTO Ferma VALUES (3, 'Vaslui', 'Ferma de cereale de la Vaslui', '500');
    INSERT INTO Ferma VALUES (4, 'Sibiu', 'Ferma pomicola din Sibiu', '60');
    INSERT INTO Ferma VALUES (5, 'Galati', 'Ferma de cereale din Galati ', '1000');

    INSERT INTO Produs VALUES (1, 'P001', 'Struguri', 2.99, 'Struguri rosii', 'kg');
    INSERT INTO Produs VALUES (2, 'P002', 'Castraveti', 2.83, 'Castraveti cornison', 'kg');
    INSERT INTO Produs VALUES (3, 'P003', 'Porumb', 850.00, 'Porumb', 't');
    INSERT INTO Produs VALUES (4, 'P004', 'Orz', 800.00, 'Orz', 't');
    INSERT INTO Produs VALUES (5, 'P005', 'Mere', 30.00, 'Mere verzi', 'lada');
    INSERT INTO Produs VALUES (6, 'I001', 'Ingrasamant NPK', 17.60, 'Ingrasamant lichid', 'l');
    INSERT INTO Produs VALUES (7, 'P001', 'Struguri', 3.50, 'Struguri albi', 'kg');
    INSERT INTO Produs VALUES (8, 'P006', 'Pere', 35.99, 'Pere', 'lada');
    INSERT INTO Produs VALUES (9, 'P007', 'Rosii', 3.50, 'Rosii Roma', 'kg');
  
    INSERT INTO linie_de_productie VALUES (2, 1);
    INSERT INTO linie_de_productie VALUES (1, 2);
    INSERT INTO linie_de_productie VALUES (7, 2);
    INSERT INTO linie_de_productie VALUES (3, 3);
    INSERT INTO linie_de_productie VALUES (4, 3);
    INSERT INTO linie_de_productie VALUES (5, 4);
    INSERT INTO linie_de_productie VALUES (3, 5);
    INSERT INTO linie_de_productie VALUES (4, 5);
    INSERT INTO linie_de_productie VALUES (8, 4);
    INSERT INTO linie_de_productie VALUES (9, 1);
    
    INSERT INTO Client VALUES (1, 'Ion Ionescu', '0722000001', 1);
    INSERT INTO Client VALUES (2, 'Maria Popescu', '0722000002', 2);
    INSERT INTO Client VALUES (3, 'George Vasile', '0722000003', 3);
    INSERT INTO Client VALUES (4, 'Elena Radu', '0722000004', 4);
    INSERT INTO Client VALUES (5, 'Mihai Zaharia', '0722000005', 5);
INSERT INTO Client VALUES (6, 'Ion Ionescu', '0722002001', 3);

    INSERT INTO Utilaj VALUES (1, 'Tractor', 1);
    INSERT INTO Utilaj VALUES (6, 'Tractor', 2);
    INSERT INTO Utilaj VALUES (10, 'Tractor', 4);
    INSERT INTO Utilaj VALUES (7, 'Tractor', 3);
    INSERT INTO Utilaj VALUES (8, 'Tractor', 5);
    INSERT INTO Utilaj VALUES (9, 'Tractor', 5);
    INSERT INTO Utilaj VALUES (2, 'Combinator', 1);
    INSERT INTO Utilaj VALUES (11, 'Semantoare', 3);
    INSERT INTO Utilaj VALUES (3, 'Semantoare', 5);
    INSERT INTO Utilaj VALUES (4, 'Cultivator', 2);
    INSERT INTO Utilaj VALUES (5, 'Irigator', 1);

    INSERT INTO angajat_foloseste_utilaj VALUES (1, 1, TO_DATE('2022-04-24', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (3, 2, TO_DATE('2023-08-16', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (5, 3, TO_DATE('2023-05-08', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (1, 4, TO_DATE('2022-08-26', 'YYYY-MM-DD')); 
    INSERT INTO angajat_foloseste_utilaj VALUES (3, 5, TO_DATE('2021-06-25', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (5, 2, TO_DATE('2021-10-31', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (7, 3, TO_DATE('2022-11-18', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (7, 4, TO_DATE('2023-04-04', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (1, 5, TO_DATE('2023-11-01', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (5, 1, TO_DATE('2022-04-21', 'YYYY-MM-DD'));
    INSERT INTO angajat_foloseste_utilaj VALUES (5, 6, TO_DATE('2023-04-21', 'YYYY-MM-DD'));
INSERT INTO angajat_foloseste_utilaj VALUES (7, 6, TO_DATE('2023-05-21', 'YYYY-MM-DD'));

    INSERT INTO ferma_are_angajati VALUES (1, 1);
    INSERT INTO ferma_are_angajati VALUES (2, 3);
    INSERT INTO ferma_are_angajati VALUES (3, 5);
    INSERT INTO ferma_are_angajati VALUES (4, 7);
    INSERT INTO ferma_are_angajati VALUES (5, 1);
    INSERT INTO ferma_are_angajati VALUES (1, 2);
    INSERT INTO ferma_are_angajati VALUES (2, 3);
    INSERT INTO ferma_are_angajati VALUES (3, 4);
    INSERT INTO ferma_are_angajati VALUES (4, 5);
    INSERT INTO ferma_are_angajati VALUES (5, 2);

    INSERT INTO Depozit VALUES (1, 'Onesti', 100, 'Depozit de cereale');
    INSERT INTO Depozit VALUES (2, 'Adjud', 200, 'Depozit de legume');
    INSERT INTO Depozit VALUES (3, 'Ploiesti', 150, 'Depozit de fructe');
    INSERT INTO Depozit VALUES (4, 'Focsani', 250, 'Depozit universal');
    INSERT INTO Depozit VALUES (5, 'Bacau', 300, 'Depozit de cereale');
    
    INSERT INTO ferma_are_produse_in_depozit VALUES (3, 2);
    INSERT INTO ferma_are_produse_in_depozit VALUES (5, 2);
    INSERT INTO ferma_are_produse_in_depozit VALUES (3, 3);
    INSERT INTO ferma_are_produse_in_depozit VALUES (4, 4);
    INSERT INTO ferma_are_produse_in_depozit VALUES (5, 5);
    INSERT INTO ferma_are_produse_in_depozit VALUES (1, 2);
    INSERT INTO ferma_are_produse_in_depozit VALUES (2, 3);
    INSERT INTO ferma_are_produse_in_depozit VALUES (3, 4); 
    INSERT INTO ferma_are_produse_in_depozit VALUES (4, 5);
    INSERT INTO ferma_are_produse_in_depozit VALUES (5, 1);

    INSERT INTO comanda VALUES (1, TO_DATE('2021-01-23', 'YYYY-MM-DD'), 1);
    INSERT INTO comanda VALUES (2,  TO_DATE('2021-04-01', 'YYYY-MM-DD'), 2);
    INSERT INTO comanda VALUES (3, TO_DATE('2023-03-24', 'YYYY-MM-DD'), 3);
    INSERT INTO comanda VALUES (4, TO_DATE('2021-11-30', 'YYYY-MM-DD'), 4);
    INSERT INTO comanda VALUES (5,  TO_DATE('2023-10-06', 'YYYY-MM-DD'), 5);
    INSERT INTO comanda VALUES (6,  TO_DATE('2023-05-06', 'YYYY-MM-DD'), 5);

   INSERT INTO comanda_contine_produs VALUES (1, 1, 6);
INSERT INTO comanda_contine_produs VALUES (2, 2, 7);
INSERT INTO comanda_contine_produs VALUES (3, 3, 1);
INSERT INTO comanda_contine_produs VALUES (4, 4, 2);
INSERT INTO comanda_contine_produs VALUES (5, 5, 3);
INSERT INTO comanda_contine_produs VALUES (1, 2, 6);
INSERT INTO comanda_contine_produs VALUES (2, 3, 7);
INSERT INTO comanda_contine_produs VALUES (3, 4, 8);
INSERT INTO comanda_contine_produs VALUES (4, 5, 2);
INSERT INTO comanda_contine_produs VALUES (5, 1, 3);
    INSERT INTO factura VALUES (1, 1, 'FAC001', TO_DATE('2021-01-30', 'YYYY-MM-DD'), 123.45);
    INSERT INTO factura VALUES (2, 2, 'FAC002', TO_DATE('2021-04-02', 'YYYY-MM-DD'), 678.90);
    INSERT INTO factura VALUES (3, 3, 'FAC003', TO_DATE('2023-03-28', 'YYYY-MM-DD'), 234.56);
    INSERT INTO factura VALUES (4, 4, 'FAC004', TO_DATE('2021-10-10', 'YYYY-MM-DD'), 789.01);
    INSERT INTO factura VALUES (5, 5, 'FAC005', TO_DATE('2023-10-30', 'YYYY-MM-DD'), 345.67);
INSERT INTO factura VALUES (6, 5, 'FAC006', TO_DATE('2023-05-23', 'YYYY-MM-DD'), 143.47);


    INSERT INTO Informatii_utilaj VALUES (1, 1500, 'Excelenta', TO_DATE('2019-04-08', 'YYYY-MM-DD'), 'John Deere 5075E');
    INSERT INTO Informatii_utilaj VALUES (2, 1800, 'Buna', TO_DATE('2019-12-19', 'YYYY-MM-DD'), 'Case IH Maxxum 110'); 
    INSERT INTO Informatii_utilaj VALUES (3, 900, 'Nou', TO_DATE('2019-03-07', 'YYYY-MM-DD'), 'Kverneland Miniair Nova');
    INSERT INTO Informatii_utilaj VALUES (4, 1200, 'Uzura Medie', TO_DATE('2019-08-16', 'YYYY-MM-DD'), 'Amazone KE 3000 Super');
    INSERT INTO Informatii_utilaj VALUES (5, 2000, 'Buna', TO_DATE('2019-02-22', 'YYYY-MM-DD'), 'Valley 8000 series');
    INSERT INTO Informatii_utilaj VALUES (6, 1600, 'Foarte Buna', TO_DATE('2019-11-15', 'YYYY-MM-DD'), 'Massey Ferguson 6713');
    INSERT INTO Informatii_utilaj VALUES (7, 1400, 'Excelenta', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'New Holland T5.105');
    INSERT INTO Informatii_utilaj VALUES (8, 1550, 'Nou', TO_DATE('2019-06-30', 'YYYY-MM-DD'), 'Fendt 500 Vario');
    INSERT INTO Informatii_utilaj VALUES (9, 1700, 'Uzura Redusa', TO_DATE('2019-10-12', 'YYYY-MM-DD'), 'CLAAS Arion 630');
    INSERT INTO Informatii_utilaj VALUES (10, 1300, 'Buna', TO_DATE('2019-05-24', 'YYYY-MM-DD'), 'Kubota M5-091');
    INSERT INTO Informatii_utilaj VALUES (11, 950, 'Uzura Medie', TO_DATE('2019-09-17', 'YYYY-MM-DD'), 'Accord Optima');
