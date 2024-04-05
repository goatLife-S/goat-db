USE sprint_2;

CREATE TABLE cliente (
idCliente int primary key auto_increment,
nomeCliente varchar(60),
telefone char(11),
email varchar(60));

DESCRIBE cliente;

CREATE TABLE fazenda (
idFazenda int primary key auto_increment,
nomeFazenda varchar(60),
endereco varchar(90),
qtdCapris int,
fkCliente int,
constraint fkFazendaCliente foreign key (fkCliente)
references cliente (idCliente));

DESCRIBE fazenda;

CREATE TABLE capril (
idCapril int primary key auto_increment,
nomeCapril varchar(45),
localizacao varchar(45),
capacidade_max int,
fkFazenda int,
constraint fkCaprilFazenda foreign key (fkFazenda)
references fazenda (idFazenda));

DESCRIBE capril;

CREATE TABLE caprinos (
idCaprinos int primary key auto_increment,
sexo char(5),
raça varchar(45),
fkCapril int,
constraint fkCaprinosCapril foreign key (fkCapril)
references capril (idCapril));

DESCRIBE caprinos;

CREATE TABLE sensores (
idSensores int primary key auto_increment,
nomeSensor varchar(45),
tipoSensor varchar (45),
fkCapril int,
constraint fkSensoresCapril foreign key (fkCapril)
references capril (idCapril));

DESCRIBE sensores;

CREATE TABLE dadosTemperatura (
idDadosTemp int primary key auto_increment,
tempAmbiente int,
fkSensores int,
constraint fkTempSensor foreign key (fkSensores)
references sensores (idSensores));

DESCRIBE dadosTemperatura;

CREATE TABLE dadosUmidade (
idDadosUmidade int primary key auto_increment,
umidadeAmbiente int,
fkSensores int,
constraint fkUmidadeSensor foreign key (fkSensores)
references sensores (idSensores));

DESCRIBE dadosUmidade;



























 




