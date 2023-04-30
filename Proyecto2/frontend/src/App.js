/* Materializecss */
import '@materializecss/materialize/dist/css/materialize.css';
import '@materializecss/materialize/dist/js/materialize';
/* Import */
import React, {useState} from "react";
import {Route, Routes} from "react-router-dom";
/* ROUTES */
import { HOME, DASHBOARD, CAR, GRAPH } from './config/routes/Paths';
import PublicRoute from './routes/PublicRoute';
import PrivateRoute from './routes/PrivateRoute';
/* Component */
import Breadcrumbs from "./component/Breadcrumbs";
import Navbar from './component/widgets/Navbar';
import Footer from './component/widgets/Footer';
/* PAGES */
import Welcome from './pages/Welcome';
import Dashboard from './pages/dashboard/Dashboard';
import Vehicle from './pages/dashboard/vehicle/Vehicle';
import Reporte from './pages/dashboard/reporte/Reporte';

function App() {

  const [breadcrumbs, setBreadcrumbs] = useState([]);
  return (
    <div className="App">
      <Navbar />
      <main>
        <Breadcrumbs breadcrumbs={breadcrumbs} />
        <Routes>

          <Route path={HOME} element={<PublicRoute />} >
            <Route index element={<Welcome setBreadcrumbs={setBreadcrumbs} /> } />
          </Route>

          <Route path={DASHBOARD} element={<PublicRoute />} >
            <Route index        element={<Dashboard setBreadcrumbs={setBreadcrumbs} />} />
            <Route path={CAR}   element={<Vehicle   setBreadcrumbs={setBreadcrumbs} />} />
            <Route path={GRAPH} element={<Reporte   setBreadcrumbs={setBreadcrumbs} />} />
             {/*<Route path="/ruta" element={<Componente setBreadcrumbs={setBreadcrumbs} />} />*/}
          </Route>

        </Routes>
      </main>
      <Footer />
    </div>
  );
}

export default App;
