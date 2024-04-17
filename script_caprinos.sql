CREATE DATABASE sprint_2;
USE sprint_2;

CREATE TABLE cliente (
idCliente int primary key auto_increment,
nomeCliente varchar(60),
sobrenome varchar(45),
telefone char(11),
email varchar(60),
senha char(8),
CNPJ char(20));

DESCRIBE cliente;

INSERT INTO cliente VALUES 
(default,'Fernanda','Caramico', '11234567890', 'fernandaCaramico@gmail.com', '12345678', '43.023.992/0001-22');

SELECT * FROM cliente;

CREATE TABLE fazenda (
idFazenda int primary key auto_increment,
nomeFazenda varchar(60),
CEP char(9),
numeroEnd varchar(45),
complemento varchar(45),
qtdCapris int,
fkCliente int,
constraint fkFazendaCliente foreign key (fkCliente)
references cliente (idCliente));

DESCRIBE fazenda;

INSERT INTO fazenda VALUES 
(default, 'Fazenda Feliz', '03940-010','90', 'A', 4, null),
(default, 'Fazenda das Cabras', '07856-080','65','', 2, null);

UPDATE fazenda SET fkCliente = 1 WHERE idFazenda = 1;
UPDATE fazenda SET fkCliente = 1 WHERE idFazenda = 2;

SELECT * FROM fazenda;

CREATE TABLE funcionario (
idFunc int primary key auto_increment,
nomeFunc varchar(45),
sobrenome varchar(45),
telefone varchar(45),
email varchar(60),
senha char(8),
fkFFazenda int,
constraint fkFuncFazenda foreign key (fkFFazenda)
references fazenda (idFazenda));

DESCRIBE funcionario;

INSERT INTO funcionario VALUES
(default, 'Josefina','Lima', '11 97862-0888', 'joseLimaFazenda@gmail.com', '87654321', 1);

SELECT * FROM funcionario;

CREATE TABLE capril (
idCapril int primary key auto_increment,
nomeCapril varchar(45),
localizacao varchar(45),
capacidade_max int,
fkFazenda int,
constraint fkCaprilFazenda foreign key (fkFazenda)
references fazenda (idFazenda));

INSERT INTO capril VALUES
(default, 'CaprilBodes', 'Leste de fazenda', 100, null),
(default, 'CaprilCabras', 'Oeste da fazenda', 100, null),
(default, 'CaprilFilotes', 'Oeste da fazenda', 45, null),
(default, 'CaprilFilotes', 'Leste da fazenda', 35, null),
(default, 'CaprilCabras', 'Sul da fazenda', 60, null),
(default, 'CaprilBodes', 'Sul da fazenda', 50, null);

DESCRIBE capril;

UPDATE capril SET fkFazenda = 1 WHERE idCapril IN (1,2,3,4);
UPDATE capril SET fkFazenda = 2 WHERE idCapril IN (5, 6);

SELECT * FROM capril;

CREATE TABLE caprinos (
idCaprinos int primary key auto_increment,
sexo char(5),
raça varchar(45),
fkCapril int,
constraint fkCaprinosCapril foreign key (fkCapril)
references capril (idCapril));

INSERT INTO caprinos VALUES 
(default,'macho', 'bodes', null),
(default, 'femêa', 'cabras', null),
(default, 'macho', 'filhotes de cabras', null),
(default, 'fêmea', 'filhotes de cabras', null),
(default,'macho', 'bodes', null),
(default, 'femêa', 'cabras', null);

DESCRIBE caprinos;

UPDATE caprinos SET fkCapril = 1 WHERE idCaprinos = 1;
UPDATE caprinos SET fkCapril = 2 WHERE idCaprinos = 2;
UPDATE caprinos SET fkCapril = 3 WHERE idCaprinos = 3;
UPDATE caprinos SET fkCapril = 4 WHERE idCaprinos = 4;
UPDATE caprinos SET fkcapril = 5 WHERE idCaprinos = 5;
UPDATE caprinos SET fkCapril = 6 WHERE idCaprinos = 6;

SELECT * FROM caprinos;

CREATE TABLE sensores (
idSensores int primary key auto_increment,
nomeSensor varchar(45),
localizacao varchar(45),
tipoSensor varchar (45),
temp_minima double,
temp_maxima double,
fkCaprilSensor int,
constraint fkSensoresCapril foreign key (fkCaprilSensor)
references capril (idCapril));

INSERT INTO sensores VALUES
(default, 'SensorT&U','Parte superior do capril', 'temperatura e umidade', 32.5, 20.1, 1),
(default, 'SensorT&U2','Parte superior do capril', 'temperatura e umidade', 32.5, 20.1, 2);

DESCRIBE sensores;

SELECT * FROM sensores;

CREATE TABLE medida (
idMedida int primary key auto_increment,
dht11_temperatura double,
dht11_umidade int,
dtCaptura datetime,
fkSensores int,
constraint fkTempSensor foreign key (fkSensores)
references sensores (idSensores));

SELECT * FROM medida;

-- SELECT DO CLIENTE E DOS DADOS DE TODAS AS FAZENDAS

SELECT * FROM cliente JOIN fazenda ON fkCliente = idCliente
 JOIN capril ON fkFazenda = idFazenda 
 JOIN caprinos ON fkCapril = idCapril;
 
 -- SELECT DOS DADOS DO CLIENTE, FAZENDA E APENAS DOS CAPRIS QUE POSSUEM O MONITORAMENTO
 
 SELECT * FROM cliente JOIN fazenda ON fkCliente = idCliente
 JOIN capril ON fkFazenda = idFazenda 
 JOIN caprinos ON fkCapril = idCapril
 JOIN sensores ON fkCaprilSensor = idCapril
 JOIN dados ON fkSensores = idSensores;

 SELECT 
    cliente.nomeCliente AS Nome_Cliente, 
    cliente.telefone AS Telefone_Cliente,
    fazenda.nomeFazenda AS Nome_Fazenda, 
    fazenda.CEP AS CEP_Fazenda, 
    fazenda.numeroEnd as Numero_Endereco,
    fazenda.complemento as Complemento,
    fazenda.qtdCapris AS Qtd_Capris_Fazenda,
    caprinos.sexo AS Sexo_Caprinos, 
    caprinos.raça AS Raça_Caprinos,
    sensores.*, 
    dados.*
FROM cliente 
JOIN fazenda ON cliente.idCliente = fazenda.fkCliente
JOIN capril ON fazenda.idFazenda = capril.fkFazenda
JOIN caprinos ON capril.idCapril = caprinos.fkCapril
JOIN sensores ON capril.idCapril = sensores.fkCaprilSensor
JOIN dados ON sensores.idSensores = dados.fkSensores;


 
 

 
 






























 




