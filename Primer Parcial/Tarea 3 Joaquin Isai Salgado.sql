/* 
        1. Bloques An�nimos
            a. Construir un bloque anonimo donde se declare un cursor y que imprima el
            nombre y sueldo de los empleados (utilice la tabla employees). Si durante el
            recorrido aparece el nombre Peter Tucker (el jefe) se debe genera un
            RAISE_APPLICATION_ERROR indicando que no se puede ver el sueldo del
            jefe.

*/

DECLARE
    CURSOR emp
    IS SELECT first_name,last_name,salary from EMPLOYEES;
BEGIN
    for i IN emp
     LOOP
            IF i.first_name='Peter' AND i.last_name='Tucker'
                THEN
                raise_application_error(-20300,'No se puede ver el sueldo del Jefe.');
                ELSE
                DBMS_OUTPUT.PUT_LINE(i.first_name ||' ' || i.last_name || ': '|| i.salary ||'L');
            END IF;
     END LOOP;
END;


/*

        b. Crear un cursor con par�metros para el parametro id de departamento e
            imprima el numero de empleados de ese departamento (utilice la cla�sula
            count).
            
*/



DECLARE
    CODIGO DEPARTMENTS.DEPARTMENT_ID%TYPE;
    CURSOR Cdepart(COD DEPARTMENTS.DEPARTMENT_ID%TYPE ) IS
    SELECT COUNT(*) FROM employees
    WHERE DEPARTMENT_ID=COD;
    NUM_EMPLE NUMBER;
BEGIN
    CODIGO:=8;
    OPEN Cdepart(CODIGO);
    FETCH Cdepart INTO NUM_EMPLE;
    DBMS_OUTPUT.PUT_LINE('numero de empleados de ' ||codigo||' es '||num_emple);
END;

SET SERVEROUTPUT ON






/*
        c. Crear un bloque que tenga un cursor de la tabla employees.
            i. Por cada fila recuperada, si el salario es mayor de 8000
            incrementamos el salario un 2%
            ii. Si es menor de 8000 incrementamos en un 3%
*/

SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS SELECT * FROM employees for update;
begin
    for EMPLEADO IN C1 LOOP
        IF EMPLEADO.SALARY > 8000 THEN
            UPDATE EMPLOYEES SET SALARY=SALARY*1.02
            WHERE CURRENT OF C1;
            ELSE
            UPDATE EMPLOYEES SET SALARY=SALARY*1.03
            WHERE CURRENT OF C1;
        END IF;
    END LOOP;
    COMMIT;
END ;

/*

    2. Funciones
        a. Crear una funci�n llamada CREAR_REGION
        
        � A la funci�n se le debe pasar como par�metro un nombre de regi�n y
        debe devolver un n�mero, que es el c�digo de regi�n que calculamos
        dentro de la funci�n.
        � Se debe crear una nueva fila con el nombre de esa REGION
        � El c�digo de la regi�n se debe calcular de forma autom�tica. Para ello se
        debe averiguar cual es el c�digo de regi�n m�s alto que tenemos en la
        tabla en ese momento, le sumamos 1 y el resultado lo ponemos como el
        c�digo para la nueva regi�n que estamos creando
        � Debemos controlar los errores en caso que se genere un problema
        � La funci�n debe devolver el n�mero/ c�digo que ha asignado a la
        regi�n.
        � En el script debe colocar la funcion y el bloque para llamar la funci�n.

*/


create or replace FUNCTION CREAR_REGION (nombre varchar2)
    RETURN NUMBER IS
    regiones NUMBER;
    NOM_REGION VARCHAR2(100);
BEGIN

    SELECT REGION_NAME INTO NOM_REGION FROM REGIONS
    WHERE REGION_NAME=UPPER(NOMBRE);
    raise_application_error(-20321,'Esta regi�n ya existe!');
    
    EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
    SELECT MAX(REGION_ID)+1 INTO REGIONES from REGIONS;
    INSERT INTO REGIONS (region_id,region_name) VALUES
    (regiones,upper(nombre));
    RETURN REGIONES;
END;

--Prueba
DECLARE
N_REGION NUMBER;
BEGIN
N_REGION:=crear_region('NORMANDIA');
DBMS_OUTPUT.PUT_LINE('EL NUMERO ASIGNADO ES:'||N_REGION);
END;

/*

    3. Procedimientos
        a. Construya un procedimiento almacenado que haga las operaciones de una
        calculadora, por lo que debe recibir tres parametros de entrada, uno que
        contenga la operación a realizar (SUMA, RESTA, MULTIPLICACION,
        DIVISION), num1, num2 y declare un parametro de retorno e imprima el
        resultado de la operación. Maneje posibles excepciones.

*/






CREATE OR REPLACE PROCEDURE calc_2 
(   numero1        IN NUMBER,
    numero2        IN NUMBER,
    operacion   IN NUMBER,
    resultado   OUT NUMBER)
IS
BEGIN
    IF operacion = 1 THEN 
        resultado:=numero1+numero2;
    END IF;
    IF operacion = 2 THEN 
        resultado:=numero1-numero2;
    END IF;
    IF operacion = 3 THEN 
        resultado:=numero1*numero2;
    END IF;
    IF operacion = 4 THEN 
            IF numero2=0 THEN
            raise_application_error(-20001,'DIVISOR INVALIDO');
            END IF;
        resultado:=numero1/numero2;
    END IF;
    dbms_output.put_line('RESULTADO:'||resultado);

END;
-------------------------------------------------------------

DECLARE
  A NUMBER;
  B NUMBER;
  C NUMBER;
  D NUMBER;
BEGIN
  A:=50;
  B:=10;
  C:=2;
  D:=0;
 calc_2(A,B,C,D);
END;