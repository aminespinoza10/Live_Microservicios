# Estructura de la base de datos

Para desplegar la base de datos requerida solo necesitas correr este script en tu servidor de bases de datos.

```sql
CREATE TABLE [dbo].[Table]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Nombre] NVARCHAR(70) NOT NULL, 
    [Apellidos] NVARCHAR(70) NOT NULL, 
    [Correo] NVARCHAR(120) NOT NULL, 
    [Telefono] NVARCHAR(20) NOT NULL

)
```
