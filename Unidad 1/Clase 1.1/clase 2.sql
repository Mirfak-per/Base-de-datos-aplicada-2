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
    dual;

/*Guia 1*/

SELECT
    numrun_cli||'-'||dvrun_cli "RUN Cliente",
    LOWER(pnombre_cli||' '||snombre_cli)||' '||
    appaterno_cli||' '||apmaterno_cli "NOMBRE COMPLETO CLIENTE",
    to_CHAR(fecha_nac_cli,'DD/MM/YYYY') "Fecha_Nacimiento"
FROM CLIENTE
WHERE EXTRACT(day from fecha_nac_cli) = extract(day from sysdate+1) and 
        extract(month from fecha_nac_cli)=extract(month from sysdate+1)
order by appaterno_cli ASC;

Select
    numrun_emp||' '||dvrun_emp "Run Empleado",
     pnombre_emp|| ' '||snombre_emp||' '|| appaterno_emp||' '|| apmaterno_emp "Nombre Empleado",
     sueldo_base "Sueldo Base",
     trunc(sueldo_base/100000) "porcentaje de movilizacion",
     trunc(Trunc(sueldo_base/100000)/100*sueldo_base) "valor movilizacion"
from empleado
order by trunc(sueldo_base/100000) desc;


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
