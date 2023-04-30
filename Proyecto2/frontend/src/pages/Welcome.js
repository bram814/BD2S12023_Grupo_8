import Slider from "../component/widgets/Slider";
import {useEffect} from "react";
import M from '@materializecss/materialize/dist/js/materialize.min';

function Welcome(props) {

    useEffect(() => {
        M.AutoInit();
        var slider = document.querySelector('.slider');
        M.Slider.init(slider, {
            "height": 700
        });

        let initBreadcrumbs = [
            { link: "/", name: "" },
        ];
        props.setBreadcrumbs(initBreadcrumbs);

    }, []);

    return (
        <div>
            <Slider />
        </div>
    );
}

export default Welcome;