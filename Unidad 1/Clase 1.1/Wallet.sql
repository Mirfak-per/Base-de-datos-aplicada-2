CREATE TABLE Cliente (
    rut INT PRIMARY KEY,
    nombre VARCHAR2 (50) not null
);

SELECT * from CLIENTE;

SELECT * FROM EMPLEADO;

--Funcion de una linea

SELECT 
    PNOMBRE_EMP "Original",
    LOWER(PNOMBRE_EMP) "Minuscula",
    upper(PNOMBRE_EMP) "Mayuscula",
    initcap(pnombre_emp) "PRIMERA MAYÚSCULA",
    length(PNOMBRE_EMP) "LARGO",
    substr(PNOMBRE_EMP,1,2) "CORTAR",
    SUBSTR(PNOMBRE_EMP,-2,2) "CORTAR DESDE ATRAS",
    TRIM('   RODO LFO   ') "LIMPIAR ESPACIOS EN BLANCO", --LTRIM Y RTRIM PAR BORRAR LA DERECHA O IZQUIERDA
    INSTR(PNOMBRE_EMP, 'A') "BUSCAR A",
    LPAD(PNOMBRE_EMP,15,' ') "LPAD"
FROM EMPLEADO;