import {useEffect} from "react";
import Tabs from "../../component/dashboard/Tabs";
import { HOME, DASHBOARD } from '../../config/routes/Paths';

function Dashboard(props){

    useEffect(() => {
        let initBreadcrumbs = [
            { link: {HOME},          name: "Inicio" },
            { link: {Dashboard},     name: "Dashboard" }
        ];
        props.setBreadcrumbs(initBreadcrumbs);
    }, []);

    return (
        <div className="row">
            <h5>Datos Personales</h5>
            <Tabs />
        </div>
    );
}

export default Dashboard;