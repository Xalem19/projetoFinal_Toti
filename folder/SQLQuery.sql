------ CONSULTAS, XAVIER---------------------------------------------------------

-- Informação geral das consultas realizadas no segundo trimestre

SELECT 
de.Name as 'Serviço',
Ph.EmployeeID as 'Código do Médico', 
Ph.Name as 'Médico',  
Ap.AppointmentID as 'Código da Consulta',
Ap.Patient as 'Código do paciente',
Ap.PrepNurse as' Enfermeira',
Ap.ExaminationRoom as 'Sala de Avaliação',
Convert(NVARCHAR, Ap.Starto, 23) AS 'Data'
Into Consulta_geral      -- Nome de minha nova tabela, vai ser criada com esta consulta
FROM Appointment as Ap 
Join Physician as Ph ON Ph.EmployeeID = Ap.Physician  
Join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department
Order by Data;


SELECT -- selecionamos o nome das colunas que queremos, usamos o 'AS' para renomear a coluna. 
de.Name as 'Serviço', -- Nome da tabela Departamento
Ph.EmployeeID as 'Código do Médico', -- Codigo do Médico na tabela Physician (Médico)
Ph.Name as 'Médico',  -- Nome do médico da tabela Physician
Ap.AppointmentID as 'Código da Consulta', -- Código da Tabel Appointement (Consultas)
Ap.Patient as 'Código do paciente',
Ap.PrepNurse as' Enfermeira',
Ap.ExaminationRoom as 'Sala de Avaliação',
Ap.Starto AS 'Data'
FROM Appointment as Ap 
Join Physician as Ph ON Ph.EmployeeID = Ap.Physician  
Join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department
WHERE month(Ap.Starto)= 6
ORDER BY Data;


 --- Consultas por serviço

SELECT 
de.name as 'Serviço',
COUNT(de.name) as 'Quantidade total 2do trim.' -- Queremos uma columna com o total das consultas, contamos pelo nome do departamento
from Appointment as Ap
Join Physician as Ph ON Ph.EmployeeID = Ap.Physician 
Join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department
Group by de.name -- Agrupamos pelo nome do departamento
order by 'Quantidade total 2do trim.' desc;

--Total de consultas 
SELECT 
COUNT(de.name) as 'Quantidade total 2do trim.' -- Queremos uma columna com o total das consultas, contamos pelo nome do departamento
from Appointment as Ap
Join Physician as Ph ON Ph.EmployeeID = Ap.Physician 
Join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department

-- Agrupamos pelo nome do departamento

---Consultas abril

SELECT 
de.Name as 'Departamento',
COUNT(de.name) as 'N° Consultas Abril'
FROM Appointment as Ap
Join Physician as Ph ON Ph.EmployeeID = Ap.Physician 
Join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department
where MONTH(Ap.Starto)= 4 
Group by de.Name
Order by 'N° Consultas Abril' desc;

---Consultas Maio

SELECT 
de.Name as 'Departamento',
COUNT(de.name) as 'N° Consultas Maio'
FROM Appointment as Ap
Join Physician as Ph ON Ph.EmployeeID = Ap.Physician 
Join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department
where MONTH(Ap.Starto)= 5 
Group by de.Name
Order by 'N° Consultas Maio' desc;

---Consultas Junho

SELECT 
de.Name as 'Departamento',
COUNT(de.name) as 'N° Consultas Junho'
FROM Appointment as Ap
Join Physician as Ph ON Ph.EmployeeID = Ap.Physician 
Join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department
where MONTH(Ap.Starto)= 6 
Group by de.Name
Order by 'N° Consultas Junho' desc;


-- Consultas psiquiatricas por paciente

 select pa.SSN as 'Paciente', count(Ap.AppointmentID) as 'Consultas Psiquiatricas'
 from Patient as pa
  join Appointment as AP ON Ap.Patient = pa.SSN
Where Ap.Physician = 9 
group by pa.ssn
ORDER BY 'Consultas Psiquiatricas' desc;


----------CONSULTAS, AMBAR ------------------------------------------------------------

--iNFORMAÇÃO GERAL DE MEDICAMENTOS PRESCRITOS JUNTANDO A DESCRIÇÃO DO MEDICAMENTO, NOME DO PACIENTE, NOME DO MÉDICO E
-- O SERVIÇO OA QUAL ESTÁ AFILIADO 

SELECT
pac.name as 'Paciente',
ph.name as 'Médico', 
ph.Position as 'Cargo',
de.name as 'Serviço',
Med.Name as 'Nome do medicamento', 
Med.Description AS 'Descrição', 
datename (mm, pre.Date) 'Data'
into Consulta_pres  ---- Nome da nova tabela
FROM Prescribes as pre  
Join Patient as pac on pac.SSN = pre.Patient 
join Medication as med on med.Code = pre.Medication 
join Physician as ph on ph.EmployeeID = pre.Physician
join Affiliated_With as af on af.Physician = Ph.EmployeeID 
join Department as de ON de.DepartmentID = af.Department
order by Data asc; -- Organizamos a tabela pelo nome do médico

 select * from Consul_pres
-- Medicamentos recetados por procedimiento
SELECT 
pr.name as 'Procedimento',
CONVERT(NVARCHAR,u.DateUndergoes, 22) as 'Data', 
med.name as 'Medicamento',
ph.name as 'Nome do Médico',
pt.name AS 'Nome do Paciente'
into Consul_pres_proce
FROM Medication AS med 
JOIN Prescribes AS p ON p.medication = med.code
JOIN Physician as ph ON ph.EmployeeID = p.Physician
JOIN Patient as pt ON pt.SSN = p.Patient
JOIN Undergoes as u on u.Physician = ph.EmployeeID
JOIN Procedures as pr ON pr.code = u.procedures
ORDER BY pt.name;

--Cantidad de medicamento recetados
select 
medicat.Name as 'Medicamento',
COUNT(presc.Medication) AS 'Quantidade de veces Recetado'
into Consul_Medicamentos
 from Medication as medicat
 JOIN Prescribes as presc on presc.Medication = medicat.Code
 Group by medicat.Name 
 ORDER BY COUNT (presc.Medication) DESC;

 select 
medicat.Description AS 'Tipo de Medicamento',
COUNT() AS 'Recetado'
 from Medication as medicat
 JOIN Prescribes as presc on presc.Medication = medicat.code
 GROUP BY medicat.Description
 ORDER BY COUNT () DESC;

----------------consultas, wendell-----------

SELECT 
pro.Name AS 'Procedimento Cirúrgico',
COUNT(pro.Name) as 'Quantidades realizadas 2do trim.'
FROM Undergoes AS un 
JOIN Procedures AS pro ON pro.Code = un.Procedures
Group by pro.Name
ORDER BY 'Quantidades realizadas 2do trim.'desc;


SELECT
pro.name AS 'Procedimento Cirúrgico', --Nesta Busqueda começamos analisando a tabela
Sum(pro.Cost) AS 'Valor Total 2do trim.' 
FROM Undergoes AS un --procedimentos para conhecer os valores gerais.
JOIN Procedures AS pro ON pro.Code = un.Procedures  --Logo realizei um JOIN para unir as tabelas 
GROUP BY pro.Name
order by 'Valor Total 2do trim.' desc; --todas os procedimentos aplicados no trimestre


SELECT n.name AS 'Enfermeira',
p.Name AS Procedimento, 
p.Cost AS 'Valor do procedimento',
s.salarynurse AS Comissão,
datename (mm, U.DateUndergoes) as 'Mês'
FROM Undergoes AS U 
JOIN Nurse As n ON n.EmployeeID = U.AssistingNurse
JOIN Procedures AS p ON p.Code = U.Procedures
JOIN Salary As s ON s.codeprocedure = p.code
Order by 'Mês';

-- Procedimento cirúrgico por mês com o lucro. 
-- Fizemos um calculo dentro da consultas, tirando do costo do procedimento o valor de comissão que ganha o médico e a enfermeira

SELECT 
p.name as 'Procedimento Cirúrgico', 
Datename(Month, u.DateUndergoes) AS 'Mês',
(p.cost - (s.salaryphysician + s.salarynurse)) as 'Lucro'
FROM Procedures AS p
JOIN Salary As s ON s.CodeProcedure = p.Code
join Undergoes as u ON u.Procedures = p.Code
Order by Mês asc;

--------------------LUZ----------------------
select *
from Appointment;

select * from Procedures;

Select * From Undergoes;

SELECT u.Patient, 
FROM Undergoes AS U

Select 
 COUNT(s.Room) as Veces,
 B.BlockFloor
FROM Block as B 
join Room as r on r.BlockFloor = B.BlockFloor
join stay as s on s.Room = r.RoomNumber;

SELECT u.Patient, u.Stay, u.Physician, pro.Name,u.DateUndergoes
FROM Patient as p 
Join Stay as s on s.Patient = p.SSN
Join Undergoes as u on u.Stay = s.StayID
Join Procedures as pro on pro.Code = u.Procedures;

select * from Prescribes
Order by Stay;

select Ap.Patient, s.StayID, Ap.Starto, s.StayStart
FROM Appointment as Ap 
Join Patient as pa ON pa.SSN = Ap.Patient
Join Stay as s on s.Patient = pa.SSN
order by Ap.Starto;


select u.Patient, s.StayID, s.StayStart, s.StayEnd,u.DateUndergoes, u.Physician, U.Procedures, pro.Name
FROM Patient as p
Join Stay as s on s.Patient = p.SSN
Join Undergoes as u ON u.Stay = s.StayID
Join Procedures as pro on pro.Code = u.Procedures;

 --------------------------------------------------------------------

 Select Med.Description, string_agg(Med.Name, ',') as Medicamentos
 FROM Medication as Med
 group by Med.Description

select 
pa.SSN as 'Paciente', string_agg(Ap.AppointmentID, '/ /') as 'ID Appointment',
count(Ap.AppointmentID) as 'Consultas',
 string_agg(Ap.Starto, '/ /') as 'Datas'
from Patient as pa
join Appointment as Ap On Ap.Patient = pa.SSN
group by pa.SSN

select DISTINCT
pa.SSN as 'Paciente',
Count(s.Patient) as 'Hospitalização'
from Patient as pa
join Stay as S on s.Patient = pa.SSN
group by pa.SSN


select pa.SSN as Paciente, 
string_agg(s.StayID, '/ /') as 'Código',
count(s.StayID) as 'N° de internações', 
string_agg(s.StayStart, '/ / ') AS Data
from Patient as pa
Join Stay as s On s.Patient = pa.SSN
group by pa.SSN;

select * from stay 
where Patient = '100000001';


-------------------- Consultas, Luz-------------------------------------

/*Quantidade de Habitaçoes*/
select count (Room.RoomNumber)from Room;

/*Quantidade de  Habitaciones indisponibles para el uso*/

select count (Room.RoomNumber)
from Room 
where Unavailable = 1;

/*Descrição de  Habitaciones indisponibles para el uso*/

select Room.BlockFloor as 'Andar',Room.RoomNumber as 'Numero', Room.RoomType as 'Tipo'
from Room 
where Unavailable = 1

/*Ocupação da area de internação por mes*/

select count(Stay.StayID) as 'Pacientes Internados em abril'
from Stay
where MONTH(Stay.StayStart)= 4 ;


select count(Stay.StayID) as 'Pacientes Internados em Maio'
from Stay
where MONTH(Stay.StayStart)= 5 ;

select count(Stay.StayID) as 'Pacientes Internados em Junho'
from Stay
where MONTH(Stay.StayStart)= 6 ;

/*Total de pacientes internados no 2°do trimestre*/

select count(Stay.StayID) from Stay;

 /*Pacientes que estan en Habitaciones indisponibles por mes*/

SELECT Stay.StayID, Stay.Room,Stay.StayStart, Room.Unavailable
	FROM Stay
	inner join Room On Stay.Room = Room.RoomNumber and Room.Unavailable = 1
	where MONTH(Stay.StayStart)= 4;

SELECT Stay.StayID, Stay.Room,Stay.StayStart, Room.Unavailable
	FROM Stay
	inner join Room On Stay.Room = Room.RoomNumber and Room.Unavailable = 1
	where MONTH(Stay.StayStart)= 5;

SELECT Stay.StayID, Stay.Room,Stay.StayStart, Room.Unavailable
	FROM Stay
	inner join Room On Stay.Room = Room.RoomNumber and Room.Unavailable = 1
	where MONTH(Stay.StayStart)= 6;

	Select * from ConsultaTeste

select s.StayID, s.Patient,s.Room,s.StayStart, r.Unavailable 
from Stay as s
join Room as r on s.Room= r.RoomNumber
where r.Unavailable= 1 ;

SELECT * From Patient where PCP = 9;
SELECT * From Patient