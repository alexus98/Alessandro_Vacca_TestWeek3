USE [master]
GO
/****** Object:  Database [Pizzeria]    Script Date: 17/12/2021 15:24:12 ******/
CREATE DATABASE [Pizzeria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pizzeria', FILENAME = N'C:\Users\alessandro.vacca\Pizzeria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pizzeria_log', FILENAME = N'C:\Users\alessandro.vacca\Pizzeria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Pizzeria] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pizzeria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pizzeria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pizzeria] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pizzeria] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Pizzeria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pizzeria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pizzeria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pizzeria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pizzeria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pizzeria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pizzeria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pizzeria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pizzeria] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Pizzeria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pizzeria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pizzeria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pizzeria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pizzeria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pizzeria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pizzeria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pizzeria] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Pizzeria] SET  MULTI_USER 
GO
ALTER DATABASE [Pizzeria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pizzeria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pizzeria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pizzeria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pizzeria] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pizzeria] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Pizzeria] SET QUERY_STORE = OFF
GO
USE [Pizzeria]
GO
/****** Object:  UserDefinedFunction [dbo].[NumeroIngredienti]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NumeroIngredienti](@NomePizza VARCHAR(50))
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
GO
/****** Object:  UserDefinedFunction [dbo].[NumeroPizzeConIngrediente]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NumeroPizzeConIngrediente](@NomeIngrediente VARCHAR(50))
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
GO
/****** Object:  UserDefinedFunction [dbo].[NumeroPizzeSenzaIngrediente]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NumeroPizzeSenzaIngrediente](@NomeIngrediente VARCHAR(50))
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
GO
/****** Object:  Table [dbo].[Pizza]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza](
	[CodicePizza] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[Prezzo] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_Pizza] PRIMARY KEY CLUSTERED 
(
	[CodicePizza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPizze]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ListinoPizze]()
RETURNS TABLE
AS
RETURN
SELECT Nome, Prezzo FROM Pizza;
GO
/****** Object:  Table [dbo].[Ingrediente]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingrediente](
	[CodiceIngrediente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[Costo] [decimal](4, 2) NOT NULL,
	[Scorte] [int] NOT NULL,
 CONSTRAINT [PK_Ingrediente] PRIMARY KEY CLUSTERED 
(
	[CodiceIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PizzaIngrediente]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PizzaIngrediente](
	[CodicePizza] [int] NOT NULL,
	[CodiceIngrediente] [int] NOT NULL,
 CONSTRAINT [PK_PizzaIngrediente] PRIMARY KEY CLUSTERED 
(
	[CodicePizza] ASC,
	[CodiceIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPizzeConIngrediente]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ListinoPizzeConIngrediente](@NomeIngrediente VARCHAR(50))
RETURNS TABLE
AS
RETURN
SELECT p.Nome, Prezzo
FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
WHERE I.Nome = @NomeIngrediente;
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPizzeSenzaIngrediente]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ListinoPizzeSenzaIngrediente](@NomeIngrediente VARCHAR(50))
RETURNS TABLE
AS
RETURN
SELECT p.Nome, Prezzo
FROM Pizza p WHERE p.CodicePizza NOT IN (
								SELECT p.CodicePizza FROM Pizza p
								JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
								JOIN Ingrediente i ON pizzaing.CodiceIngrediente = i.CodiceIngrediente
								WHERE I.Nome = @NomeIngrediente)
GO
/****** Object:  View [dbo].[MenuPizze]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MenuPizze] AS
SELECT p.Nome as Pizza, p.Prezzo, STUFF(
								(
								SELECT ', '+ i.Nome
								FROM Ingrediente i
								JOIN PizzaIngrediente pizzaing ON i.CodiceIngrediente = pizzaing.CodiceIngrediente
								JOIN Pizza p2 ON pizzaing.CodicePizza = p2.CodicePizza
								WHERE p2.CodicePizza = p.CodicePizza
								FOR XML PATH ('')), 1, 1, '') Ingredienti
FROM Pizza p
GO
ALTER TABLE [dbo].[PizzaIngrediente]  WITH CHECK ADD  CONSTRAINT [FK_Ingrediente] FOREIGN KEY([CodiceIngrediente])
REFERENCES [dbo].[Ingrediente] ([CodiceIngrediente])
GO
ALTER TABLE [dbo].[PizzaIngrediente] CHECK CONSTRAINT [FK_Ingrediente]
GO
ALTER TABLE [dbo].[PizzaIngrediente]  WITH CHECK ADD  CONSTRAINT [FK_Pizza] FOREIGN KEY([CodicePizza])
REFERENCES [dbo].[Pizza] ([CodicePizza])
GO
ALTER TABLE [dbo].[PizzaIngrediente] CHECK CONSTRAINT [FK_Pizza]
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD CHECK  (([Costo]>(0)))
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD CHECK  (([Scorte]>=(0)))
GO
ALTER TABLE [dbo].[Pizza]  WITH CHECK ADD CHECK  (([Prezzo]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[AssignIngredienteToPizza]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AssignIngredienteToPizza]
@NomeIngrediente VARCHAR(50),
@NomePizza VARCHAR(50)
AS
DECLARE @IDINGREDIENTE INT
DECLARE @IDPIZZA INT
SELECT @IDINGREDIENTE = i.CodiceIngrediente FROM Ingrediente i WHERE i.Nome = @NomeIngrediente;
SELECT @IDPIZZA = p.CodicePizza FROM Pizza p WHERE p.Nome = @NomePizza;
INSERT INTO PizzaIngrediente VALUES (@IDPIZZA,@IDINGREDIENTE)
GO
/****** Object:  StoredProcedure [dbo].[DeleteIngredienteFromPizza]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteIngredienteFromPizza]
@NomePizza VARCHAR(50),
@NomeIngrediente VARCHAR(50)
AS
DECLARE @IDINGREDIENTE INT
DECLARE @IDPIZZA INT
SELECT @IDINGREDIENTE = i.CodiceIngrediente FROM Ingrediente i WHERE i.Nome = @NomeIngrediente;
SELECT @IDPIZZA = p.CodicePizza FROM Pizza p WHERE p.Nome = @NomePizza;

DELETE FROM PizzaIngrediente WHERE CodicePizza = @IDPIZZA AND CodiceIngrediente = @IDINGREDIENTE;
GO
/****** Object:  StoredProcedure [dbo].[InsertIngrediente]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIngrediente]
@NomeIngrediente VARCHAR(50),
@Costo DECIMAL(4,2),
@Scorte INT
AS
INSERT INTO Ingrediente VALUES(@NomeIngrediente,@Costo,@Scorte);
GO
/****** Object:  StoredProcedure [dbo].[InsertPizza]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPizza]
@NomePizza VARCHAR(50),
@Prezzo DECIMAL(4,2)
AS
INSERT INTO Pizza VALUES(@NomePizza,@Prezzo);
GO
/****** Object:  StoredProcedure [dbo].[PriceIncrease]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PriceIncrease]
@NomeIngrediente VARCHAR(50)
AS
DECLARE @IDINGREDIENTE INT
SELECT @IDINGREDIENTE = i.CodiceIngrediente FROM Ingrediente i WHERE i.Nome = @NomeIngrediente;

UPDATE Pizza SET Prezzo = Prezzo+((Prezzo*10)/100)
FROM Pizza p
JOIN PizzaIngrediente pizzaing ON p.CodicePizza = pizzaing.CodicePizza
WHERE pizzaing.CodiceIngrediente = @IDINGREDIENTE;
GO
/****** Object:  StoredProcedure [dbo].[UpdatePrezzo]    Script Date: 17/12/2021 15:24:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePrezzo]
@NomePizza VARCHAR(50),
@Prezzo DECIMAL(4,2)
AS
DECLARE @IDPIZZA INT
SELECT @IDPIZZA = p.CodicePizza FROM Pizza p WHERE p.Nome = @NomePizza;
UPDATE Pizza SET Prezzo = @Prezzo WHERE CodicePizza = @IDPIZZA
GO
USE [master]
GO
ALTER DATABASE [Pizzeria] SET  READ_WRITE 
GO
