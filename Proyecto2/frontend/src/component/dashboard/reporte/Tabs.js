import M from '@materializecss/materialize/dist/js/materialize.min';
import React, { useEffect, useState } from 'react';
import PieChart from './PieChart';
import { getReporte1 } from '../../../api/MySQL';

const Tabs = () => {

    const [reporte, setReporte] = useState(['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']);

    const [selectReport, setSelectReporte] = useState(null);
    const [data, setData] = useState([])
    // var data = [
    //     ['Chrome', 100.41],
    //     ['Firefox', 10.85],
    //     ['Internet Explorer', 7.05],
    //     ['Safari', 4.67],
    //     ['Edge', 4.18],
    //     ['Opera', 1.64],
    //     ['Otros', 0.2]
    // ];

    useEffect(() => {
        M.AutoInit();
        let tabs = document.querySelectorAll("tabs");
        M.Tabs.init(tabs);
    }, []);


    function handleChangeReporte(e) {
        setSelectReporte(e.target.value);
    }

    async function buscar() {
        if (selectReport === '1') {
            var query = await getReporte1();
            var result = await query.json();

            console.log(result)

            var tempData = [];

            result.map(i => {
                tempData.push([`${i.CATEGORIA}`, i.TOTAL_PACIENTES])
            })

            setData(tempData);
        }
    }

    return (

        <div className="row" >
            <div className="col s12 m2 l2">
                <div className="row">
                    <div className="input-field col s12 m12 l12">
                        <select defaultValue="">
                            <option key="0" value="" disabled>Base de Datos</option>
                            <option key="1" value="1">MySQL</option>
                            <option key="2" value="2">MongoDB</option>
                            <option key="3" value="3">Cassandra</option>
                            <option key="4" value="4">Redis</option>
                        </select>
                    </div>

                </div>
                <div className="row" >
                    <div className="input-field col s12" >
                        <select className="" onChange={handleChangeReporte} defaultValue="">
                            <option key="0" value="" disabled>Reporte</option>
                            {reporte.map((i, index) => (
                                <option key={`${i}`} value={i}>{`Reporte ${i}`}</option>
                            ))}
                        </select>
                    </div>

                </div>
                <div className='row center'>


                    <a className="btn-floating btn-large waves-effect waves-light blue" onClick={buscar}><i className="material-icons">search</i></a>
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