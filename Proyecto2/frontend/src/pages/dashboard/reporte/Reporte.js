import {useEffect} from "react";
import Tabs from "../../../component/dashboard/reporte/Tabs";
import { HOME, GRAPH } from '../../../config/routes/Paths';

function Reporte(props){

    useEffect(() => {
        var initBreadcrumbs = [
            { link: {HOME},       name: "Inicio" },
            { link: {GRAPH},      name: "Reportes" }
        ];
        props.setBreadcrumbs(initBreadcrumbs);
    }, []);

    return (
        <div className="container">
            <br /><br /><br />
            <Tabs />
            <br /><br /><br />
        </div>
    );
}

export default Reporte;