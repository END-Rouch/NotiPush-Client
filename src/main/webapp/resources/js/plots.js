function createCharts(isForSubscription, dates, ios, android, total,
		masterContainer, detailContainer, divId, title, subtitle) {

	var startDate = dates[0];
	var endDate = dates[dates.length - 1];

	// create the master chart
	function createSubMaster() {
		window.masterTmp = new Highcharts.Chart(
				{
					chart : {
						renderTo : masterContainer,
						reflow : false,
						borderWidth : 0,
						backgroundColor : null,
						marginLeft : 50,
						marginRight : 20,
						zoomType : 'x',
						events : {

							// listen to the selection event
							// on the master chart to update
							// the
							// extremes of the detail chart
							selection : function(event) {
								var extremesObject = event.xAxis[0], min = extremesObject.min, max = extremesObject.max, detailData = [], xAxis = this.xAxis[0];
								var detailIOS = [];
								var detailAndroid = [];
								// reverse engineer the last
								// part of the data
								jQuery.each(this.series[0].data, function(i,
										point) {
									if (point.x > min && point.x < max) {
										detailData.push({
											x : point.x,
											y : point.y
										});
									}
								});
								jQuery.each(this.series[1].data, function(i,
										point) {
									if (point.x > min && point.x < max) {
										detailIOS.push({
											x : point.x,
											y : point.y
										});
									}
								});
								jQuery.each(this.series[2].data, function(i,
										point) {
									if (point.x > min && point.x < max) {
										detailAndroid.push({
											x : point.x,
											y : point.y
										});
									}
								});
								// move the plot bands to
								// reflect the new detail
								// span
								xAxis.removePlotBand('mask-before1');
								xAxis.addPlotBand({
									id : 'mask-before1',
									from : startDate,
									to : min,
									color : 'rgba(0, 0, 0, 0.2)'
								});

								xAxis.removePlotBand('mask-after');
								xAxis.addPlotBand({
									id : 'mask-after1',
									from : max,
									to : endDate,
									color : 'rgba(0, 0, 0, 0.2)'
								});
								if (isForSubscription == true) {
									window.detailSubChart.series[0]
											.setData(detailData);
									window.detailSubChart.series[1]
											.setData(detailIOS);
									window.detailSubChart.series[2]
											.setData(detailAndroid);
								} else {
									window.detailUnsubChart.series[0]
											.setData(detailData);
									window.detailUnsubChart.series[1]
											.setData(detailIOS);
									window.detailUnsubChart.series[2]
											.setData(detailAndroid);
								}
								return false;
							}
						}
					},
					title : {
						text : null
					},
					xAxis : {
						type : 'datetime',
						showLastTickLabel : true,
						maxZoom : 14 * 24 * 3600000, // fourteen
						// days
						plotBands : [ {
							id : 'mask-before1',
							from : startDate,
							to : endDate,
							color : 'rgba(0, 0, 0, 0.2)'
						} ],
						title : {
							text : null
						}
					},
					yAxis : {
						gridLineWidth : 0,
						labels : {
							enabled : false
						},
						title : {
							text : null
						},
						min : 0.6,
						showFirstLabel : false
					},
					tooltip : {
						shared : true
					},
					legend : {
						enabled : false
					},
					credits : {
						enabled : false
					},
					plotOptions : {
						series : {
							fillColor : {
								linearGradient : [ 0, 0, 0, 70 ],
								stops : [ [ 0, '#4572A7' ],
										[ 1, 'rgba(0,0,0,0)' ] ]
							},
							lineWidth : 1,
							marker : {
								enabled : false
							},
							shadow : false,
							states : {
								hover : {
									lineWidth : 1
								}
							},
							enableMouseTracking : false
						}
					},

					series : [ {
						type : 'area',
						pointInterval : 24 * 3600 * 1000,
						pointStart : startDate,
						data : total
					}, {
						type : 'area',
						pointInterval : 24 * 3600 * 1000,
						pointStart : startDate,
						data : ios
					}, {
						type : 'area',
						pointInterval : 24 * 3600 * 1000,
						pointStart : startDate,
						data : android
					} ],

					exporting : {
						enabled : false
					}

				}, function(masterChart) {
					window.detailTmp = createSubDetail(masterChart);
				});

		return {
			master : window.masterTmp,
			detail : window.detailTmp
		};
	}

	// create the detail chart
	function createSubDetail(masterChart) {

		// prepare the detail chart
		var detailData = [], detailIOS = [], detailAndroid = [], detailStart = startDate;

		jQuery.each(masterChart.series[0].data, function(i, point) {
			if (point.x >= detailStart) {
				detailData.push(point.y);
			}
		});
		jQuery.each(masterChart.series[1].data, function(i, point) {
			if (point.x >= detailStart) {
				detailIOS.push(point.y);
			}
		});
		jQuery.each(masterChart.series[2].data, function(i, point) {
			if (point.x >= detailStart) {
				detailAndroid.push(point.y);
			}
		});
		// create a detail chart referenced by a global
		// variable
		var detail = new Highcharts.Chart({
			chart : {
				marginBottom : 120,
				renderTo : detailContainer,
				reflow : false,
				marginLeft : 50,
				marginRight : 20,
				style : {
					position : 'absolute'
				}
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
				type : 'datetime'
			},
			yAxis : {
				title : {
					text : null
				},
				maxZoom : 0.1
			},
			tooltip : {

				shared : true
			},
			legend : {
				enabled : false
			},
			plotOptions : {
				series : {
					marker : {
						enabled : false,
						states : {
							hover : {
								enabled : true,
								radius : 3
							}
						}
					}
				}
			},
			series : [ {
				name : 'Total',
				pointStart : detailStart,
				pointInterval : 24 * 3600 * 1000,
				data : detailData
			}, {
				name : 'iOS',
				pointStart : detailStart,
				pointInterval : 24 * 3600 * 1000,
				data : detailIOS
			}, {
				name : 'Android',
				pointStart : detailStart,
				pointInterval : 24 * 3600 * 1000,
				data : detailAndroid
			} ],

			exporting : {
				enabled : true
			}

		});

		return detail;
	}

	// make the container smaller and add a second container
	// for the master chart
	var $container = jq("#" + divId).css('position', 'relative');

	jq('<div id="' + detailContainer + '">').appendTo($container);

	jq('<div id="' + masterContainer + '">').css({
		position : 'absolute',
		top : 300,
		height : 80,
		width : '100%'
	}).appendTo($container);

	// create master and in its callback, create the detail
	// chart
	var graph = createSubMaster();

	return graph;
};

function getSubscriptionData() {

	var graph = createCharts(true, [ new Date() ], [], [], [],
			'master-subscription-container', 'detail-subscription-container',
			"subscription",
			'Nombre d\'enregistrements au service de notifications',
			'Select an area by dragging across the lower chart');

	window.detailSubChart = graph.detail;
	window.masterSubChart = graph.master;
};

function getUnSubscriptionData() {
	var graph = createCharts(false, [ new Date() ], [], [], [],
			'master-unsubscription-container',
			'detail-unsubscription-container', "unsubscription",
			'Nombre de d\u00e9senregistrements du service de notifications',
			'Select an area by dragging across the lower chart');

	window.detailUnsubChart = graph.detail;
	window.masterUnsubChart = graph.master;
};

function getPushData() {
	console.log('get push data');
	var graph = createDetail([ new Date() ], [], [], [], 'subscription',
			'Nombre de Push Envoy\u00e9', 'iOS & Android', new Date());
	console.log(graph);
	window.detailChart = graph;
	console.log('master  ' + window.detailChart);
};

function addMasterSeries(chart, startDate, data, color) {
	chart.addSeries({
		type : 'area',
		pointInterval : 24 * 3600 * 1000,
		pointStart : startDate,
		data : data,
		color : color
	});
}

function addDetailSeries(chart, startDate, data, color, name) {
	chart.addSeries({
		type:'spline',
		name : name,
		pointStart : startDate,
		pointInterval : 24 * 3600 * 1000,
		data : data,
		color : color
	});
}
function updateSubscriptionData(appId) {
	var jsonData = '{"appId":"' + appId + '"}';
	jq
			.ajax({
				type : "POST",
				url : 'http://localhost:8080/statistics/service/statistics/generator/subscribe',
				data : jsonData,
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(data) {

					var ios = data.iOS;
					var android = data.android;
					var total = data.total;
					var dates = data.dates;

					while (window.detailSubChart.series.length > 0) {
						window.detailSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					while (window.masterSubChart.series.length > 0) {
						window.masterSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					var startDate = dates[0];
					addMasterSeries(window.masterSubChart, startDate, total,
							'#666600');
					addMasterSeries(window.masterSubChart, startDate, ios,
							'#C3FF99');
					addMasterSeries(window.masterSubChart, startDate, android,
							'#FF6F56');

					addDetailSeries(window.detailSubChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.detailSubChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.detailSubChart, startDate, android,
							'#FF6F56', 'Android');

				}

			});
};

function updateUnsubscriptionData(appId) {
	var jsonData = '{"appId":"' + appId + '"}';
	jq
			.ajax({
				type : "POST",
				url : 'http://localhost:8080/statistics/service/statistics/generator/unsubscribe',
				data : jsonData,
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(data) {

					var ios = data.iOS;
					var android = data.android;
					var total = data.total;
					var dates = data.dates;

					while (window.detailUnsubChart.series.length > 0) {
						window.detailUnsubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					while (window.masterUnsubChart.series.length > 0) {
						window.masterUnsubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					var startDate = dates[0];
					addMasterSeries(window.masterUnsubChart, startDate, total,
							'#666600');
					addMasterSeries(window.masterUnsubChart, startDate, ios,
							'#C3FF99');
					addMasterSeries(window.masterUnsubChart, startDate,
							android, '#FF6F56');

					addDetailSeries(window.detailUnsubChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.detailUnsubChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.detailUnsubChart, startDate,
							android, '#FF6F56', 'Android');

				}

			});
};

function updatePushData(appId) {

	console.log(appId);
	console.log(window.detailChart);
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
					var android = data.android;
					var total = data.total;
					var dates = data.dates;

					while (window.detailChart.series.length > 0) {
						window.detailChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					// while (window.masterSubChart.series.length > 0) {
					// window.masterSubChart.series[0].remove(true); // forces
					// // the
					// // chart
					// // to
					// // redraw
					// }
					//
					var startDate = dates[0];
					// addMasterSeries(window.masterSubChart, startDate, total,
					// '#666600');
					// addMasterSeries(window.masterSubChart, startDate, ios,
					// '#C3FF99');
					// addMasterSeries(window.masterSubChart, startDate,
					// android,
					// '#FF6F56');

					addDetailSeries(window.detailChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.detailChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.detailChart, startDate, android,
							'#FF6F56', 'Android');

				}

			});
};

function updateSessionData(appId) {

	console.log(appId);
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
					var android = data.android;
					var total = data.total;
					var dates = data.dates;

					while (window.detailSubChart.series.length > 0) {
						window.detailSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					while (window.masterSubChart.series.length > 0) {
						window.masterSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					var startDate = dates[0];
					addMasterSeries(window.masterSubChart, startDate, total,
							'#666600');
					addMasterSeries(window.masterSubChart, startDate, ios,
							'#C3FF99');
					addMasterSeries(window.masterSubChart, startDate, android,
							'#FF6F56');

					addDetailSeries(window.detailSubChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.detailSubChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.detailSubChart, startDate, android,
							'#FF6F56', 'Android');

				}

			});
};

function updateInstallData(appId) {

	console.log(appId);
	var jsonData = '{"appId":"' + appId + '"}';
	jq
			.ajax({
				type : "POST",
				url : 'http://localhost:8080/statistics/service/statistics/generator/install',
				data : jsonData,
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(data) {

					var ios = data.iOS;
					var android = data.android;
					var total = data.total;
					var dates = data.dates;

					while (window.detailSubChart.series.length > 0) {
						window.detailSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					while (window.masterSubChart.series.length > 0) {
						window.masterSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					var startDate = dates[0];
					addMasterSeries(window.masterSubChart, startDate, total,
							'#666600');
					addMasterSeries(window.masterSubChart, startDate, ios,
							'#C3FF99');
					addMasterSeries(window.masterSubChart, startDate, android,
							'#FF6F56');

					addDetailSeries(window.detailSubChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.detailSubChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.detailSubChart, startDate, android,
							'#FF6F56', 'Android');

				}

			});
};

function updateLaunchData(appId) {

	console.log(appId);
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
					var android = data.android;
					var total = data.total;
					var dates = data.dates;

					while (window.detailSubChart.series.length > 0) {
						window.detailSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					while (window.masterSubChart.series.length > 0) {
						window.masterSubChart.series[0].remove(true); // forces
						// the
						// chart
						// to
						// redraw
					}

					var startDate = dates[0];
					addMasterSeries(window.masterSubChart, startDate, total,
							'#666600');
					addMasterSeries(window.masterSubChart, startDate, ios,
							'#C3FF99');
					addMasterSeries(window.masterSubChart, startDate, android,
							'#FF6F56');

					addDetailSeries(window.detailSubChart, startDate, total,
							'#666600', 'Total');
					addDetailSeries(window.detailSubChart, startDate, ios,
							'#C3FF99', 'iOS');
					addDetailSeries(window.detailSubChart, startDate, android,
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
        chart: {
            renderTo: detailContainer,
            zoomType: 'x',
            spacingRight: 20
        },
        credits : {
        	enabled : false
        },
        title: {
            text: title
        },
        subtitle: {
            text: subtitle
        },
        xAxis: {
            type: 'datetime',
            maxZoom: 14 * 24 * 3600000, // fourteen days
            title: {
                text: null
            }
        },
        yAxis: {
            title: {
                text: ''
            },
            showFirstLabel: false
        },
        tooltip: {
            shared: true
        },
        legend: {
            enabled: false
        },

        plotOptions: {
            area: {
                fillColor: {
                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                    stops: [
                        [0, Highcharts.getOptions().colors[0]],
                        [1, 'rgba(2,0,0,0)']
                    ]
                },
                lineWidth: 1,
                marker: {
                    enabled: false,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 5
                        }
                    }
                },
                shadow: false,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                threshold: null
            }
        },

        series: [{
            type: 'area',
            name: 'Total',
            pointInterval: 24 * 3600 * 1000,
            pointStart: detailStart,
            data:total
        },{
            type: 'area',
            name: 'iOS',
            pointInterval: 24 * 3600 * 1000,
            pointStart: detailStart,
            data:ios
        },{
            type: 'area',
            name: 'Android',
            pointInterval: 24 * 3600 * 1000,
            pointStart: detailStart,
            data:android
        }]
    });
	return window.detail;
}
