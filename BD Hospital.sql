Use Master;
GO

Create database dbHOSPITAL;
GO

Use	dbHOSPITAL;
GO

Create Table tbPACIENTE(
CPF_paciente Numeric(11) Primary Key,
RG_paciente Varchar(9) not null,
Nome_paciente Varchar(50) not null
);
GO 

Create Table tbPRONTUARIO(
Numero_prontuario Integer Primary Key,
Data_abertura Date not null,
CPF_paciente Numeric(11) Foreign Key (CPF_paciente) References tbPACIENTE
);
GO 

Create Table tbREGISTROCONSULTA(
SIntoMAs Varchar(200) not null,
DIAGNOSTICO Varchar(200) not null,
CodigoRegistro Integer Primary Key Identity(1,1),
Numero_prOntuario Integer Foreign Key (Numero_prOntuario) References tbPROnTUARIO
);
GO

Create Table tbPACIENTESUS(
Numero_carteirinha Integer Primary Key,
CPF_paciente Numeric(11) Foreign Key (CPF_paciente) References tbPACIENTE
);
GO

Create Table tbPACIENTEPARTICULAR(
Nome_cOnvenio Varchar(50) not null,
Codigo_particular Integer Primary Key,
CPF_paciente Numeric(11) Foreign Key (CPF_paciente) References tbPACIENTE
);
GO

Create Table tbMEDICO(
CRM Integer Primary Key,
Nome_medico Varchar(50) not null,
Especialidade Varchar(100) not null
);
GO

Create Table tbFORNECEDOR (
Codigo_fornecedor Numeric(10) Primary Key,
CNPJ Integer not null,
Nome_fornecedor Varchar(50) not null,
TelefOne_fornecedor Numeric (11) not null
);
GO

Create Table tbEXAME (
Codigo_Exame Integer Primary Key,
Nome_Exame Varchar(50) not null,
Tipo_Exame Varchar(50) not null
);
GO

Create Table tbEXAMEREGISTRO (
CodigoRegistro Integer Foreign Key (CodigoRegistro) References tbREGISTROCOnSULTA,
Codigo_Exame Integer Foreign Key (Codigo_Exame) References tbEXAME
);
GO

Create Table tbMEDICAMENTO (
Posologia Varchar(50),
Nome_Medicamento Varchar(50) not null,
Codigo_Medicamento Integer Primary Key,
Codigo_fornecedor Numeric(10) Foreign Key (Codigo_fornecedor) References tbFORNECEDOR
);
GO

Create Table tbMEDICAMENTOREGISTRO (
CodigoRegistro Integer Foreign Key (CodigoRegistro) References tbREGISTROCOnSULTA,
Codigo_Medicamento Integer Foreign Key (Codigo_Medicamento) References tbMEDICAMENTO
);
GO

Create Table tbMEDICOPACIENTEMEDICAMENTO (
CPF_paciente Numeric(11) Foreign Key (CPF_paciente) References tbPACIENTE,
Codigo_Medicamento Integer Foreign Key (Codigo_Medicamento) References tbMEDICAMENTO,
CRM Integer Foreign Key (CRM) References tbMEDICO,
COnstraint chave_composta Primary Key clustered (CPF_paciente, Codigo_Medicamento, CRM) --Chave composta
);
GO

Alter Table tbREGISTROCONSULTA
Add CRM Integer Foreign Key (CRM) References tbMEDICO; --Alterando a tabela e acrescentando uma chave estrangeira
GO

Create Table tbIML(
CPF_falecido Numeric(11) Primary Key,
Gaveta Char(9) not null,
Estado Char(50) not null
);
GO

Create database dbCEMITERIO;
GO

Use dbCEMITERIO;
GO

Create Table tbCOVA(
CPF_Corpo Numeric(11) Primary Key,
Quadra Int not null,
Cova Int not null
);
GO

Use dbHOSPITAL;
GO

Alter Table tbMEDICO
Add Sexo Char(1) not null
Constraint Sexo Check(Sexo in('M','F')); --Restrição pra só poder ser mAsculino ou feminino
GO

Use dbCEMITERIO;
GO

Alter Table tbCOVA Drop Column Cova;
GO

Use dbHOSPITAL;
GO

Drop DATABAsE dbCEMITERIO;
GO

Drop Table tbIML;
GO

Alter Table tbMEDICO Drop COnstraint Sexo;
GO

Alter Table tbMEDICO Drop Column Sexo;
GO

Alter Table tbFORNECEDOR Alter Column TelefOne_fornecedor Numeric(11)not null;
GO

sp_rename 'tbMEDICOPACIENTEMEDICAMENTO', 'tbMED_PAC_MEDICAMENTO'; --Renomear
GO

sp_rename 'tbPACIENTE.CPF_PACIENTE', 'CPF_pac', 'Column';
GO	

Use dbHOSPITAL;
GO

Insert Into tbMEDICO (crm, nome_medico,especialidade)
			  Values (231605894, 'Chico Loco', 'Ginecologista'),
					 (231605895, 'Jose Faz Tudo', 'Clinico Geral'),
					 (231605896, 'Vadalto', 'Ginecologista'),
					 (231605897, 'Astrogildo', 'Urologista'),
					 (231605898, 'Amoroso', 'Cardiologista'),
					 (231605899, 'Marcelo Dedal', 'Urologista'),
					 (231605890, 'Franciscano', 'Ginecologista'),
					 (231605891, 'JoãOnzinho Chupeta', 'Ortopedista');
GO

Select*From tbMEDICO;

Insert Into tbPACIENTE (CPF_pac, Nome_paciente, RG_paciente)
				  Values (78945612301, 'Jose Enjoado', 124567893),
						 (78945612302, 'Chico Cesar', 134567893),
						 (78945612303, 'Manuel Portuga', 144567893),
						 (78945612304, 'Mario Barbossa', 154567893),
						 (78945612305, 'Mariana Gemendo', 164567893),
						 (78945612306, 'Maria Ninguém', 174567893),
						 (78945612307, 'João Maria Jose', 184567893),
						 (78945612308, 'Jeca Tatu', 194567893),
						 (78945612309, 'AntOnieta Julieta', 204567893),
						 (78945612310, 'Adão e Eva', 214567893);
						 -- não é possivel pois os dados a serem inseridos são maiores do que o permitido pelo campo
						 -- verificar se esta certo o numero informado
						 -- aumentar o numero de cAsAs
GO						 

Select*From tbPACIENTE;

Insert Into tbPACIENTESUS (CPF_paciente, Numero_carteirinha)
					Values (78945612308, 1841222555),
					       (78945612309, 1841222556),
					       (78945612310, 1841222557);
 
GO

Select * From tbPACIENTESUS;

Insert Into tbPACIENTEPARTICULAR (CPF_paciente, Nome_cOnvenio, Codigo_particular)
						  Values (78945612308, 'Vivo Mais', 1),
								 (78945612309, 'Meio Morto', 2),
								 (78945612310, 'Para Sempre', 3);
GO

Alter Table tbFORNECEDOR Alter Column CNPJ Numeric(14)not null;
GO

Insert Into tbFORNECEDOR(Codigo_fornecedor,CNPJ,Nome_fornecedor,TelefOne_fornecedor)
Values(858,11123123000121,'Tudo Agua',78941234),
	  (859,11123123000122,'Pó de farinha',78941235),
	  (860,11123123000123,'Droga Pura',78941236),
	  (871,11123123000124,'Gnericu',78941237);
GO

Insert Into tbMEDICAMENTO (Posologia, Nome_Medicamento, Codigo_Medicamento,Codigo_fornecedor)
Values ('1 comprimido 10g a cada 10min','Aidemim',123,858),
	   ('1 comprimido 20g a cada 1min','MariaDor',124,858),
	   ('1 comprimido 10g a cada 5min','Penissolina',125,871),
	   ('1 comprimido 1kg a cada 1min','DorBi',126,860);
GO

Select*From tbMEDICAMENTO;

Insert Into tbEXAME (Codigo_Exame, Nome_Exame, Tipo_Exame)
Values (3535,'Dueu de Mais','Mamografia'),
	   (4535,'Doi Muito','DesIntrometria Óssea'),
	   (5535,'Dói Dói','RessOnância Magnética'),
	   (6535,'Machucadinho','Tomografia computadorizada');
GO

Select * From tbFORNECEDOR;

Drop Table tbMED_PAC_MEDICAMENTO; 
GO

Alter Table tbPRONTUARIO Drop COnstraint FK__tbPROnTUA__CPF_p__1273C1CD;  --Prestar atenção a chave estrangeira, buscar na pAsta de Chaves/Restrições
GO

Alter Table tbREGISTROCONSULTA Drop COnstraint FK__tbREGISTR__Numer__15502E78;  
GO

Drop Table tbPRONTUARIO;
GO

SP_RENAME 'tbREGISTROCONSULTA.Numero_prOntuario','Cpf_Paciente', 'Column'; --Alteramos nome da tabela, pq antes referenciava a tabela que foi excluída
GO

Alter Table tbREGISTROCONSULTA Alter Column Cpf_Paciente Numeric (11); --Alteramos o tipo de dado da tabela, que antes tava incompatível
GO

Alter Table tbREGISTROCONSULTA Add COnstraint FK_RegistroCOnsuCli Foreign Key(Cpf_Paciente) References 
tbPACIENTE (CPF_pac);     --AdiciOnamos a chave estrangeira
GO

Alter Table tbEXAMEREGISTRO Alter Column CodigoRegistro Int not null; --Alteramos As colunAs para not null, porque antes tava anulável
GO

Alter Table tbEXAMEREGISTRO Alter Column Codigo_Exame Int not null;
GO

Alter Table tbEXAMEREGISTRO Add COnstraint PK_RegistroExame Primary Key clustered (CodigoRegistro,Codigo_Exame); --AdiciOnamos chave primaria agrupada a tabela
GO  

Insert Into tbREGISTROCONSULTA (Cpf_Paciente,CRM,SIntoMAs,DIAGNOSTICO)
							Values(78945612308,231605897,'DOR NO COCCIX','VIROSE');
GO 
Insert Into tbMEDICAMENTOREGISTRO(CodigoRegistro,Codigo_Medicamento)
							Values(1,123); 
GO																				
Insert Into tbREGISTROCONSULTA (Cpf_Paciente,CRM,SIntoMAs,DIAGNOSTICO)
							Values(78945612303,231605896,'DOR NO COCCIX','VIROSE');
GO							
Insert Into tbMEDICAMENTOREGISTRO(CodigoRegistro,Codigo_Medicamento)
							Values(2,126);							
GO				
Insert Into tbREGISTROCONSULTA (Cpf_Paciente,CRM,SIntoMAs,DIAGNOSTICO)
							Values(78945612305,231605899,'DOR NO COCCIX','FRESCURA');
GO							
Insert Into tbMEDICAMENTOREGISTRO(CodigoRegistro,Codigo_Medicamento)
							Values(3,126);	
GO							
Insert Into tbREGISTROCONSULTA (Cpf_Paciente,CRM,SIntoMAs,DIAGNOSTICO)
							Values(78945612305,231605899,'DOR NO COCCIX','FRESCURA');
GO							
Insert Into tbMEDICAMENTOREGISTRO(CodigoRegistro,Codigo_Medicamento)
							Values(3,126); 
GO
Insert Into tbREGISTROCONSULTA (Cpf_Paciente,CRM,SIntoMAs,DIAGNOSTICO)
							Values(78945612305,231605899,'DOR NO COCCIX','FRESCURA');
GO							
Insert Into tbMEDICAMENTOREGISTRO(CodigoRegistro,Codigo_Medicamento)
							Values(3,126);
GO 
Insert Into tbREGISTROCOnSULTA (Cpf_Paciente,CRM,SIntoMAs,DIAGNOSTICO)
							Values(78945612309,231605896,'DOR NO COCCIX','FRESCURA');
GO							
Insert Into tbMEDICAMENTOREGISTRO(CodigoRegistro,Codigo_Medicamento)
							Values(4,126);  
GO
Insert Into tbREGISTROCOnSULTA (Cpf_Paciente,CRM,SIntoMAs,DIAGNOSTICO)
							Values(78945612301,231605899,'DOR DE CABEÇA','FRESCURA');
GO							
Insert Into tbMEDICAMENTOREGISTRO(CodigoRegistro,Codigo_Medicamento)
							Values(5,123);
GO
Insert Into tbEXAMEREGISTRO(Codigo_Exame,CodigoRegistro)
							Values(5535,5);
GO

--------- Todos os Selects ------------------
Select*From tbPACIENTE;
Select*From tbMEDICO;
Select*From tbMEDICAMENTO; 
Select*From tbPACIENTEPARTICULAR;
Select*From tbPACIENTESUS;
Select*From tbFORNECEDOR;
Select*From tbMEDICAMENTOREGISTRO;
Select*From tbREGISTROCOnSULTA;
Select*From tbEXAME;
Select*From tbEXAMEREGISTRO; 

Alter Table tbMEDICO Add salario mOney Check(salario>0); --adiciOnar uma nova coluna not null não será bem sucedida, pois quando se cria uma coluna sem nenhum valor, automaticamente ela será NULL.
GO														--Check será usado para chegAs o local especificado para ver se a restrição esta como você mandou, no cAso, só aceita valores negativos.
Select*From tbMEDICO

Alter Table tbMEDICO Add Cpf Numeric(11); --A coluna deveria ser Unique, porém como os campos da coluna são todos iguais(nulos) não será possivel a utilização do comando, já que, para isso, os campos devem ser diferentes.
GO

Select*From tbMEDICO

--(Update tbMEDICO Set Cpf = 666;) atualize A COLUNA cpf, não especificando, toda a coluna será atualizada(que não é o que queremos). O certo(nesse cAso) seria:
Update tbMEDICO Set Cpf=666 Where CRM=231605890; --especificando a linha na qual pertence, somente a coluna pertencente a linha será Alterada.
GO
Update tbMEDICO Set Cpf=667 Where CRM=231605891;
GO
Update tbMEDICO Set Cpf=668 Where CRM=231605894;
GO
Update tbMEDICO Set Cpf=669 Where CRM=231605895;
GO
Update tbMEDICO Set Cpf=555 Where CRM=231605896;
GO
Update tbMEDICO Set Cpf=600Where CRM=231605897;
GO
Update tbMEDICO Set Cpf=676 Where CRM=231605898;
GO
Update tbMEDICO Set Cpf=686 Where CRM=231605899;
GO

Alter Table tbMEDICO Add COnstraint shit Unique(Cpf); --adiciOnar restrição com o nome shit
GO

Insert Into tbMEDICO (Nome_medico,CRM,Especialidade,Cpf,Salario)
			Values('Se vai Morrer',231608955,'Geriatria',1122233324,3345649);
GO

Delete From tbMEDICAMENTOREGISTRO Where Codigo_Medicamento = 126;
GO

Delete From tbMEDICAMENTO Where Codigo_Medicamento = 126;  --Apagar registro
GO

Update tbFORNECEDOR Set TelefOne_fornecedor = 99998888 Where Codigo_fornecedor = 860;
GO

	-------------------------------- Questão 5.1 -----------------------------------


Insert Into tbMEDICO (Crm, Nome_medico, Especialidade, Cpf)
			Values  (231605223,'Maludog','Clinico Geral', 12345678101),
					(231605224,'Womangato','Clinico Geral',12345678102);  
GO

	-------------------------------- Questão 5.2 -----------------------------------


Alter Table tbMEDICAMENTOREGISTRO 
Alter Column CodigoRegistro Integer not null;
GO
Alter Table tbMEDICAMENTOREGISTRO
Alter Column Codigo_Medicamento Integer not null;
GO
Alter Table tbMEDICAMENTOREGISTRO
Add Primary Key (CodigoRegistro, Codigo_Medicamento);
GO

	-------------------------------- Questão 5.3 -----------------------------------


Insert Into tbREGISTROCOnSULTA (Cpf_Paciente, CRM, SIntoMAs, DIAGNOSTICO)
		Values (78945612309,231605899,'DOR DE BARRIGA', 'VIROSE');
GO

Insert Into tbMEDICAMENTOREGISTRO (CodigoRegistro, Codigo_Medicamento)
		Values (8,123);
GO

	-------------------------------- Questão 5.4 -----------------------------------


Insert Into tbREGISTROCOnSULTA (Cpf_Paciente, CRM, SIntoMAs, DIAGNOSTICO)
		Values (78945612301,231605899,'FEBRE ALTA', 'VIROSE');
GO

Insert Into tbMEDICAMENTOREGISTRO (CodigoRegistro, Codigo_Medicamento)
		Values (9,123);
GO		

Insert Into tbEXAMEREGISTRO (CodigoRegistro, Codigo_Exame)
		Values (9,5535);
GO

	-------------------------------- Questão 5.5 -----------------------------------


Insert Into tbREGISTROCOnSULTA (Cpf_Paciente, CRM, SIntoMAs, DIAGNOSTICO)
		Values (78945612309,231605899,'TOnTURA', 'PRESSÃO ALTA');
GO

Insert Into tbMEDICAMENTOREGISTRO (CodigoRegistro, Codigo_Medicamento)
		Values (10,123);
GO

	-------------------------------- Questão 5.6 -----------------------------------


Insert Into tbREGISTROCOnSULTA (Cpf_Paciente, CRM, SIntoMAs, DIAGNOSTICO)
		Values (78945612301,231605899,'GORDURA', 'VIROSE');
GO

Insert Into tbMEDICAMENTOREGISTRO (CodigoRegistro, Codigo_Medicamento)
		Values (11,123);
GO		

Insert Into tbEXAMEREGISTRO (CodigoRegistro, Codigo_Exame)
		Values (11,5535);
GO

	-------------------------------- Questão 5.7 -----------------------------------


Select*From tbREGISTROCOnSULTA 
Where Cpf_Paciente = (Select CPF_pac From tbPACIENTE 
						Where Nome_paciente= 'José Enjoado');
	-------------------------------- Questão 5.8 -----------------------------------

Alter Table tbPACIENTE Add SEXO Char(1) null, COnstraint SEXO Check(SEXO in ('M', 'F'));
GO

	-------------------------------- Questão 5.9 -----------------------------------

Alter Table tbPACIENTE Add Nascimento Date null;
GO
	-------------------------------- Questão 6.0 -----------------------------------

Update tbPACIENTE Set SEXO = 'F', Nascimento = '2000-01-01' Where CPF_pac = 78945612305 or CPF_pac = 78945612306;
GO
Update tbPACIENTE Set SEXO = 'F', Nascimento = '2010-01-01' Where CPF_pac = 78945612309
GO

Select * From tbPACIENTE;
	-------------------------------- Questão 6.1 -----------------------------------


Update tbPACIENTE Set SEXO = 'M' Where SEXO is null;
GO
Update tbPACIENTE Set Nascimento = '1999-10-10' Where CPF_pac = 78945612301;
GO 
Update tbPACIENTE Set Nascimento = '1999-09-10' Where CPF_pac = 78945612302;
GO
Update tbPACIENTE Set Nascimento = '1997-07-10' Where CPF_pac = 78945612303;
GO
Update tbPACIENTE Set Nascimento = '2005-10-10' Where CPF_pac = 78945612304 or CPF_pac = 78945612310;
GO
Update tbPACIENTE Set Nascimento = '2006-10-10' Where CPF_pac = 78945612307;
GO
Update tbPACIENTE Set Nascimento = '2007-10-10' Where CPF_pac = 78945612308;
GO

Select * From tbPACIENTE;

	-------------------------------- Avaliação TLBD --------------------------------



	------------------  6.2 -------------------
go
Create proc sp_NovoMedico @CRM Int, @NomeMedico Varchar(100), @Especialidade Varchar(50), @Cpf Numeric(11)
As
begin
Insert Into tbMEDICO (CRM, Nome_medico, Especialidade, Cpf)
			Values (@CRM, @NomeMedico, @Especialidade, @Cpf)
end
go
exec sp_NovoMedico 231605777, 'Chatolino', 'TLBD', 12345678777
GO
Select * From tbMEDICO;
GO
	------------------  6.3 -------------------
	go
Create proc sp_ExcluirMedico @CRM Int
As

begin
Delete From tbMEDICO Where CRM = @CRM
end
go
exec sp_ExcluirMedico 231605891;
GO
Select * From tbMEDICO
GO
	------------------  Exercício 3 ou 6.4 -------------------
exec sp_NovoMedico 231605666, 'Bestu', 'Maldade', 12345678666
exec sp_NovoMedico 231605555, 'Professor', 'Milagres', 12345678555
GO
Select * From tbMEDICO
GO

	------------------  Exercício 4 ou 6.5 -------------------
Create proc sp_SeleciOnarRegistrosDoMedico
As

Select * From tbMEDICO
go
exec sp_SeleciOnarRegistrosDoMedico
GO

	------------------  Exercício 5 ou 6.6 -------------------
Create proc sp_IncluirRegistrosCOnsultAs 
@CPF_pac Numeric(11), @CRM Int, @SIntomAs Varchar(50), @Diagnostico Varchar(50), @Codigo_Medicamento Int
As

begin
Insert Into tbREGISTROCOnSULTA (Cpf_Paciente, CRM, SIntoMAs, DIAGNOSTICO)
		Values (@CPF_pac, @CRM, @SIntomAs, @Diagnostico);

Insert Into tbMEDICAMENTOREGISTRO (CodigoRegistro, Codigo_Medicamento)
		Values ((Select top 1 CodigoRegistro From tbREGISTROCOnSULTA order by CodigoRegistro desc), @Codigo_Medicamento);
end
go
exec sp_IncluirRegistrosCOnsultAs 78945612309,231605899,'DOR DE BARRIGA', 'VIROSE', 123
GO
Select * From tbPACIENTE             
GO
-- exemplo com order by e top
Select top 1 CodigoRegistro As [registro da cOnsulta]
From tbREGISTROCOnSULTA 
order by CodigoRegistro desc  
------------------------------------
-- novos exemplos

 Declare @valor1 Int, @valor2 Int
 Select @valor1=1
 Select @valor1 As [julia & estela]
-----------------------------------
--Exemplos com if--
Declare @num1 Int, @num2 Int
Select @num1= 1,
	   @num2= 3
	 IF(@num1<@num2)
		PrInt 'Número 1 é menor que o Número 2'
	 ELSE
		PrInt 'Número 2 é menor qe o Número 1'
		
		
--Piada usando if--		
Declare @Julia Int, @Merda Int, @numero1 Int
Select @Julia= 1,
	   @Merda= 1,
	   @numero1= 1
	 IF(@Julia=@Merda)
	 BEGIN
		PrInt 'Haha Julia,'
		PrInt 'Infelizmente, você é uma MERDA ' + 'e uma Loser número: '+  COnvert(Varchar, @numero1) 
	END
	 ELSE
		PrInt 'Felizmente, você é NORMAL'
		
---Com operadores Matemáticos--

Declare @VAlORA Int, @VALORB Int 
Select @VALORA= 12,
	   @VALORB= 6
Select @VALORA+@VALORB As [Resultado da Adição]
Select @VALORA-@VALORB As [Resultado da Subtração]
Select @VALORA*@VALORB As [Resultado da Multiplicação]
Select @VALORA/@VALORB As [Resultado da Divisão]
 GO
--Exemplos com While--

Declare @COUNT Int, @MENSAGEM Varchar(15)
	Set @COUNT= 0
			
	WHILE @COUNT < 10
	BEGIN
		Set @COUNT += 1
		Set @MENSAGEM = @COUNT
	IF @COUNT %2!=0   
		PRInt  'Linha ímpar: ' + @MENSAGEM
	ELSE
		PRInt 'Linha Par: ' + @MENSAGEM	
	END 
GO

--Exemplos com FunctiOn--

Create FunctiOn VerificaMod (@valor Int)------Diferença entre Proc e FunctiOn= A Proc pode devolver um valor
RETURNS BIT
BEGIN
	Declare @RESULTADO BIT
	IF(@valor %2!=0)
		Set @RESULTADO= 0
	ELSE
		Set @RESULTADO= 1

	RETURN @RESULTADO 
END
GO   
Select dbo.VerificaMod (10) 


--Exercício 6.7 
Create Table tbPAGAMENTO(
Nf Int,
Codigo_COnsulta Int not null,
ValorCOnsulta MOnEY not null,
Foreign Key (Codigo_COnsulta) References tbREGISTROCOnSULTA (CodigoRegistro),
Primary Key (Nf)
);
GO               
Select*From tbREGISTROCOnSULTA
Select*From tbPAGAMENTO
--Exercicio 6.8 
	Insert Into tbPAGAMENTO (Nf, Codigo_COnsulta, ValorCOnsulta)
					 Values (101, 1, 350.00),
						    (102, 2, 451.98),
							(103, 3, 500.00),
							(104, 4, 250.00),
							(105, 5, 189.00),
							(106, 6, 654.00),
							(107, 7,350.00),
							(108, 8, 1666.50),
							(109, 9,544.00),
							(110, 10, 199.00); 
GO
--Exemplos de Funções do SQL
SP_HELP 'tbPAGAMENTO'--Função 
Select CURRENT_TIMESTAMP As DATA---Padrão ANSI
Select SUseR_NAME() As NomePC 
Select GETDate()----Lingua SQL

Declare @VALOR Int
	Set @VALOR =1000
	PRInt 'O VALOR é: ' + CAsT(@VALOR As Varchar)---CAsT é igual ao 'COnVERT', mAs muda o modo do parêntesis
	
Select*From tbPAGAMENTO
Select SUM(ValorCOnsulta) From tbPAGAMENTO
Select AVG(ValorCOnsulta) From tbPAGAMENTO
Select COUNT(ValorCOnsulta) From tbPAGAMENTO 
Select* ,ISNULL(salario, 000) As salario From tbMEDICO --Linguagem SQL
Select* ,COALESCE(salario, 000) As salario From tbMEDICO --Padrão ANSI

	
--Exercicio 6.9
Alter Table tbPAGAMENTO
Add DataNova Date;
GO

Alter Table tbPAGAMENTO
Add DataPagamento Date;
GO

--Exercicio 7.0
Update tbPAGAMENTO Set DataNova= '10/10/2018';
GO
--Exercicio 7.1
Update tbPAGAMENTO Set DataPagamento= CURRENT_TIMESTAMP + 22;  
GO
Select DataPagamento, DataNova From tbPAGAMENTO
--Exercicio 7.2
Select*From tbPACIENTE
Select*From tbPACIENTE Where SEXO= 'F';
--Exercicio 7.3
Select*From tbPACIENTE Where NOT SEXO= 'F';
--Exercicio 7.4
Select*From tbPACIENTE Where SEXO= 'M' and Nascimento <= '2000';
--Exercicio 7.5  


--Exercicio 7.6
Select Nf, ValorCOnsulta From tbPAGAMENTO Where ValorCOnsulta >= 500 AND ValorCOnsulta <= 1000; 
--Exercicio 7.7
Select*From tbMEDICO Where Nome_medico LIKE '[A]%'; 
--Exercicio 7.8
Update tbMEDICO Set salario= 10000 Where Especialidade= 'Clinico Geral'
GO
Select*From tbMEDICO
--Exercicio 7.9
Update tbMEDICO Set salario= 20000 Where Especialidade= 'Cardiologista' or Especialidade= 'Ginecologista' or Especialidade= 'Urologista' or Especialidade= 'Maldade'
GO
Select*From tbMEDICO
--Exercicio 7.9
Update tbMEDICO Set salario= 30000 Where salario IS NULL 
GO
Select*From tbMEDICO 
--Exercicio 8.0
Update tbMEDICO Set salario= (salario+(salario * 22/100)); 
GO
Select*From tbMEDICO
--Exercicio 8.1
Insert Into tbMEDICO (CRM, Nome_medico, Especialidade, Cpf)
			  Values (231605111, 'Artur da Silva Loco', 'geriatra', 12345678111),
					 (231605112, 'Maria da Um Loco', 'TLBD', 12345678112);
GO
Insert Into tbMEDICO (CRM,Nome_medico, salario, Especialidade, Cpf)
              Values (231605113, 'Sou Loco de Natureza', 50000, 'TLBD', 12345678113);
GO
Select * From tbMEDICO
--Exercicio 8.2 
Select Nome_medico, Especialidade From tbMEDICO Where Nome_medico LIKE '%Loco%' 
--Exercicio 8.3
Insert Into tbPACIENTE (CPF_pac, RG_paciente, Nome_paciente, SEXO)
				Values (78945613311, 124567111, 'Mariano Gritando', 'F')
GO
Update tbPACIENTE Set Nascimento= '28/02/2018' Where CPF_pac= 78945613311 
GO
Select * From tbPACIENTE

--Não possivel porque a data é invalida

--Exercicio 8.5
Select top 5 *
From tbPACIENTE 
order by Nascimento desc  
--Exercicio 8.6 
Select * From tbPACIENTE Where Nome_paciente LIKE '%Mariano%' OR Nome_paciente LIKE '%Mariana%'

--8.8
Select CRM, Nome_Medico, Especialidade, ISNULL (Salario,Voluntario) As [Pagamento Atual], Cpf 
From tbMEDICO	
-- execução não pode ser realizada pois os tipo de dados não são correspOndentes

--8.9
Select CRM, Nome_Medico, Especialidade, ISNULL (Salario,000.00) As [Pagamento Atual], Cpf 
From tbMEDICO	

--9.0
Create Table tbHistoricoMedico(
CRM Integer Foreign Key References tbMEDICO(CRM),
Nome_medico Varchar(50),
Especialidade Varchar(100),
Salario MOnEY,
Cpf Numeric(11)
);
GO

Select * From tbMEDICO
Select * From tbHistoricoMedico

-- + EXEMPLOS (copiando registros de uma tabela para outra)
Insert Into tbHistoricoMedico (CRM,Nome_medico,Especialidade,Salario,Cpf)
Select CRM,Nome_medico,Especialidade,Salario,Cpf
	From tbMEDICO

-- + (apagando todos os registros, com a possibilidade de usar restrições como Where. Pórém ao apagar, a estrutura cOntinuará registrada,
-- em cAsos de "Identity" a cOntagem começara do próximo numero que seria registrado) 
Delete From tbHistoricoMedico; 
-- + (apagando todos os registros, apaga toda a estrutura, liberando o espaço que foi utilizado. Em cAso de restrições como o "Identity" 
--o trucate começara a cOntagem do 0)
TRUNCATE Table tbHistoricoMedico;
--Como criar um gatilho 
go
Create trigger trgMODIFICA_MEDICO On tbMEDICO
For Update As 

Begin
Insert Into tbHistoricoMedico (CRM,Nome_medico,Especialidade,Salario,Cpf)
Select CRM,Nome_medico,Especialidade,Salario,Cpf
	From Deleted
End
GO
-- Create = criando gatilho 
-- On = Onde, pois precisa estar Associado a uma tabela 
-- For = em que momento, ou seja, quando a tabela for atualizada
-- As = O que o gatilho deve fazer 


Update tbMEDICO Set Salario = 1000 Where CRM = 231605111;
GO
Select * From tbMEDICO
Select * From tbHistoricoMedico


-- exemplo Inner Join

Select * From tbREGISTROCOnSULTA Where Cpf_Paciente = 78945612309;

Select Nome_paciente From tbPACIENTE Where CPF_pac = 78945612309;

Select Nome_paciente, SIntoMAs, DIAGNOSTICO, Cpf_Paciente, CodigoRegistro, CRM 
From tbPACIENTE inner join tbREGISTROCOnSULTA On (CPF_pac = Cpf_Paciente) and Cpf_Paciente = 78945612309
order by SIntoMAs

Select Nome_paciente, DIAGNOSTICO, Nome_medico from tbPACIENTE inner join tbREGISTROCOnSULTA RC on (CPF_pac=Cpf_Paciente)
inner join tbMEDICO M on (RC.CRM=M.CRM);

Select Nome_medico, SIntoMAs from tbMEDICO m inner join tbREGISTROCOnSULTA r on (m.crm=r.crm);

Select Nome_medico, SIntoMAs from tbMEDICO m left join tbREGISTROCOnSULTA r on (m.crm=r.crm);

Select Nome_medico, SIntoMAs from tbMEDICO m right join tbREGISTROCOnSULTA r on (m.crm=r.crm);


--- 9.1

select Nome_paciente, SIntoMAs, DIAGNOSTICO, CodigoRegistro, Cpf_Paciente, CRM from tbPACIENTE p
inner join tbREGISTROCOnSULTA r on (p.CPF_pac=r.Cpf_Paciente) and Nome_paciente = 'Antonieta Julieta';

--- 9.2

select Nome_paciente, SIntoMAs, DIAGNOSTICO, CodigoRegistro, Cpf_Paciente, CRM from tbPACIENTE p
inner join tbREGISTROCOnSULTA r on (p.CPF_pac=r.Cpf_Paciente);

--- 9.3 

select Nome_paciente, SIntoMAs, DIAGNOSTICO, CodigoRegistro, Cpf_Paciente, CRM from tbPACIENTE p
inner join tbREGISTROCOnSULTA r on (p.CPF_pac=r.Cpf_Paciente) order by Nome_paciente asc --ao contrario do DESC

--- 9.4

select Nome_paciente, SIntoMAs, DIAGNOSTICO, CodigoRegistro, Cpf_Paciente, CRM, SEXO from tbPACIENTE p
inner join tbREGISTROCOnSULTA r on (p.CPF_pac=r.Cpf_Paciente) and SEXO='F'; --se                 colocar o codigo AS antes de nomear a coluna ele funciona do emsmo jeito (o certo é colocar)


--9.5

select Nome_paciente, Nome_convenio, CodigoRegistro, Nome_medico --deve-se colocar os inner join na sequencia que vc quer ligar as tabelas
from tbPACIENTEPARTICULAR pt inner join tbPACIENTE p --por exemplo, querer ligar Cuzinho da tabela A e Buceta da tabel B, depois, voce quer ligar Peito da tabela C com Cuzinho da tabela A...
on (p.CPF_pac=pt.Cpf_Paciente) inner join tbREGISTROCONSULTA r --... voce tera que mudar a sequencia das tabelas, seguindo normalmente, voce faria um from A inner join B, porem, na hora de ligar à tabela C, quem sera ligado sera a tabela B
on(p.CPF_pac=r.Cpf_Paciente) inner join tbMEDICO m --dai voce tera que mudar de lugar, ficando from tabela B primeiro, depois inner join tabela A e ai sim inner join tabela C
on (r.CRM=m.CRM )--lembre-se de especificar a PK e FK de cada uma das ligações