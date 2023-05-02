import M from '@materializecss/materialize/dist/js/materialize.min';
import React, { useEffect, useState } from 'react';
import { getHabitacion, getPaciente, addLogActividad, addLogHabitacion } from '../../../api/MySQL';

const Tabs = () => {


    const [selectBD, setSelectBD] = useState(null);
    const [selectTipo, setSelectTipo] = useState(null);
    const [selectHabitacion, setSelectHabitacion] = useState(null);
    const [selectPaciente, setSelectPaciente] = useState(null);

    const [habitacion, setHabitacion] = useState([]);
    const [paciente, setPaciente] = useState([]);

    const [descripcion, setDescripcion] = useState(null);

    function handleChangeBD(e) {
        setSelectBD(e.target.value);
    }

    function handleChangeTipo(e) {
        setSelectTipo(e.target.value);
    }

    function handleChangeHabitacion(e) {
        setSelectHabitacion(e.target.value);
    }

    function handleChangeDescripcion(e) {
        setDescripcion(e.target.value);
    }

    function handleChangePaciente(e) {
        setSelectPaciente(e.target.value);
    }

    useEffect(() => {

        datosIniciales();

        var elems = document.querySelectorAll('select');
        var instances = M.FormSelect.init(elems, null);

    }, []);

    function empty(obj) {
        for (var prop in obj) {
            if (obj.hasOwnProperty(prop))
                return false;
        }
        return true;
    }

    async function add() {
        try {
            if (selectBD === "1") {
                

                if (selectTipo === "1") { // LogActividad
                    if (empty(descripcion) || empty(selectHabitacion) || empty(selectPaciente)) {
                        M.toast({
                            html: `Debe de ingresar todos los campos.`,
                            classes: 'red darken-1 rounded',

                        });
                        return;
                    }
                    var query = await addLogActividad(descripcion, selectPaciente, selectHabitacion);
                    var result = await query.json();

                    if (result.errno != null) {
                        M.toast({
                            html: `Ingreso de Datos Incorrectos.`,
                            classes: 'red darken-1 rounded',

                        });
                    } else {
                        M.toast({
                            html: ` Datos ingresados correctamente a LogActividad.`,
                            classes: 'green darken-1 rounded',

                        });
                    }
                } else if (selectTipo === "2") { // Log Habitación
                    if (empty(descripcion) || empty(selectHabitacion)) {
                        M.toast({
                            html: `Debe de ingresar todos los campos excepto paciente.`,
                            classes: 'red darken-1 rounded',

                        });
                        return;
                    }

                    var query = await addLogHabitacion(descripcion, selectHabitacion);
                    var result = await query.json();

                    if (result.errno != null) {
                        M.toast({
                            html: `Ingreso de Datos Incorrectos.`,
                            classes: 'red darken-1 rounded',

                        });
                    } else {
                        M.toast({
                            html: ` Datos ingresados correctamente a LogHabitacion.`,
                            classes: 'green darken-1 rounded',

                        });
                    }

                } else {
                    M.toast({
                        html: ` Debe de seleccionar un Tipo.`,
                        classes: 'red darken-1 rounded',

                    });
                }

            }

        } catch (e) {

            M.toast({
                html: `${e}`,
                classes: 'red darken-1 rounded',

            });
        }

    }


    async function datosIniciales() {
        try {
            var query = await getHabitacion();
            var result = await query.json();

            console.log(result);
            setHabitacion([...result]);



        } catch (e) {
            M.toast({
                html: `${e}`,
                classes: 'red darken-1 rounded',

            });
        }
    }

    return (
        <>
            <div className="row">

                <div className="col s12 m3 l3">
                    <div className="input-field col s12 m12 l12">
                        <select defaultValue="" onChange={handleChangeBD}>
                            <option key="0" value="" disabled>Base de Datos</option>
                            <option key="1" value="1">MySQL</option>
                            <option key="2" value="2">MongoDB</option>
                            <option key="3" value="3">Cassandra</option>
                            <option key="4" value="4">Redis</option>
                        </select>
                    </div>
                </div>

                <div className="col s12 m3 l3">
                    <div className="input-field col s12 m12 l12">
                        <select defaultValue="" onChange={handleChangeTipo}>
                            <option key="0" value="" disabled>Tipo</option>
                            <option key="1" value="1">LogActividad</option>
                            <option key="2" value="2">LogHabitacion</option>
                        </select>
                    </div>
                </div>

                <div className="col s12 m3 l3">
                    <div className="input-field col s12 m12 l12" >
                        <select className="browser-default" onChange={handleChangeHabitacion} defaultValue="">
                            <option value="" disabled >Habitación</option>
                            {
                                habitacion.map((i, index) => (
                                    <option key={index} value={i.idHabitacion}>{`Habitacion ${i.idHabitacion} - ${i.habitacion}`}</option>

                                ))

                            }
                        </select>
                    </div>
                </div>


                <div className="col s12 m3 l3">
                    <div className="row">
                        <div className="input-field col s12 m12 l12">
                            <i className="material-icons prefix">account_circle</i>
                            <input id="icon_prefix" type="text" className="validate" onChange={handleChangePaciente} />
                            <label for="icon_prefix">Paciente</label>
                        </div>
                    </div>
                </div>



            </div>

            <div className="row">

                <div className="col s12 m12 l12">
                    <div className="input-field col s12">
                        <textarea id="textarea1" className="materialize-textarea" onChange={handleChangeDescripcion}></textarea>
                        <label htmlFor="textarea1">Descripción</label>
                    </div>
                </div>

            </div>
            <div className="row center">
                <div className="col s12 m12 l12">

                    <a className="btn-floating btn-large waves-effect waves-light green" onClick={add}><i className="material-icons">add</i></a>
                </div>
            </div>

            <br /><br /><br /><br /><br />
        </>
    );
}

export default Tabs;