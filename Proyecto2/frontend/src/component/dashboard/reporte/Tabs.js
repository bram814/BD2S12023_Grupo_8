import M from '@materializecss/materialize/dist/js/materialize.min';
import React, { useEffect, useState } from 'react';
import PieChart from './PieChart';
import { getReporte1, getReporte2, getReporte3, getReporte4, getReporte5, getReporte6, getReporte7, getReporte8  } from '../../../api/MySQL';

const Tabs = () => {

    const [reporte, setReporte] = useState(['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']);

    const [selectReport, setSelectReporte] = useState(null);
    const [selectBD, setSelectBD] = useState(null);
    const [data, setData] = useState([])

    useEffect(() => {
        M.AutoInit();
        let tabs = document.querySelectorAll("tabs");
        M.Tabs.init(tabs);
    }, []);


    function handleChangeReporte(e) {
        setSelectReporte(e.target.value);
    }

    function handleChangeBD(e) {
        setSelectBD(e.target.value);
    }

    async function buscar() {

        if (selectBD==='1' && selectReport === '1') {
            var query = await getReporte1();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`${i.CATEGORIA}`, i.TOTAL_PACIENTES])
            })

            setData(tempData);

        } else if (selectBD==='1' && selectReport === '2') {
            var query = await getReporte2();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`${i.habitacion}`, i.CANTIDAD])
            })

            setData(tempData);

        } else if (selectBD==='1' && selectReport === '3') {
            var query = await getReporte3();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`${i.genero}`, i.CANTIDAD])
            })

            setData(tempData);

        } else if (selectBD==='1' && selectReport === '4') {
            var query = await getReporte4();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`Edad: ${String(i.edad)}`, i.CANTIDAD])
            })

            setData(tempData);

        } else if (selectBD==='1' && selectReport === '5') {
            var query = await getReporte5();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`Edad: ${String(i.edad)}`, i.CANTIDAD])
            })

            setData(tempData);

        } else if (selectBD==='1' && selectReport === '6') {
            var query = await getReporte6();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`${String(i.habitacion)}`, i.CANTIDAD])
            })

            setData(tempData);

        } else if (selectBD==='1' && selectReport === '7') {
            var query = await getReporte7();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`${String(i.habitacion)}`, i.CANTIDAD])
            })

            setData(tempData);

        } else if (selectBD==='1' && selectReport === '8') {
            var query = await getReporte8();
            var result = await query.json();

            var tempData = [];
            result.map(i => {
                tempData.push([`Día: ${String(i.dia)}`, i.CANTIDAD])
            })

            setData(tempData);

        }
    }

    return (

        <div className="row" >
            <div className="col s12 m2 l2">
                <div className="row right">
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
                <div className="row right" >
                    <div className="input-field col s12 m12 l12" >
                        <select className="" onChange={handleChangeReporte} defaultValue="">
                            <option key="0" value="" disabled>Reporte</option>
                            {reporte.map((i, index) => (
                                <option key={`${i}`} value={i}>{`Reporte ${i}`}</option>
                            ))}
                        </select>
                    </div>
                    <div className="row center">

                        <a className="btn-floating btn-large waves-effect waves-light blue" onClick={buscar}><i className="material-icons">search</i></a>
                    </div>


                </div>
            </div>
            <div className="col s12 m8 l8">
                <div className='row'>
                    <PieChart
                        getData={data}
                    />
                </div>
            </div>
            <br /><br /><br /><br /><br />
        </div>
    );
}

export default Tabs;