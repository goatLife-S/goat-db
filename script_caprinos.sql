CREATE DATABASE sprint_2;
USE sprint_2;

CREATE TABLE cliente (
idCliente int primary key auto_increment,
nomeCliente varchar(60),
sobrenome varchar(45),
telefone char(11),
email varchar(60),
senha char(8));

DESCRIBE cliente;

INSERT INTO cliente VALUES 
(default,'Fernanda','Caramico', '11234567890', 'fernandaCaramico@gmail.com', '12345678');

SELECT * FROM cliente;

CREATE TABLE fazenda (
idFazenda int primary key auto_increment,
nomeFazenda varchar(60),
CEP char(9),
numeroEnd varchar(45),
complemento varchar(45),
rzSocial varchar(45),
CNPJ char(14),
email varchar(60),
senha char(8),
telefone char(11),
fkCliente int,
constraint fkFazendaCliente foreign key (fkCliente)
references cliente (idCliente));

DESCRIBE fazenda;

INSERT INTO fazenda VALUES 
(default, 'Fazenda Feliz', '03940-010','90', 'A', 'Fazenda Feliz Ltda.', '11111111111111','fazendaFeliz@gmail.com', '12345678','11997458822',null),
(default, 'Fazenda das Cabras', '07856-080','65','', 'Fazenda das Cabras Ltda.','2222222222222','fazendaCabras@gmail.com','87654321','11988824536', null);

UPDATE fazenda SET fkCliente = 1 WHERE idFazenda = 1;
UPDATE fazenda SET fkCliente = 1 WHERE idFazenda = 2;

SELECT * FROM fazenda;

CREATE TABLE funcionario (
idFunc int primary key auto_increment,
nome varchar(45),
sobrenome varchar(45),
telefone varchar(45),
email varchar(60),
senha char(8),
fkFFazenda int,
constraint fkFuncFazenda foreign key (fkFFazenda)
references fazenda (idFazenda));

DESCRIBE funcionario;

INSERT INTO funcionario VALUES
(default, 'Josefina','Lima', '11 97862-0888', 'josefinaLimaFazenda@gmail.com', '87654321', 1),
(default, 'Jose','Lima', '11 97862-0778', 'joseLimaFazenda@gmail.com', '87000321', 2);

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
(default, 'Capril1', 'Leste de fazenda', 100, null),
(default, 'Capril2', 'Sul da fazenda', 50, null);

DESCRIBE capril;

UPDATE capril SET fkFazenda = 1 WHERE idCapril IN (1);
UPDATE capril SET fkFazenda = 2 WHERE idCapril IN (2);

SELECT * FROM capril;

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
dht11_umidade double,
dtCaptura datetime not null default current_timestamp(),
fkSensores int,
constraint fkTempSensor foreign key (fkSensores)
references sensores (idSensores));

SELECT * FROM medida;

-- SELECT DOS DAODS DO CLIENTE E DOS DADOS DE TODAS AS FAZENDAS

SELECT * FROM cliente JOIN fazenda ON fkCliente = idCliente
 JOIN capril ON fkFazenda = idFazenda;
 
 -- SELECT DOS DADOS DO CLIENTE, FAZENDA, FUNCIONÁRIO E APENAS DOS CAPRIS QUE POSSUEM O MONITORAMENTO
 
 SELECT * FROM cliente JOIN fazenda ON fkCliente = idCliente
 JOIN funcionario ON fkFFazenda = idFazenda
 JOIN capril ON fkFazenda = idFazenda 
 JOIN sensores ON fkCaprilSensor = idCapril
 LEFT JOIN medida ON fkSensores = idSensores;    

 SELECT 
    cliente.nomeCliente AS Nome_Cliente,
    cliente.sobrenome AS Sobrenome_Cliente,
    cliente.telefone AS Telefone_Cliente,
    cliente.email AS Email_Cliente,
    fazenda.nomeFazenda AS Nome_Fazenda, 
    fazenda.CEP AS CEP_Fazenda, 
    fazenda.numeroEnd as Numero_Endereco,
    fazenda.complemento as Complemento,
    fazenda.rzSocial as Razão_Social,
    fazenda.CNPJ as CNPJ,
    fazenda.email as Email,
    fazenda.senha as Senha,
    fazenda.telefone as Telefone,
    funcionario.nome as Nome_Funcionario,
    funcionario.sobrenome as Sobrenome, 
    funcionario.telefone as Telefone,
    funcionario.email as Email,
    funcionario.senha as Senha,
    sensores.*, 
    medida.*
FROM cliente 
JOIN fazenda ON cliente.idCliente = fazenda.fkCliente
JOIN capril ON fazenda.idFazenda = capril.fkFazenda
JOIN sensores ON capril.idCapril = sensores.fkCaprilSensor
JOIN funcionario ON fazenda.idFazenda = funcionario.fkFFazenda
LEFT JOIN medida ON sensores.idSensores = medida.fkSensores;


 
 

 
 






























 




