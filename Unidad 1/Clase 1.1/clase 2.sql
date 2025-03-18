--Funcion de una linea

SELECT
    pnombre_emp                "Original",
    lower(pnombre_emp)         "Minuscula",
    upper(pnombre_emp)         "Mayuscula",
    initcap(pnombre_emp)       "PRIMERA MAYÚSCULA",
    length(pnombre_emp)        "LARGO",
    substr(pnombre_emp, 1, 2)  "CORTAR",
    substr(pnombre_emp, -2, 2) "CORTAR DESDE ATRAS",
    TRIM('   RODO LFO   ')     "LIMPIAR ESPACIOS EN BLANCO", --LTRIM Y RTRIM PAR BORRAR LA DERECHA O IZQUIERDA
    instr(pnombre_emp, 'A')    "BUSCAR A",
    lpad(pnombre_emp, 15, ' ') "LPAD"
FROM
    empleado;

/*Funciones de fecha*/

SELECT
    pnombre_emp
    || ' '
    || appaterno_emp                                    "Nombre Empleado",
    fecha_contrato                                      "FECHA EMPLEADOS",
    trunc(months_between(sysdate, fecha_contrato) / 12) "Años antiguedad",
    next_day(fecha_contrato, 'LUNES')                   "DIA SIGUENTE",
    add_months(fecha_contrato, 3)                       "Agrear meses",
    last_day(fecha_contrato)                            "ULTIMO DIA DEL MES",
    EXTRACT(YEAR FROM fecha_contrato)                   "AÑO",
    EXTRACT(MONTH FROM fecha_contrato)                  "MES",
    EXTRACT(DAY FROM fecha_contrato)                    "DIA"
FROM
    empleado;

/*Funciones de NUMERO*/

SELECT
    1234.5             "VALOR",
    round(1234.56)     "REDONDEO",
    trunc(1234.56)     "TRUNCAR",
    round(1234.56, 1)  "REDONDEO CON 1 DECIMAL",
    trunc(1234.56, 1)  "TRUNCAR CON 1 DECIMAL",
    round(1234.56, -1) "REDONDEAR HACIA EL ENTERO",
    trunc(1234.56, -1) "TRUBCAR HACIA EL ENTERO"
FROM
    dual;--tabla para probar datos

/*Guia 1*/


--caso 1
SELECT
    numrun_cli||'-'||dvrun_cli "RUN Cliente",
    LOWER(pnombre_cli||' '||snombre_cli)||' '||
    appaterno_cli||' '||apmaterno_cli "NOMBRE COMPLETO CLIENTE",
    to_CHAR(fecha_nac_cli,'DD/MM/YYYY') "Fecha_Nacimiento"
FROM CLIENTE
WHERE EXTRACT(day from fecha_nac_cli) = extract(day from sysdate+1) and 
        extract(month from fecha_nac_cli)=extract(month from sysdate+1)
order by appaterno_cli ASC;


--caso 2
Select
    numrun_emp||' '||dvrun_emp "Run Empleado",
     pnombre_emp|| ' '||snombre_emp||' '|| appaterno_emp||' '|| apmaterno_emp "Nombre Empleado",
     sueldo_base "Sueldo Base",
     trunc(sueldo_base/100000) "porcentaje de movilizacion",
     trunc(Trunc(sueldo_base/100000)/100*sueldo_base) "valor movilizacion"
from empleado
order by trunc(sueldo_base/100000) desc;


--caso 3
Select
    numrun_emp||' '||dvrun_emp "Run Empleado",
    numrun_emp||' '||dvrun_emp "Run Empleado",
     pnombre_emp|| ' '||snombre_emp||' '|| appaterno_emp||' '|| apmaterno_emp "Nombre Empleado",
     sueldo_base "SUELDO BASE",
     fecha_nac "FECHA NACIMIENTO",
     substr(pnombre_emp,1,3)||length(pnombre_emp) ||'*'|| substr(sueldo_base,-1,1)||dvrun_emp||Round(months_between(sysdate, fecha_contrato) / 12) "Nombre Usuario",
    substr(numrun_emp,3,1)||extract( year from fecha_contrato)+2||substr(sueldo_base,-3,3)-1||substr(appaterno_emp,-2,2)||8 "Clave"--Extract(month from sysdate) 
From empleado
order by appaterno_emp asc;

--caso 4

SELECT 
    EXTRACT(YEAR FROM SYSDATE) "Año de Proceso",
    nro_patente "Patente",
    valor_arriendo_dia "Valor Arriendo Dia SR",
    valor_garantia_dia "Valor Garantía Dia SR",
    EXTRACT(YEAR FROM SYSDATE) - anio "ANNOS de antiguedad",
    trunc(valor_garantia_dia * (1 - ((EXTRACT(YEAR FROM SYSDATE) -anio) / 100))) "Valor Garantía Dia CR",
    trunc(valor_arriendo_dia * (1 - ((EXTRACT(YEAR FROM SYSDATE) - anio) / 100))) "Valor Arriendo Dia CR"
FROM CAMION
WHERE (EXTRACT(YEAR FROM SYSDATE) - anio) > 5
ORDER BY (EXTRACT(YEAR FROM SYSDATE) - anio) DESC, nro_patente ASC;

--caso 5

SELECT 
    TO_CHAR(sysdate, 'MM/YYYY') "Fecha Inicio Proceso",
    nro_patente "Patente",
    TO_CHAR(fecha_ini_arriendo, 'DD/MM/YYYY') "Fecha Inicio Arriendo",
    dias_solicitados "Días de Arriendo",
    TO_CHAR(fecha_devolucion, 'DD/MM/YYYY') "Fecha Devolución",
    TRUNC(fecha_devolucion) - (TRUNC(fecha_ini_arriendo) + dias_solicitados) "Días Atraso",
    ((TRUNC(fecha_devolucion) - (TRUNC(fecha_ini_arriendo) + dias_solicitados)) * &VALOR_MULTA) "Multa Total"
FROM ARRIENDO_CAMION
WHERE EXTRACT(YEAR FROM fecha_devolucion) = EXTRACT(YEAR FROM ADD_MONTHS(sysdate, 1))
AND EXTRACT(MONTH FROM fecha_devolucion) = EXTRACT(MONTH FROM ADD_MONTHS(sysdate, 1))
AND fecha_devolucion > (fecha_ini_arriendo + dias_solicitados)
ORDER BY fecha_ini_arriendo ASC, nro_patente ASC;




--caso 6
SELECT 
    TO_CHAR(SYSDATE, 'MM/YYYY') "Fecha Proceso",
    to_char(numrun_emp,'99G999G999')||'-'||dvrun_emp "RUN Empleado",
    pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp "Nombre Empleado",
    to_CHar(sueldo_base,'L999G999G999') "Sueldo Base", 
    Case --if
        when sueldo_base between 320000 and 450000 then to_char(0.05*&&Valor,'L999G999G999')
        when sueldo_base between 450001 and 600000 then to_char(0.035*&&Valor,'L999G999G999')
        when sueldo_base between 600001 and 900000 then to_char(0.025*&&Valor,'L999G999G999')
        when sueldo_base between 900001 and 1800000 then to_char(0.015*&&Valor,'L999G999G999')
        when sueldo_base > 1800000 then to_char(0.001*&&Valor,'L999G999G999')
    end    "Bonificacion por utilidades"
FROM EMPLEADO
WHERE sueldo_base > 900000
ORDER BY appaterno_emp;
UNDEFINE Valor; --limpia valores &&
--- TO_CHAR(atributo_numerico, 'L999G999G999D99') D= decimales
--L = moneda local
--G= punto
-- 9 = Muestra los numeros que tiene
-- 0 = rellena con 0 lo faltante

/*Funciones de Grupo*/

--Count: Contar
--sum: sumar
--avg: promedio
--max: maximo
--min: minimo


Select 
    Count(sueldo_base) "Contador",
    Sum(Sueldo_Base) "Suma",
    round(avg(sueldo_base)) "Promedio",
    max(sueldo_base) "Maximo",
    min(sueldo_base) "minimo"
From Empleado;

--group by: permite agrupar por uno o mas atributos
Select
    sexo,
    Count(*) "cantidad",
    sum(sueldo_base) "suma",
    round(avg(sueldo_Base)) "promedio"
From empleado
Group By sexo;


Select 
    id_tipo_cli "tipo CLiete",
    count(*) "cantidad"
from cliente
group by id_tipo_cli
order by 2 desc;

