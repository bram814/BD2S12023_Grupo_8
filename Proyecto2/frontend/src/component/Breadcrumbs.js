import React from 'react';
import {Link} from "react-router-dom";

function Breadcrumbs(props) {

    return (
        <div className="">
            <nav className="blue lighten-2">
                <div className="nav-wrapper" style={{marginLeft:'10px'}}>
                    <div className="col s12">
                        { props.breadcrumbs.map(a => {
                            return (
                                <Link to="/" className="breadcrumb">{ a.name }</Link>
                            )
                        })}
                    </div>
                </div>
            </nav>
        </div>
    );
}

export default Breadcrumbs;