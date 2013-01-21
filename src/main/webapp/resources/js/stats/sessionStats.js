function getSessionData() {

	window.allChart = createDetail([ new Date() ], [], [], [], 'allPlatform',
			'Temps d\'utilisation moyen', 'iOS & Android', new Date());
	window.allPushSessionChart = createDetail([ new Date() ], [], [], [],
			'allPushSession', 'Temps d\'utilisation moyen par platform',
			'iOS & Android', new Date());

	window.iOSChart = createDetail([ new Date() ], [], [], [], 'ios',
			'Temps d\'utilisation moyen sur iOS', 'iOS', new Date());
	window.androidChart = createDetail([ new Date() ], [], [], [], 'android',
			'Temps d\'utilisation moyen sur Android', 'Android', new Date());
};

function addDetailSeries(chart, startDate, data, color, name) {
	chart.addSeries({
		type : 'area',
		name : name,
		pointStart : startDate,
		pointInterval : 24 * 3600 * 1000,
		data : data,
		color : color
	});
}

function updateSessionData(appId) {

	var jsonData = '{"appId":"' + appId + '"}';
	jq
			.ajax({
				type : "POST",
				url : 'http://localhost:8080/statistics/service/statistics/generator/relatif/session',
				data : jsonData,
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(data) {

					var ios = data.iOS;
					var ios_sub = data.iOS_sub;
					var total = data.total;
					var total_sub = data.total_sub;
					var android = data.android;
					var android_sub = data.android_sub;

					var dates = data.dates;

					while (window.allChart.series.length > 0) {
						window.allChart.series[0].remove(true); // forces
					}

					while (window.androidChart.series.length > 0) {
						window.androidChart.series[0].remove(true); // forces
					}

					while (window.iOSChart.series.length > 0) {
						window.iOSChart.series[0].remove(true); // forces
					}

					while (window.allPushSessionChart.series.length > 0) {
						window.allPushSessionChart.series[0].remove(true); // forces
					}

					var startDate = dates[0];

					addDetailSeries(window.allChart, startDate, total,
							'#666600', 'session normale');
					addDetailSeries(window.allChart, startDate, total_sub,
							'#FF6F56', 'session du push');

					addDetailSeries(window.iOSChart, startDate, ios, '#666600',
							'session normale');
					addDetailSeries(window.iOSChart, startDate, ios_sub,
							'#FF6F56', 'session du push');

					addDetailSeries(window.androidChart, startDate, android,
							'#666600', 'session normale');
					addDetailSeries(window.androidChart, startDate,
							android_sub, '#FF6F56', 'session du push');

					addDetailSeries(window.allPushSessionChart, startDate,
							total, '#666600', 'Total');
					addDetailSeries(window.allPushSessionChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.allPushSessionChart, startDate,
							android, '#FF6F56', 'Android');

				}

			});
};

// create the detail chart
function createDetail(dates, ios, android, total, detailContainer, title,
		subtitle, detailStart) {

	// create a detail chart referenced by a global
	// variable
	window.detail = new Highcharts.Chart({
		chart : {
			renderTo : detailContainer,
			zoomType : 'x',
			spacingRight : 20
		},
		credits : {
			enabled : false
		},
		title : {
			text : title
		},
		subtitle : {
			text : subtitle
		},
		xAxis : {
			type : 'datetime',
			maxZoom : 14 * 24 * 3600000, // fourteen days
			title : {
				text : null
			}
		},
		yAxis : {
			title : {
				text : ''
			},
			showFirstLabel : false
		},
		tooltip : {
			crosshairs : true,
			shared : true
		},
		legend : {
			enabled : true
		},

		plotOptions : {
			series : {
				marker : {
					enabled : false
				}
			},
			area : {
				fillColor : {
					linearGradient : {
						x1 : 0,
						y1 : 0,
						x2 : 0,
						y2 : 1
					},
					stops : [ [ 0, Highcharts.getOptions().colors[0] ],
							[ 1, 'rgba(2,0,0,0)' ] ]
				},
				lineWidth : 1,
				marker : {
					enabled : false,
					states : {
						hover : {
							enabled : true,
							radius : 5
						}
					}
				},
				shadow : false,
				states : {
					hover : {
						lineWidth : 1
					}
				},
				threshold : null
			}
		},

		series : []
	});
	return window.detail;
}
