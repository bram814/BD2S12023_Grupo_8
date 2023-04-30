import { Navigate, Outlet } from 'react-router-dom';
import useAuthContext from '../hooks/useAuthContext';
import { DASHBOARD } from '../config/routes/Paths';

const PublicRoute = (props) => {
    
    const {isAuthenticated} = useAuthContext();


    if(isAuthenticated){
        return <Navigate to={DASHBOARD} />
    }

    return ( 

        <div>
            <Outlet />
        </div>
    );

};


export default PublicRoute;