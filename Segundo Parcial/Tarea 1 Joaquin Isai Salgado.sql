/*  
        1. Crear un TRIGGER BEFORE DELETE sobre la tabla EMPLOYEES que lance una
        excepción e impida borrar un registro si su JOB_ID incluye una cadena cuyo
        contenido contenga la subcadena CLERK.
*/

CREATE OR REPLACE TRIGGER tg_empleado BEFORE
DELETE ON employees FOR EACH ROW
BEGIN
    IF
        :old.job_id LIKE ( '%CLERK' )
        THEN
        raise_application_error(-20320,'NADA');
    END IF;
END;

select * from employees;
delete from employees where job_id LIKE ('%CLERK');


/*

    2.  Crear un TRIGGER BEFORE INSERT en la tabla DEPARTMENTS que al insertar un
    departamento compruebe que el código no esté repetido y luego que si el nuevo
    valor LOCATION_ID es NULL actualicé el campo con el valor 1700 y si el
    MANAGER_ID es NULL l actualicé el campo con el valor 200.


*/


create or replace trigger tg_departamento before
insert on DEPARTMENTS FOR EACH ROW
declare
begin
    update DEPARTMENT_ID
    set MANAGER_ID = null - :new.cantidad
    where MANAGER_ID = :new.codigoproducto;
    
end;


/*
    
    3. Crear las dos siguientes tablas:
    CREATE TABLE EMPLEADOS
    (
    CODIGO INT NOT NULL PRIMARY KEY,
    NOMBRE VARCHAR2(20),
    SALARIO DECIMAL(10,2)
    );
    CREATE TABLE LOG_SALARIO
    (
    codigo INT,
    salario_anterior DECIMAL(10,2),
    salario_actual DECIMAL(10,2),
    fecha DATE,
    usuario VARCHAR2(20),
    operacion varchar2(10)
    );
        Utilice los predicados condicionales y agregue un trigger en la tabla empleados, valide el
        tipo de operación e inserte un registro en la tabla log_salario. Si se hace una inserción
        coloque los valores salario_anterior 1 y salario_actual tomar el new y operación =
        “Inserción”
        En caso de ser Actualización guardar el valor anterior y nuevo en la tabla log_salario y
        operación =” Actualización” y en la operación delete colocar salario_anterior old y
        salario_actual como 1.

*/


CREATE TABLE EMPLEADOS
    (
    CODIGO INT NOT NULL PRIMARY KEY,
    NOMBRE VARCHAR2(20),
    SALARIO DECIMAL(10,2)
    );
    
    
 CREATE TABLE LOG_SALARIO
    (
    codigo INT,
    salario_anterior DECIMAL(10,2),
    salario_actual DECIMAL(10,2),
    fecha DATE,
    usuario VARCHAR2(20),
    operacion varchar2(10)
    );


CREATE OR REPLACE TRIGGER TG_EMPLEADO
AFTER INSERT OR UPDATE OR DELETE ON EMPLEADOS
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN 
    IF(INSERTING)THEN
        INSERT INTO LOG_SALARIO VALUES (SQ_LOG_SALARIO .NEXTVAL, 'SE REALIZO UN INSERT EN SALARIO ACTUAL Y
        EL NUEVO DATO ES EL ID: '||:NEW. salario_actual||'Y EL NOMBRE ES: '||:NEW.NOMBRE,
        SYSTIMESTAMP, USER, 'OPERACION INSERT');
    END IF;
    
    IF (UPDATING) THEN
        INSERT INTO LOG_SALARIO  VALUES (SQ_LOG_SALARIO.NEXTVAL, 'SE REALIZO UN UPDATE EN SALARIO Y
        EL NOMBRE ANTEIOR DEL SALARIO ANTERIOR : '||:OLD.salario_anterior||'Y EL NUEVO VALOR ES: '||:NEW.NOMBRE,
        SYSTIMESTAMP, USER, 'OPERACION UPDATING');
    END IF;
    
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
         
             ROLLBACK;
END;

