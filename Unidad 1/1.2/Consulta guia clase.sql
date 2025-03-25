savepoint Gabriel;

select 
    tituloid "CODIGO DEL LIBRO",
    COUNT(*) "TOTAL DE VECES SOLICITADO",
    CASE
        when count(*) =1 then 'No se requiere nuevos ejemplares'
        when count(*) between 2 and 3 then 'Se requieren comprar 1 ejemplar nuevo'
        when count(*) between 4 and 5 then 'Se requieren comprar 2 nuevos ejemplares'
        when count(*) >5 then 'Se requieren comprar 4 nuevos ejemplares'
    END "SUGERENCIA"
from prestamo
where extract(year from fecha_ini_prestamo) = extract(year from sysdate)-1
group by tituloid
order by 2 desc;