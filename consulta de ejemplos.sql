--ejemplo de registro de hospital--
DECLARE
    v_idhospital NUMBER;
BEGIN
    SP_HOSPITAL_REGISTRAR(
        p_iddistrito => 1,
        p_nombre => 'Hospital Central',
        p_antiguedad => 10,
        p_area => 5000,
        p_idsede => 1,
        p_idgerente => 1,
        p_idcondicion => 1,
        p_fecharegistro => TO_DATE('2024-01-15', 'YYYY-MM-DD'),
        p_idhospital => v_idhospital
    );

    DBMS_OUTPUT.PUT_LINE('IDHOSPITAL registrado: ' || v_idhospital);
END;

--ejemplo de actualizacion de datos--
BEGIN
    SP_HOSPITAL_ACTUALIZAR(
        p_idhospital => 1,
        p_iddistrito => 2,
        p_nombre => 'Hospital Actualizado',
        p_antiguedad => 12,
        p_area => 6000,
        p_idsede => 2,
        p_idgerente => 2,
        p_idcondicion => 2,
        p_fecharegistro => TO_DATE('2024-02-01', 'YYYY-MM-DD')
    );

    DBMS_OUTPUT.PUT_LINE('Hospital actualizado exitosamente.');
END;

--ejemplo de eliminacion de datos--
BEGIN
    SP_HOSPITAL_ELIMINAR(
        p_idhospital => 1
    );

    DBMS_OUTPUT.PUT_LINE('Hospital eliminado exitosamente.');
END;

--ejemplo de listado de datos--
BEGIN
    SP_HOSPITAL_LISTAR;
END;

