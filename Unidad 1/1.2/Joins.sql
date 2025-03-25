select
    al.nombre ||' '|| al.apaterno,
    ca.descripcion
from alumno al natural join carrera ca;

--join con using
--debemos indicar cual es el atributo que une las tablas
--los atributos se deben llamar igual
select
    al.nombre ||' '|| al.apaterno,
    ca.descripcion
from alumno al join carrera ca using(carreraid);