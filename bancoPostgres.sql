
create dataBase ReservaDeSala;
-- Tabela Usuario
CREATE TABLE Usuario (
    idUsuario SERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    senha VARCHAR(60) NOT NULL,
    tipoUsuario VARCHAR(60) NOT NULL
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
    idFuncionario SERIAL PRIMARY KEY,
    nomeCargo VARCHAR(60) NOT NULL,
    nomeFuncionario VARCHAR(60) NOT NULL,
    cpfFuncionario VARCHAR(15) NOT NULL
);

-- Tabela Chave
CREATE TABLE Chave (
    idChave SERIAL PRIMARY KEY,
    nomeSala VARCHAR(60) NOT NULL,
    disponivel BOOLEAN NOT NULL
);

-- Tabela Reservas
CREATE TABLE Reservas (
    idReserva SERIAL PRIMARY KEY,
    idFuncionario INT NOT NULL,
    idChave INT NOT NULL,
    dataDeReserva VARCHAR(20),
    dataEntrega VARCHAR(20),
    horaReserva VARCHAR(20),
    horaEntrega VARCHAR(20),
    entregue BOOLEAN NOT NULL,
    FOREIGN KEY (idChave) REFERENCES Chave(idChave),
    FOREIGN KEY (idFuncionario) REFERENCES Funcionario(idFuncionario)
);

CREATE TABLE IF NOT EXISTS tabelaReservasInfo (
    idFuncionario INT NOT NULL,
    nomeFuncionario VARCHAR(255) NOT NULL,
    nomeSala VARCHAR(255) NOT NULL,
    disponibilidade VARCHAR(255) NOT NULL,
    horaReserva VARCHAR(255) NOT NULL,
    horaEntrega VARCHAR(255) NOT NULL,
    entregue BOOLEAN NOT NULL
);

--drop table  tabelaReservaInfo;
ALTER TABLE tabelaReservaInfo
ADD COLUMN entregue BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE tabelaReservaInfo
ADD COLUMN disponibilidade VARCHAR(255) NOT NULL DEFAULT false;



-- Tabela selecaoChavesFuncionario
CREATE TABLE selecaoChavesFuncionario (
    idSelecao SERIAL PRIMARY KEY,
    idFuncionario INT NOT NULL,
    idChave INT NOT NULL,
    periodo VARCHAR(20),
    FOREIGN KEY (idChave) REFERENCES Chave(idChave),
    FOREIGN KEY (idFuncionario) REFERENCES Funcionario(idFuncionario)
);
--ç
-- View SelecaoDetalhes
CREATE VIEW SelecaoDetalhes AS
SELECT
    f.nomeFuncionario,  -- Nome do funcionário
    c.nomeSala,         -- Nome da chave (sala)
    s.periodo           -- Período da seleção
FROM 
    selecaoChavesFuncionario s
JOIN 
    Funcionario f ON s.idFuncionario = f.idFuncionario
JOIN 
    Chave c ON s.idChave = c.idChave;
drop VIEW SelecaoDetalhes;

-- View SelecaoDetalhes
CREATE VIEW SelecaoDetalhes AS
SELECT
    f.idfuncionario,
	c.idchave,
    f.nomeFuncionario,  
    c.nomeSala,         
    s.periodo,
    f.cpfFuncionario         
FROM 
    selecaoChavesFuncionario s
JOIN 
    Funcionario f ON s.idFuncionario = f.idFuncionario
JOIN 
    Chave c ON s.idChave = c.idChave;


	

-- View ReservaDetalhes
CREATE VIEW ReservaDetalhes AS
SELECT
    r.idReserva,
    f.nomeFuncionario, 
    c.nomeSala,
    r.dataDeReserva,
    r.horaReserva,
    r.entregue
FROM 
    Reservas r
JOIN 
    Funcionario f ON r.idFuncionario = f.idFuncionario
JOIN 
    Chave c ON r.idChave = c.idChave;

-- Inserindo dados de teste
INSERT INTO Funcionario (nomeCargo, nomeFuncionario, cpfFuncionario)
VALUES
('Gerente', 'Carlos Silva', '12345678901'),
('Assistente', 'Maria Oliveira', '23456789012'),
('Coordenador', 'João Santos', '34567890123'),
('Analista', 'Patrícia Costa', '45678901234'),
('Diretor', 'Rafael Almeida', '56789012345');

INSERT INTO Chave (nomeSala, disponivel)
VALUES
('Sala 101', TRUE),
('Sala 102', TRUE),
('Sala 103', FALSE),
('Sala 104', TRUE),
('Sala 105', TRUE);

INSERT INTO Reservas (idFuncionario, idChave, dataDeReserva, horaReserva, horaEntrega, entregue)
VALUES
(1, 3, '2024-12-12', '09:00', '11:00', TRUE), 
(2, 4, '2024-12-12', '14:00', '16:00', FALSE);

INSERT INTO selecaoChavesFuncionario (idFuncionario, idChave, periodo)
VALUES
(1, 2, '08:00 - 12:00'),
(3, 4, '13:00 - 17:00'),
(5, 1, '09:00 - 12:00');

DELETE FROM selecaoChavesFuncionario WHERE idSelecao = 3;

-- Consultas para verificar os dados
SELECT * FROM Chave;
SELECT * FROM Usuario
;
SELECT * FROM Funcionario;
SELECT * FROM ReservaDetalhes;

SELECT * FROM SelecaoDetalhes;
