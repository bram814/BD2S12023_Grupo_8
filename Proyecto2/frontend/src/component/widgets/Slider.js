import trip1 from '../../img/trip1.jpg';
import trip2 from '../../img/trip2.jpg';
import trip3 from '../../img/trip3.jpg';

function Slider(props) {

    return (
        <div className="slider">
            <ul className="slides">
                <li>
                    <img
                        width="100%"
                        src={trip1}
                    />
                        <div className="caption center-align">
                            <h3>Con autodisciplina casi todo es posible.</h3>
                            <h5 className="light grey-text text-lighten-3">Theodore Roosevelt</h5>
                        </div>
                </li>
                <li>
                    <img width="100%" src={trip2} />
                        <div className="caption left-align">
                            <h3>Si puedes soñarlo, puedes hacerlo.</h3>
                            <h5 className="light grey-text text-lighten-3">Walt Disney</h5>
                        </div>
                </li>
                <li>
                    <img width="100%" src={trip3} />
                        <div className="caption right-align">
                            <h3>El hombre que mueve montañas comienza cargando pequeñas piedras</h3>
                            <h5 className="light grey-text text-lighten-3">Confucio</h5>
                        </div>
                </li>
            </ul>
        </div>
    );

}

export default Slider;