/* 

    1. Visualizar iniciales de un nombre
    
            • Crea un bloque PL/SQL con tres variables VARCHAR2:
                o Nombre
                o apellido1
                o apellido2
            
            • Debes visualizar las iniciales separadas por puntos.
            
            • Además siempre en mayúscula
            
            • Por ejemplo alberto pérez García debería aparecer--> A.P.G

*/

DECLARE 
    nombre VARCHAR2(50);
    apellido1 VARCHAR2(50);
     apellido2 VARCHAR2(50);
    iniciales varchar(10);
    
BEGIN
    nombre := 'Isai';
    apellido1 := 'Salgado';
    apellido2 := 'Davila';
    
    iniciales := SUBSTR(nombre,1,1)||'.'||SUBSTR(apellido1,1,1)
    ||'.'||SUBSTR(apellido2,1,1);
    DBMS_OUTPUT.PUT_Line(upper(iniciales));
    
end;

set SERVEROUTPUT ON;



/*

    2. Debemos hacer un bloque PL/SQL anónimo, donde declaramos una variable
        NUMBER la variable puede tomar cualquier valor. Se debe evaluar el valor y
        determinar si es PAR o IMPAR
            • Como pista, recuerda que hay una función en SQL denominada MOD, que
            permite averiguar el resto de una división. Por ejemplo MOD(10,4) nos
            devuelve el resto de dividir 10 por 4.

*/

DECLARE 
    valor number;
    resultado number;
    
BEGIN 
    valor := 5;
    resultado := mod(valor,2);
    
    if resultado = 0 then 
        dbms_output.put_line('par');
    else 
        dbms_output.put_line('impar');
    end if;
end;    


/*
DECLARE 
    salario_max employees.salary%type
Begin
    select department max(salary) into salario_max
    from employees
    where department_id = 100;
    DBMS_OUTPUT.PUT_LINE('El Maximo Salario del Departamento es:' || salario_max );
END;
*/

/* 
    3. Crear un bloque PL/SQL que devuelva al salario máximo del departamento 100 y lo
       deje en una variable denominada salario_maximo y la visualice

*/

DECLARE

salario_max EMPLOYEES.SALARY%TYPE;

BEGIN

    SELECT MAX(SALARY) INTO salario_max FROM EMPLOYEES  WHERE DEPARTMENT_ID=100;
    
    DBMS_OUTPUT.PUT_LINE('el salario máximo de ese departamento es:'||salario_max);

END;

/*

    4. Crear una variable de tipo DEPARTMENT_ID y ponerla algún valor, por ejemplo 10.
    Visualizar el nombre de ese departamento y el número de empleados que tiene.
    Crear dos variables para albergar los valores.

*/

DECLARE
    codigo DEPARTMENTS.DEPARTMENT_ID%TYPE:=10;
    nombre DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    numero_empleado NUMBER;
BEGIN
    SELECT DEPARTMENT_NAME INTO nombre FROM DEPARTMENTS WHERE DEPARTMENT_ID=codigo;
    SELECT COUNT(*) INTO numero_empleado FROM EMPLOYEES WHERE DEPARTMENT_ID=codigo;
    DBMS_OUTPUT.PUT_LINE('El departamento' ||nombre|| ' tiene '||numero_empleado|| 'EMPLEADOS');
END;

/* 

    5. Mediante dos consultas recuperar el salario máximo y el salario mínimo de la
    empresa e indicar su diferencia

*/



DECLARE
    salario_maximo NUMBER;
    salario_minimo NUMBER;
    diferencia NUMBER;
BEGIN
    SELECT MAX(SALARY),MIN(SALARY) INTO salario_maximo,salario_minimo FROM EMPLOYEES;
    DBMS_OUTPUT.PUT_LINE('el salario maximo es:'||salario_maximo);
    DBMS_OUTPUT.PUT_LINE('el salario minimo es:'||salario_minimo);
    diferencia:=salario_maximo - salario_minimo;
    DBMS_OUTPUT.PUT_LINE('su diferencia es:'||diferencia);
END;