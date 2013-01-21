function getPushData() {

	window.sentAllChart = createDetail([ new Date() ], [], [], [],
			'sentAllPlatform', 'Nombre de Push Envoy\u00e9', 'iOS & Android',
			new Date());
	window.consumedAllChart = createDetail([ new Date() ], [], [], [],
			'consumedAllPlatform', 'Nombre de Push Envoy\u00e9', 'iOS & Android',
			new Date());

	window.iOSChart = createDetail([ new Date() ], [], [], [], 'ios',
			'Nombre de Push Envoy\u00e9', 'iOS', new Date());
	window.androidChart = createDetail([ new Date() ], [], [], [], 'android',
			'Nombre de Push Envoy\u00e9', 'Android', new Date());
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

function updatePushData(appId) {

	var jsonData = '{"appId":"' + appId + '"}';
	jq
			.ajax({
				type : "POST",
				url : 'http://localhost:8080/statistics/service/statistics/generator/relatif/push',
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

					while (window.sentAllChart.series.length > 0) {
						window.sentAllChart.series[0].remove(true); // forces
					}

					while (window.androidChart.series.length > 0) {
						window.androidChart.series[0].remove(true); // forces
					}

					while (window.iOSChart.series.length > 0) {
						window.iOSChart.series[0].remove(true); // forces
					}

					while (window.consumedAllChart.series.length > 0) {
						window.consumedAllChart.series[0].remove(true); // forces
					}

					var startDate = dates[0];

					addDetailSeries(window.sentAllChart, startDate, total,
							'#666600', 'Envoy\u00e9');
					addDetailSeries(window.sentAllChart, startDate, total_sub,
							'#FF6F56', 'Consom\u00e9');

					addDetailSeries(window.iOSChart, startDate, ios, '#666600',
							'Envoy\u00e9');
					addDetailSeries(window.iOSChart, startDate, ios_sub,
							'#FF6F56', 'Consom\u00e9');

					addDetailSeries(window.androidChart, startDate, android,
							'#666600', 'Envoy\u00e9');
					addDetailSeries(window.androidChart, startDate,
							android_sub, '#FF6F56', 'Consom\u00e9');

					addDetailSeries(window.consumedAllChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.consumedAllChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.consumedAllChart, startDate,
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

		series : [ {
			type : 'area',
			name : 'Total',
			pointInterval : 24 * 3600 * 1000,
			pointStart : detailStart,
			data : total
		}, {
			type : 'area',
			name : 'iOS',
			pointInterval : 24 * 3600 * 1000,
			pointStart : detailStart,
			data : ios
		}, {
			type : 'area',
			name : 'Android',
			pointInterval : 24 * 3600 * 1000,
			pointStart : detailStart,
			data : android
		} ]
	});
	return window.detail;
}
