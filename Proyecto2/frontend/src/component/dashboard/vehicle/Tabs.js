import M from '@materializecss/materialize/dist/js/materialize.min';
import React, { useEffect } from 'react';

const Tabs = () => {



    useEffect(() => {
        M.AutoInit();
        let tabs = document.querySelectorAll("tabs");
        M.Tabs.init(tabs);
    }, []);

    return (
    
        <div className="row">
            <div className="col s12">
                <ul className="tabs tabs-fixed-width tab-demo z-depth-1 ">

                    <li className="tab col s2">

                       <a href="#test1"><i className="material-icons">add</i></a>
                    </li>


                </ul>
            </div>
            <br/><br/><br/><br/><br/>
            <div className="row">

                <div id="test1" className="col s10 m12">
                    <h5>Datos 1</h5>
                </div>
               
            </div>
        </div>
    );
}

export default Tabs;