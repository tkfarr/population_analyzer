// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("chartkick")
require("chart.js")
require("highcharts")

import "@fortawesome/fontawesome-free/js/all";
import Highcharts from 'highcharts';

document.addEventListener('DOMContentLoaded', function () {
  $.getJSON(window.location.href, function (json) {
    var highChartData = json;
    Highcharts.chart('reports-natural-increase', {
      chart: {
        type: 'column'
      },
      title: {
        text: 'Natural Increase in Population, County vs State'
      },
      subtitle: {
        text: `County: ${highChartData.county} | State: ${highChartData.state}`
      },
      xAxis: {
        categories: ['2010','2011','2012','2013','2014','2015']
      },

      yAxis: [{
        title: {
          text: 'Pop Increase'
        }
      }, {
        max: 100,
        title: {
          text: 'Percent of State'
        },
        opposite: true
      }],
      legend: {
        shadow: false
      },
      tooltip: {
        shared: true
      },
      plotOptions: {
        column: {
          grouping: false,
          shadow: false,
          borderWidth: 0
        }
      },
      series: [
        {
          name: 'State',
          color: 'rgba(158,255,216,.9)',
          data: [parseInt(highChartData.state_natural_inc_2010), parseInt(highChartData.state_natural_inc_2011), parseInt(highChartData.state_natural_inc_2012), parseInt(highChartData.state_natural_inc_2013), parseInt(highChartData.state_natural_inc_2014), parseInt(highChartData.state_natural_inc_2015)],
          pointPadding: 0.3,
          pointPlacement: 0
        },{
          name: 'County',
          color: 'rgba(81,206,232,1)',
          data: [highChartData.county_natural_inc_2010, highChartData.county_natural_inc_2011, highChartData.county_natural_inc_2012, highChartData.county_natural_inc_2013, highChartData.county_natural_inc_2014, highChartData.county_natural_inc_2015],
          pointPadding: 0.4,
          pointPlacement: 0
        },
        {
          name: 'Percent of State',
          color: 'rgba(145,238,255,0)',
          data: [parseInt(highChartData.percent_of_state_2010), parseInt(highChartData.percent_of_state_2011), parseInt(highChartData.percent_of_state_2012), parseInt(highChartData.percent_of_state_2013), parseInt(highChartData.percent_of_state_2014), parseInt(highChartData.percent_of_state_2015)],
          tooltip: {
            valueSuffix: ' %'
          },
          pointPadding: 0.3,
          pointPlacement: .3,
          yAxis: 1
        }
      ]
    });
  });
});
