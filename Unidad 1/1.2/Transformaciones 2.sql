
/*Transformacion implicita y explicita*/


/* Funciones de transformacion
to_number: transformar texto en numero
to_date: transformar texto en fecha
to_char: transformar fecha y numero a texto
*/

select 
    '10' +5"Implicita",
    to_number('10') + 5 "explicita"
from dual;

select
    to_date('01/10/2024') "transformacion simple",
    to_date('2024/10/01','YYYY/DD/MM') "formato"
from dual;

select
    150000.05 "valor original",
    to_char(150000.05,'999999999D99') "forma 1",
    to_char(150000.05, '999,999,999.99') "forma 2",
    to_char(150000.05,'000G000G000D00') "forma 3",
    to_char(150000.05, '$9999G999') "forma 4",
    to_char(150000.05, 'L999G999') "forma5"
from dual;    

select
    sysdate "fecha actual",
    to_char(sysdate,'DD/MM/YYYY') "Forma 1",
    to_char(sysdate,'yyyy/MM/DD') "Forma 2",
    to_char(sysdate,'fmday DD "de" month "del" YYYY') "Forma 3",
    to_char(sysdate,'YYYY') "Forma 4",
    to_char(sysdate,'YYYY/MM/DD hh:mm:ss') "Forma 1"
from dual;

/*NVL manejo de valores nulos*/
select
autorid "ID",
nombre "NOMBRE",
NVL(apellidos,'SIN APELLIDO') "APELLIDO"
from autor;

select
    NVL(multa,0) "MUlTA",
    nvl(to_char(multa),'SIN MULTA') "mutla con texto"
from prestamo;

select
    carreraid "id carrera",
    count(carreraid) "cantidad de alumnos",
    'le corresponden' ||
    to_char(count(*)*&Valor,'$999G999')||' del presupuesto anual asignado' "monto por publicidad"
from alumno group by carreraid order by 2 desc, 1 asc;

select
    carreraid "id carrera",
    count(carreraid) "cantidad de alumnos"
from alumno 
having count(*)>4
group by carreraid
order by carreraid;
--having = where pero con funciones de grupo

select
    to_char(run_jefe,'999G999G999') "RUT JEFE SIN DV",
    count(*) "CANTIDAD DE EMPLEADOS",
    TO_char(max(salario),'$999G999G999') "SALARIO MAXIMO",
    lpad(count(*)*10 || '% Del Salario Maximo',20,' ') "Porcentaje de bonificacion",
    to_char(max(salario)* (count(*)/10),'$999G999G999') "Bonificacion"
from empleado
where run_jefe is not null
group by run_jefe order by 2 ;
