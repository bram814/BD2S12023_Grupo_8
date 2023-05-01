import {useEffect} from "react";
import Tabs from "../../../component/dashboard/vehicle/Tabs";
import { HOME, CAR } from '../../../config/routes/Paths';

function Vehicle(props){

    useEffect(() => {
        var initBreadcrumbs = [
            { link: {HOME},     name: "Inicio" },
            { link: {CAR},      name: "Ingreso de Datos" }
        ];
        props.setBreadcrumbs(initBreadcrumbs);
    }, []);

    return (
        <div className="">
            <br /><br /><br />
            <Tabs />
            <br /><br /><br />
        </div>
    );
}

export default Vehicle;