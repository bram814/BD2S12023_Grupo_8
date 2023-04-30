import M from '@materializecss/materialize/dist/js/materialize.min';
import React, {useState } from "react";
import useAuthContext from '../../hooks/useAuthContext';
import { MY_AUTH_USER, MY_AUTH_PASS } from '../../config/context/Paths';

function Login(props){

    const [user, setUser] = useState('');
    const [pass, setPass] = useState('');

    const { loginUser } = useAuthContext();

    function handleInputChange1(e){
        setUser(e.target.value);
    }
    function handleInputChange2(e){
        setPass(e.target.value);
    }

    async function login(e){
        e.preventDefault();
        try{

            if (user !== '' && pass !== ''){

                window.localStorage.removeItem(MY_AUTH_USER);
                window.localStorage.removeItem(MY_AUTH_PASS);

                window.localStorage.setItem(MY_AUTH_USER, user);
                window.localStorage.setItem(MY_AUTH_PASS, pass);
                loginUser();
                M.toast({
                    html: `Bienvenido, ${user}!`,
                    classes: 'green darken-1 rounded',

                });
            }else {
                window.localStorage.removeItem(MY_AUTH_USER);
                window.localStorage.removeItem(MY_AUTH_PASS);
                M.toast({
                    html: 'Error en los campos, están vaciós!',
                    classes: 'red darken-1 rounded',

                });
            }

        } catch(e){
             window.localStorage.removeItem(MY_AUTH_USER);
            window.localStorage.removeItem(MY_AUTH_PASS);
            M.toast({
                html: 'Usuario/Contraseña Incorrectos',
                classes: 'red darken-1 rounded',

            });
        }

        setUser('');
        setPass('');

    }

    function close(e){
        e.preventDefault();
        M.toast({
            html: 'Close!',
            classes: 'yellow darken-1 black-text rounded',

        });
    }

	return (
        <form className="col s12 container" action="">
            <span className="card-title black-text">Login</span>
            <div className="row">
                <div className="input-field col s12">
                    <input id="username"
                           type="text"
                           className="validate"
                            autoComplete="off"
                            onChange={handleInputChange1}
                            value={user}
                            />
                    <label htmlFor="username">Username</label>
                </div>
            </div>

            <div className="row">
                <div className="input-field col s12">
                    <input id="password"
                            type="password"
                            className="validate"
                            onChange={handleInputChange2}
                            value={pass}
                            />
                    <label htmlFor="password">Password</label>
                </div>
            </div>

            <div className="row">
                <div className="input-field col s6">
                    <button className="modal-close blue lighten-2 black-text btn btn-large waves-effect waves-light"
                            type="submit"
                            name="action"
                            onClick={(e) => login(e)}>
                        Login
                        <i className="material-icons right">send</i>
                    </button>
                </div>
                <div className="input-field col s6">
                    <button className="modal-close red accent-1 black-text btn btn-large waves-effect waves-light"
                            type="submit"
                            name="action"
                            onClick={(e) => close(e)}>
                        Close
                        <i className="material-icons right">close</i>
                    </button>
                </div>
            </div>
        </form>
    );
}

export default Login;