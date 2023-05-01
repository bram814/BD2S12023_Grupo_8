import M from '@materializecss/materialize/dist/js/materialize.min';
import React, { useEffect, useState } from 'react';
import PieChart from './PieChart';

const Tabs = () => {

    const [reporte, setReporte] = useState(['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']);

    const [selectReport, setSelectReporte] = useState(null);

    var data = [
        ['Chrome', 100.41],
        ['Firefox', 10.85],
        ['Internet Explorer', 7.05],
        ['Safari', 4.67],
        ['Edge', 4.18],
        ['Opera', 1.64],
        ['Otros', 0.2]
    ];

    useEffect(() => {
        M.AutoInit();
        let tabs = document.querySelectorAll("tabs");
        M.Tabs.init(tabs);
    }, []);


    function handleChangeReporte(e){
        setSelectReporte(e.target.value);
    }

    return (

        <div className="row" >
            <div className="col s12 m2 l2">
                <div className="row">
                    <div class="input-field col s12 m12 l12">
                        <select>
                            <option value="" selected>Base de Datos</option>
                            <option value="1">MySQL</option>
                            <option value="2">MongoDB</option>
                            <option value="3">Cassandra</option>
                            <option value="4">Redis</option>
                        </select>
                    </div>

                </div>
                <div className="row" >
                    <div class="input-field col s12" >  
                    <select className="" onChange={handleChangeReporte}>
                            <option value="" selected>Reporte</option>
                            {reporte.map(i => (
                                <option key={i} value={i}>{`Reporte ${i}`}</option>
                            ))}
                        </select>
                    </div>

                </div>
                <div className='row center'>


                <a class="btn-floating btn-large waves-effect waves-light blue"><i class="material-icons">search</i></a>
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