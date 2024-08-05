--CREACION DE LA SECUENCIA PARA EL REGISTRO DE HOSPITALES --
CREATE SEQUENCE HOSPITAL_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


--CREACION DE STORE PROCEDURE SP_HOSPITAL_REGISTRAR--
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_REGISTRAR (
    p_iddistrito IN NUMBER,
    p_nombre IN VARCHAR2,
    p_antiguedad IN NUMBER,
    p_area IN NUMBER,
    p_idsede IN NUMBER,
    p_idgerente IN NUMBER,
    p_idcondicion IN NUMBER,
    p_fecharegistro IN DATE,
    p_idhospital OUT NUMBER
) AS
BEGIN
    -- Obtener el siguiente valor de la secuencia
    SELECT HOSPITAL_SEQ.NEXTVAL INTO p_idhospital FROM dual;

    -- Insertar el nuevo registro en la tabla HOSPITAL
    INSERT INTO HOSPITAL (
        IDHOSPITAL, IDDISTRITO, NOMBRE, ANTIGUEDAD, AREA, IDSEDE, IDGERENTE, IDCONDICION, FECHAREGISTRO
    ) VALUES (
        p_idhospital, p_iddistrito, p_nombre, p_antiguedad, p_area, p_idsede, p_idgerente, p_idcondicion, p_fecharegistro
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de error
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM);
        ROLLBACK;
END SP_HOSPITAL_REGISTRAR;


--CREACION DEL PROCEDIMIENTO DE ACTUALIZACION--

CREATE OR REPLACE PROCEDURE SP_HOSPITAL_ACTUALIZAR (
    p_idhospital IN NUMBER,
    p_iddistrito IN NUMBER,
    p_nombre IN VARCHAR2,
    p_antiguedad IN NUMBER,
    p_area IN NUMBER,
    p_idsede IN NUMBER,
    p_idgerente IN NUMBER,
    p_idcondicion IN NUMBER,
    p_fecharegistro IN DATE
) AS
BEGIN
    -- Actualizar el registro del hospital
    UPDATE HOSPITAL
    SET
        IDDISTRITO = p_iddistrito,
        NOMBRE = p_nombre,
        ANTIGUEDAD = p_antiguedad,
        AREA = p_area,
        IDSEDE = p_idsede,
        IDGERENTE = p_idgerente,
        IDCONDICION = p_idcondicion,
        FECHAREGISTRO = p_fecharegistro
    WHERE
        IDHOSPITAL = p_idhospital;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de error
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM);
        ROLLBACK;
END SP_HOSPITAL_ACTUALIZAR;



--ELIMINACION DE HOSPITAL--

CREATE OR REPLACE PROCEDURE SP_HOSPITAL_ELIMINAR (
    p_idhospital IN NUMBER
) AS
BEGIN
    -- Eliminar el registro del hospital
    DELETE FROM HOSPITAL
    WHERE IDHOSPITAL = p_idhospital;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de error
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM);
        ROLLBACK;
END SP_HOSPITAL_ELIMINAR;


--LISTAR HOSPITALES--

CREATE OR REPLACE PROCEDURE SP_HOSPITAL_LISTAR AS
    v_count NUMBER := 0;
BEGIN
    -- Declarar el cursor para seleccionar los registros de la tabla HOSPITAL
    FOR r IN (SELECT * 
              FROM HOSPITAL)
    LOOP
        -- Incrementar el contador
        v_count := v_count + 1;

        -- Imprimir lista de hospitales
        DBMS_OUTPUT.PUT_LINE('IDHOSPITAL: ' || r.IDHOSPITAL || 
                             ', IDDISTRITO: ' || r.IDDISTRITO || 
                             ', NOMBRE: ' || r.NOMBRE || 
                             ', ANTIGUEDAD: ' || r.ANTIGUEDAD || 
                             ', AREA: ' || r.AREA || 
                             ', IDSEDE: ' || r.IDSEDE || 
                             ', IDGERENTE: ' || r.IDGERENTE || 
                             ', IDCONDICION: ' || r.IDCONDICION || 
                             ', FECHAREGISTRO: ' || r.FECHAREGISTRO);
    END LOOP;

    -- Verificar si la lista está vacía
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('La lista de hospitales está vacía.');
    END IF;
END SP_HOSPITAL_LISTAR;