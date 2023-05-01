import React from 'react';
import Highcharts from 'highcharts';
import HighchartsReact from 'highcharts-react-official';

function PieChart(props) {
    

const options = {
    chart: {
        type: 'pie',

    },
    credits: {
        enabled: false
    },

    title: {
        text: 'Navegadores web utilizados en 2018',
        style: {
            fontSize: '20px',
            fontFamily: 'Eurostile',

        }
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b> ({point.y})'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} % ({point.y})',
                // format: '<b>{point.name}</b>: {point.percentage:.1f} % ({point.y} de {point.total})',
                connectorColor: 'silver',
            },
            showInLegend: true,

            size: '100%',
            startAngle: 150

        }
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: 0,
        y: 50,
        style: {
            fontSize: '16px',
            fontFamily: 'Arial, sans-serif'
        }
    },
    height: 1000,
    series: [{
        name: 'Porcentaje de uso',
        data: props.getData
    }]
};

    
    return (
        <HighchartsReact highcharts={Highcharts} options={options} />
    );
}

export default PieChart;