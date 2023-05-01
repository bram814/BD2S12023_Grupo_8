import M from '@materializecss/materialize/dist/js/materialize.min';
import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import useAuthContext from '../../hooks/useAuthContext';
import Modal from "./Modal";
import { HOME, DASHBOARD, CAR, GRAPH } from '../../config/routes/Paths';

function Navbar(props) {

    var menu, menuSide;

    const [instance, setInstance] = useState(null);
    const [typeForm, setTypeForm] = useState("");

    const { isAuthenticated, logoutUser } = useAuthContext();


    useEffect(() => {
        M.AutoInit();
        let sideNav = document.querySelector('.sidenav');
        let instanceSideNav = M.Sidenav.init(sideNav);
        setInstance(instanceSideNav);



    }, []);

    function closeSideNavbar() {
        instance.close();
    }


    menu = (
        <ul className="left hide-on-med-and-down">
            <li><Link to={HOME} className="waves-effect waves-light btn orange accent-2 black-text">
                <i className="material-icons center">dashboard</i>
            </Link></li>
            <li><Link to={CAR} className="waves-effect waves-light btn light-red accent-2 black-text">
                Datos
                <i className="material-icons left">insert_drive_file</i>
            </Link></li>

            <li><Link to={GRAPH} className="waves-effect waves-light btn light-blue accent-2 black-text">
                Reportes
                <i className="material-icons left">insert_chart</i>
            </Link></li>
        </ul>
    )

    menuSide = (
        <ul className="left hide-on-med-and-down">
            <li><Link to={HOME} className="waves-effect waves-light btn orange accent-2 black-text">
                <i className="material-icons center">dashboard</i>
            </Link></li>
            <li><Link to={CAR} className="waves-effect waves-light btn light-red accent-2 black-text">
                <i className="material-icons left">insert_drive_file</i>
            </Link></li>

            <li><Link to={GRAPH} className="waves-effect waves-light btn light-blue accent-2 black-text">
                Reportes
                <i className="material-icons left">insert_chart</i>
            </Link></li>


        </ul>
    )



    return (
        <div>
            <nav>
                <div className="nav-wrapper blue lighten-2 ">
                    <a href="/" data-target="mobile-demo" className="sidenav-trigger"><i className="material-icons">menu</i></a>
                    {menu}
                </div>
            </nav>
            <ul className="sidenav" id="mobile-demo">
                <li>
                    <Link to="/" className="brand-logo"
                        onClick={() => closeSideNavbar(instance)}
                    >
                        Full<strong>Trip</strong>
                    </Link>
                </li>

                {menuSide}
            </ul>

        </div>

    );
}

export default Navbar;