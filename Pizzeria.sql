CREATE DATABASE Pizzeria;

CREATE TABLE Pizza(
CodicePizza INT IDENTITY(1,1) NOT NULL,
Nome VARCHAR(50) NOT NULL,
Prezzo DECIMAL(4,2) NOT NULL CHECK (Prezzo > 0),
CONSTRAINT PK_Pizza PRIMARY KEY (CodicePizza)
);

CREATE TABLE Ingrediente(
CodiceIngrediente INT IDENTITY(1,1) NOT NULL,
Nome VARCHAR(50) NOT NULL,
Costo DECIMAL(4,2) NOT NULL CHECK (Costo > 0),
Scorte INT NOT NULL CHECK (Scorte >= 0),
CONSTRAINT PK_Ingrediente PRIMARY KEY (CodiceIngrediente)
);

CREATE TABLE PizzaIngrediente(
CodicePizza INT NOT NULL,
CodiceIngrediente INT NOT NULL,
CONSTRAINT PK_PizzaIngrediente PRIMARY KEY(CodicePizza, CodiceIngrediente),
CONSTRAINT FK_Pizza FOREIGN KEY (CodicePizza) REFERENCES Pizza(CodicePizza),
CONSTRAINT FK_Ingrediente FOREIGN KEY (CodiceIngrediente) REFERENCES Ingrediente(CodiceIngrediente)
);

--1. Inserimento di una nuova pizza (parametri: nome, prezzo) 
CREATE PROCEDURE InsertPizza
@NomePizza VARCHAR(50),
@Prezzo DECIMAL(4,2)
AS
INSERT INTO Pizza VALUES(@NomePizza,@Prezzo);
GO

CREATE PROCEDURE InsertIngrediente
@NomeIngrediente VARCHAR(50),
@Costo DECIMAL(4,2),
@Scorte INT
AS
INSERT INTO Ingrediente VALUES(@NomeIngrediente,@Costo,@Scorte);
GO

--2. Assegnazione di un ingrediente a una pizza (parametri: nome pizza, nome ingrediente)
CREATE PROCEDURE AssignIngredienteToPizza
@NomeIngrediente VARCHAR(50),
@NomePizza VARCHAR(50)
AS
DECLARE @IDINGREDIENTE INT
DECLARE @IDPIZZA INT
SELECT @IDINGREDIENTE = i.CodiceIngrediente FROM Ingrediente i WHERE i.Nome = @NomeIngrediente;
SELECT @IDPIZZA = p.CodicePizza FROM Pizza p WHERE p.Nome = @NomePizza;
INSERT INTO PizzaIngrediente VALUES (@IDPIZZA,@IDINGREDIENTE);
GO

EXECUTE InsertPizza 'Margherita', 5;
EXECUTE InsertPizza 'Bufala', 7;
EXECUTE InsertPizza 'Diavola', 6;
EXECUTE InsertPizza 'Quattro Stagioni', 6.5;
EXECUTE InsertPizza 'Porcini', 7;
EXECUTE InsertPizza 'Dioniso', 8;
EXECUTE InsertPizza 'Ortolana', 8;
EXECUTE InsertPizza 'Patate e Salsiccia', 6;
EXECUTE InsertPizza 'Pomodorini', 6;
EXECUTE InsertPizza 'Quattro Formaggi', 7.5;
EXECUTE InsertPizza 'Caprese', 7.50;
EXECUTE InsertPizza 'Zeus', 7.50;

SELECT * FROM Pizza;

EXECUTE InsertIngrediente 'Pomodoro',0.20,200;
EXECUTE InsertIngrediente 'Mozzarella',0.40,200;
EXECUTE InsertIngrediente 'Mozzarella di bufala',0.50,50;
EXECUTE InsertIngrediente 'Spianata piccante',1,20;
EXECUTE InsertIngrediente 'Funghi',0.40,100;
EXECUTE InsertIngrediente 'Carciofi',0.30,30;
EXECUTE InsertIngrediente 'Cotto',0.40,100;
EXECUTE InsertIngrediente 'Olive',0.40,150;
EXECUTE InsertIngrediente 'Funghi Porcini',0.50,100;
EXECUTE InsertIngrediente 'Stracchino',0.50,50;
EXECUTE InsertIngrediente 'Speck',0.50,50;
EXECUTE InsertIngrediente 'Rucola',0.20,50;
EXECUTE InsertIngrediente 'Grana',0.50,50;
EXECUTE InsertIngrediente 'Verdure di stagione',0.50,100;
EXECUTE InsertIngrediente 'Patate',0.20,100;
EXECUTE InsertIngrediente 'Salsiccia',1,50;
EXECUTE InsertIngrediente 'Pomodorini',0.30,50;
EXECUTE InsertIngrediente 'Ricotta',0.50,20;
EXECUTE InsertIngrediente 'Provola',0.70,15;
EXECUTE InsertIngrediente 'Gorgonzola',0.70,15;
EXECUTE InsertIngrediente 'Pomodoro fresco',0.20,100;
EXECUTE InsertIngrediente 'Basilico',0.15,50;
EXECUTE InsertIngrediente 'Bresaola',0.70,25;

SELECT * FROM Ingrediente;

EXECUTE AssignIngredienteToPizza 'Pomodoro','Margherita';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Margherita';
EXECUTE AssignIngredienteToPizza 'Pomodoro','Bufala';
EXECUTE AssignIngredienteToPizza 'Mozzarella di bufala','Bufala';
EXECUTE AssignIngredienteToPizza 'Pomodoro','Diavola';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Diavola';
EXECUTE AssignIngredienteToPizza 'Spianata piccante','Diavola';
EXECUTE AssignIngredienteToPizza 'Pomodoro','Quattro Stagioni';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Quattro Stagioni';
EXECUTE AssignIngredienteToPizza 'Funghi','Quattro Stagioni';
EXECUTE AssignIngredienteToPizza 'Carciofi','Quattro Stagioni';
EXECUTE AssignIngredienteToPizza 'Cotto','Quattro Stagioni';
EXECUTE AssignIngredienteToPizza 'Olive','Quattro Stagioni';
EXECUTE AssignIngredienteToPizza 'Pomodoro','Porcini';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Porcini';
EXECUTE AssignIngredienteToPizza 'Funghi Porcini','Porcini';
EXECUTE AssignIngredienteToPizza 'Pomodoro','Dioniso';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Dioniso';
EXECUTE AssignIngredienteToPizza 'Stracchino','Dioniso';
EXECUTE AssignIngredienteToPizza 'Speck','Dioniso';
EXECUTE AssignIngredienteToPizza 'Rucola','Dioniso';
EXECUTE AssignIngredienteToPizza 'Grana','Dioniso';
EXECUTE AssignIngredienteToPizza 'Pomodoro','Ortolana';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Ortolana';
EXECUTE AssignIngredienteToPizza 'Verdure di stagione','Ortolana';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Patate e Salsiccia';
EXECUTE AssignIngredienteToPizza 'Patate','Patate e Salsiccia';
EXECUTE AssignIngredienteToPizza 'Salsiccia','Patate e Salsiccia';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Pomodorini';
EXECUTE AssignIngredienteToPizza 'Pomodorini','Pomodorini';
EXECUTE AssignIngredienteToPizza 'Ricotta','Pomodorini';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Quattro Formaggi';
EXECUTE AssignIngredienteToPizza 'Provola','Quattro Formaggi';
EXECUTE AssignIngredienteToPizza 'Gorgonzola','Quattro Formaggi';
EXECUTE AssignIngredienteToPizza 'Grana','Quattro Formaggi';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Caprese';
EXECUTE AssignIngredienteToPizza 'Pomodoro fresco','Caprese';
EXECUTE AssignIngredienteToPizza 'Basilico','Caprese';
EXECUTE AssignIngredienteToPizza 'Mozzarella','Zeus';
EXECUTE AssignIngredienteToPizza 'Bresaola','Zeus';
EXECUTE AssignIngredienteToPizza 'Rucola','Zeus';

SELECT *
FROM PizzaIngrediente;


--1. Estrarre tutte le pizze con prezzo superiore a 6 euro.
SELECT *
FROM Pizza
WHERE Prezzo > 6;

--2. Estrarre la pizza/le pizze più costosa/e.
SELECT *
FROM Pizza
WHERE Prezzo = (
				SELECT MAX(Prezzo)
				FROM Pizza);

--3. Estrarre le pizze «bianche»
SELECT *
FROM Pizza p
WHERE p.CodicePizza NOT IN (
							SELECT p.CodicePizza FROM Pizza p
							JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
							JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
							WHERE i.Nome = 'Pomodoro');

--4. Estrarre le pizze che contengono funghi (di qualsiasi tipo).
SELECT p.*
FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
WHERE i.Nome LIKE 'Funghi%';

--3. Aggiornamento del prezzo di una pizza (parametri: nome pizza e nuovo prezzo)
CREATE PROCEDURE UpdatePrezzo
@NomePizza VARCHAR(50),
@Prezzo DECIMAL(4,2)
AS
DECLARE @IDPIZZA INT
SELECT @IDPIZZA = p.CodicePizza FROM Pizza p WHERE p.Nome = @NomePizza;
UPDATE Pizza SET Prezzo = @Prezzo WHERE CodicePizza = @IDPIZZA;
GO

EXECUTE UpdatePrezzo 'Zeus',7;
SELECT * FROM Pizza WHERE Nome = 'Zeus';

--4. Eliminazione di un ingrediente da una pizza (parametri: nome pizza, nome ingrediente)
CREATE PROCEDURE DeleteIngredienteFromPizza
@NomePizza VARCHAR(50),
@NomeIngrediente VARCHAR(50)
AS
DECLARE @IDINGREDIENTE INT
DECLARE @IDPIZZA INT
SELECT @IDINGREDIENTE = i.CodiceIngrediente FROM Ingrediente i WHERE i.Nome = @NomeIngrediente;
SELECT @IDPIZZA = p.CodicePizza FROM Pizza p WHERE p.Nome = @NomePizza;

DELETE FROM PizzaIngrediente WHERE CodicePizza = @IDPIZZA AND CodiceIngrediente = @IDINGREDIENTE;
GO

EXECUTE DeleteIngredienteFromPizza 'Zeus','Bresaola';
SELECT * FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente WHERE p.Nome = 'Zeus';

--5. Incremento del 10% del prezzo delle pizze contenenti un ingrediente (parametro: nome ingrediente) 
CREATE PROCEDURE PriceIncrease
@NomeIngrediente VARCHAR(50)
AS
DECLARE @IDINGREDIENTE INT
SELECT @IDINGREDIENTE = i.CodiceIngrediente FROM Ingrediente i WHERE i.Nome = @NomeIngrediente;

UPDATE Pizza SET Prezzo = Prezzo+((Prezzo*10)/100)
FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
WHERE pizzaing.CodiceIngrediente = @IDINGREDIENTE;
GO

EXECUTE PriceIncrease 'Gorgonzola';
SELECT * FROM Pizza;

--1. Tabella listino pizze (nome, prezzo) (parametri: nessuno)
CREATE FUNCTION ListinoPizze()
RETURNS TABLE
AS
RETURN
SELECT Nome, Prezzo
FROM Pizza;

SELECT * FROM ListinoPizze();

--2. Tabella listino pizze (nome, prezzo) contenenti un ingrediente (parametri: nome ingrediente)
CREATE FUNCTION ListinoPizzeConIngrediente(@NomeIngrediente VARCHAR(50))
RETURNS TABLE
AS
RETURN
SELECT p.Nome, Prezzo
FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
WHERE I.Nome = @NomeIngrediente;

SELECT * FROM ListinoPizzeConIngrediente('Pomodoro')

--3. Tabella listino pizze (nome, prezzo) che non contengono un certo ingrediente (parametri: nome ingrediente)
CREATE FUNCTION ListinoPizzeSenzaIngrediente(@NomeIngrediente VARCHAR(50))
RETURNS TABLE
AS
RETURN
SELECT p.Nome, Prezzo
FROM Pizza p WHERE p.CodicePizza NOT IN (
								SELECT p.CodicePizza FROM Pizza p
								JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
								JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
								WHERE I.Nome = @NomeIngrediente)

SELECT * FROM ListinoPizzeSenzaIngrediente('Pomodoro')

--4. Calcolo numero pizze contenenti un ingrediente (parametri: nome ingrediente)
CREATE FUNCTION NumeroPizzeConIngrediente(@NomeIngrediente VARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @NUMPIZZE INT
SELECT @NUMPIZZE=COUNT(*) FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
WHERE I.Nome = @NomeIngrediente
RETURN @NUMPIZZE
END

SELECT dbo.NumeroPizzeConIngrediente('Pomodoro') AS NumeroPizze

--5. Calcolo numero pizze che non contengono un ingrediente (parametri: codice ingrediente
CREATE FUNCTION NumeroPizzeSenzaIngrediente(@NomeIngrediente VARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @NUMPIZZE INT
SELECT @NUMPIZZE = COUNT(*)
FROM Pizza p
WHERE p.CodicePizza NOT IN
(SELECT p.CodicePizza FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
WHERE I.Nome = @NomeIngrediente)
RETURN @NUMPIZZE
END

SELECT dbo.NumeroPizzeSenzaIngrediente('Pomodoro') AS NumeroPizze

--6. Calcolo numero ingredienti contenuti in una pizza (parametri: nome pizza)
CREATE FUNCTION NumeroIngredienti(@NomePizza VARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @NUMING INT
SELECT @NUMING = COUNT(CodiceIngrediente)
FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
WHERE p.Nome = @NomePizza
RETURN @NUMING
END

SELECT dbo.NumeroIngredienti('Quattro Stagioni') AS NumeroIngredienti


/*Realizzare una view che rappresenta il menù con tutte le pizze.
Opzionale: la vista deve restituire una tabella con prima colonna
contenente il nome della pizza, seconda colonna il prezzo e terza
colonna la lista unica di tutti gli ingredienti separati da virgola
(vedi esempio in tabella)*/
CREATE VIEW MenuPizze AS
SELECT p.Nome as Pizza, p.Prezzo, STUFF(
								(
								SELECT ', '+ i.Nome
								FROM Ingrediente i
								JOIN PizzaIngrediente pizzaing ON i.CodiceIngrediente = pizzaing.CodiceIngrediente
								JOIN Pizza p2 ON pizzaing.CodicePizza = p2.CodicePizza
								WHERE p2.CodicePizza = p.CodicePizza
								FOR XML PATH ('')), 1, 1, '') Ingredienti
FROM Pizza p

SELECT * FROM MenuPizze;