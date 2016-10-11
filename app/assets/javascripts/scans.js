$(function () {
  fetch_analytics();

  function fetch_analytics() {
    var sid = $('#vulnerability-container').data('scan')
    if (sid == undefined) {
      return;
    }

    $.ajax({
      url: '/scan/' + sid + '/vulnerabilities/chart',
      method: 'GET',
      success: function(data) {
        render_graph(data);
      }
    });
  }

  function render_graph(data) {
    Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
      return {
        radialGradient: {
          cx: 0.5,
          cy: 0.3,
          r: 0.7
        },
        stops: [
          [0, color],
          [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
        ]
      };
    });
    Highcharts.setOptions({
      colors: ['#50B432', '#ED561B', '#24CBE5', '#64E572', '#F3076B']
    });
    $('#vulnerability-container').highcharts({
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
      },
      title: {
        text: ''
      },
      tooltip: {
        pointFormat: '{series.name}: <b>{point.y}</b>'
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            format: '<b>{point.name}</b>: {point.y}',
            style: {
              color: 'black'
            }
          }
        }
      },
      series: [{
        name: 'Severity',
        data: data
      }]
    });
  }
});
