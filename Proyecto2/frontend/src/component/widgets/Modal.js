import Login from "./Login";

function Modal(props){

    var form = "";

    if ( props.typeForm === "login" ) {
        form = (
            <div className="modal-content blue lighten-1">
                <div className="card">
                    <Login /> <div className="card-action"></div>
                </div>
            </div>

        )
    } 

    return (
        <div id="modal1" className="modal">
            { form } 
        </div>
    );
}

export default Modal;