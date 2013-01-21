function getLaunchData() {

	window.allChart = createDetail([ new Date() ], [], [], [], 'allPlatform',
			'Nombre d\'installation', 'iOS & Android', new Date());
};

function addDetailSeries(chart, startDate, data, color, name) {
	chart.addSeries({
		
//		area, areaspline, bar, column, line, pie, scatter or spline. From version 2.3, arearange, areasplinerange and columnrange are supported with the highcharts-more.js component. Defaults to line.
		
		type : 'spline',
		name : name,
		pointStart : startDate,
		pointInterval : 24 * 3600 * 1000,
		data : data,
		color : color
	});
}

function updateLaunchData(appId) {

	var jsonData = '{"appId":"' + appId + '"}';
	jq
			.ajax({
				type : "POST",
				url : 'http://localhost:8080/statistics/service/statistics/generator/launch',
				data : jsonData,
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(data) {

					var ios = data.iOS;
					var total = data.total;
					var android = data.android;

					var dates = data.dates;

					while (window.allChart.series.length > 0) {
						window.allChart.series[0].remove(true); // forces
					}

					var startDate = dates[0];

					addDetailSeries(window.allChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.allChart, startDate, ios, '#C3FF99',
							'iOS');
					addDetailSeries(window.allChart, startDate, android,
							'#FF6F56', 'Android');

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

		series : []
	});
	return window.detail;
}
