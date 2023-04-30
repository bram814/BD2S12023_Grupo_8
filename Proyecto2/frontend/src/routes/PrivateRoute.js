import { Navigate, Outlet } from 'react-router-dom';
import useAuthContext from '../hooks/useAuthContext';
import { HOME } from '../config/routes/Paths';

const PrivateRoute = (props) => {
    
    const {isAuthenticated} = useAuthContext();


    if(!isAuthenticated){
        return <Navigate to={HOME} />
    }

    return ( 

        <div>
            <Outlet />
        </div>
    );

};


export default PrivateRoute;