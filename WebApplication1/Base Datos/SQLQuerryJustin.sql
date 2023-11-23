Create DataBase JustinExamenBaseDatos
GO

Use JustinExamenBaseDatos

Create Table Usuarios
(
	UsuarioID Int Identity (1,1),
	Nombre VarChar(50),
	CorreoElectronico Varchar(50),
	Telefono Varchar(20)
	Constraint pk_Usuario Primary Key(UsuarioID)
)
GO
Create Table Equipos
(
	EquipoID Int Identity (1000,5),
	TipoEquipo VarChar(50) NOT NULL,
	Modelo VarChar(50) NOT NULL,
	UsuarioID Int,
	Constraint pk_EquipoID Primary Key (EquipoID),
)
GO
Create Table Reparaciones
(
	ReparacionID Int Identity (10,2),
	EquipoID Int,
	FechaSolicitud DateTime Constraint df_FechaSolicitud Default GetDate(),
	Estado VarChar(50),
	Constraint pk_ReparacionID Primary Key (ReparacionID),
	Constraint fk_EquipoID Foreign Key (EquipoID) References Equipos (EquipoID)
)
GO
Create Table DetalleReparacion -- A
(
	DetalleID Int Identity (30,1),
	ReparacionID Int,
	Descripcion VarChar(50),
	FechaInicio DateTime Constraint df_FechaInicio Default GetDate(),
	FechaFin DateTime Constraint df_FechaFin Default GetDate(),
	Constraint pk_DetalleID Primary Key (DetalleID),
	Constraint fk_ReparacionID Foreign Key (ReparacionID) References Reparaciones (ReparacionID)
)
GO
Create Table Tecnicos
(
	TecnicoID Int Identity(40,1),
	Nombre VarChar(50),
	Especialidad VarChar(50),
	Constraint pk_TecnicoID Primary Key (TecnicoID)
)
GO
Create Table Asignaciones 
(
	AsignacionID Int Identity (10,2),
	ReparacionID Int,
	TecnicoID Int,
	FechaAsignacion DateTime Constraint df_FechaAsignacion Default GETDATE(),
	Constraint pk_AsignacionID Primary Key (AsignacionID),
	Constraint fkk_ReparacionID Foreign Key (ReparacionID) References Reparaciones(ReparacionID),
	Constraint fk_TecnicoID Foreign Key (TecnicoID) References Tecnicos (TecnicoID)
)
GO
-- Procedimientos almacenado
Create Procedure AgregarUsuario
	@Nombre VarChar(50),
	@CorreoElectronico VarChar(50),
	@Telefono VarChar(20)
As
Begin
	Insert Into Usuarios (Nombre, CorreoElectronico, Telefono) Values (@Nombre, @CorreoElectronico, @Telefono)
End
GO
Create Procedure BorrarUsuario
	@UsuarioID Int
As
Begin
	Delete From Usuarios Where UsuarioID = @UsuarioID
End
GO
Create Procedure ConsultarUsuario_Filtro
	@UsuarioID Int
As
Begin
	Select * From Usuarios Where UsuarioID = @UsuarioID
End
GO
Create Procedure ModificarUsuario 
	@UsuarioID int,
	@Nombre VarChar(50),
	@CorreoElectronico VarChar(50),
	@Telefono VarChar(8)
As
Begin
	Update Usuarios Set Nombre = @Nombre, CorreoElectronico = @CorreoElectronico, Telefono = @Telefono Where UsuarioID = @UsuarioID
End
GO
-- Procedimientos para tabla de Equipos
Create Procedure AgregarEquipo 
	@TipoEquipo VarChar(50),
	@Modelo VarChar(50),
	@UsuarioID Int
As
Begin
	Insert Into Equipos(TipoEquipo, Modelo, UsuarioID) Values (@TipoEquipo, @Modelo, @UsuarioID)
Een
GO
Create Procedure BorrarEquipo 
	@EquipoID Int
As
Begin
	Delete From Equipos Where EquipoID = @EquipoID
End
GO
Create Procedure ConsultarEquipo_Filtro
	@EquipoID Int
As
Begin
	Select * From Equipos Where EquipoID = @EquipoID
End
GO
Create Procedure ModificarEquipo
	@EquipoID Int,
	@TipoEquipo VarChar(50),
	@Modelo VarChar(50),
	@UsuarioID Int
As
Begin
	Update Equipos Set TipoEquipo = @TipoEquipo, Modelo = @Modelo, UsuarioID = @UsuarioID Where EquipoID = @EquipoID
End
GO
-- Procedimientos para tabla de Tecnicos
Create Procedure AgregarTecnico
	@Nombre Varchar(50),
	@Especialidad Varchar(50)
As
Begin
	Insert Into Tecnicos (Nombre, Especialidad) Values (@Nombre, @Especialidad)
End
GO
Create Procedure BorrarTecnico
	@TecnicoID Int
As
Begin
	Delete From Tecnicos Where TecnicoID = @TecnicoID
End
GO
Create Procedure ConsultarTecnico_Filtro
	@TecnicoID Int
As
Begin
	Select * From Tecnicos Where TecnicoID = @TecnicoID
End
GO
Create Procedure ModificarTecnico
	@TecnicoID Int,
	@Nombre VarChar (50),
	@Especialidad Varchar(50)
As
Begin
	Update Tecnicos Set	 Nombre = @Nombre, Especialidad = @Especialidad Where TecnicoID = @TecnicoID
End