<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<script>
	var jq = jQuery.noConflict();
	jq(function() {
		jq
				.getJSON(
						'http://localhost:8080/statistics/service/statistics/commons/app/',
						{
							count : this.value
						}, function(responseData) {
							jq.each(responseData, function(index, item) {
								if (index == 0) {
									var appId = item.applicationTechId;

									// 									updatePushData(appId, window.iOSChart);
									// 									updatePushData(appId,window.androidChart);
									// 									updatePushData(appId,window.allChart);
								}

								jq("#application").append(
										jq("<option />").val(
												item.applicationTechId).text(
												item.applicationName));

							});

						});

		jq("#application").val(jq("#application option:first").val());
	});
</script>



<ul>
	<li style="display: inline-block;"><label>Applications</label></li>
	<li style="display: inline-block;"><select name="application"
		id="application">
			<!-- 	<option value="">Choisissez une application</option> -->
	</select></li>
</ul>

<label>Date de cr&eacute;ation :</label>
<label>Nombre de messages envoy&eacute;s :</label>
<label>Nombre d'utilisateur :</label>
<label>Nombre d'abonn&eacute;s au push :</label>
<label>Cat&eacute;gories li&eacute;es :</label>


<ul style="width: 900px;"><!--
	 --><li style="display: inline-block;">
		<div id="keywords" style="width: 450px; margin: 0 auto"></div>
	</li><!--
	 --><li style="display: inline-block;">
		<div id="push" style="width: 450px; margin: 0 auto"></div>
	</li><!-- -->
	<li>
			<div id="pushConsumed" style="width: 900px; margin: 0 auto"></div>
	</li>
</ul>




<script>
	jq(function() {
		var chart;
		jq(document)
				.ready(
						function() {

							// Radialize the colors
							Highcharts.getOptions().colors = Highcharts
									.map(
											Highcharts.getOptions().colors,
											function(color) {
												return {
													radialGradient : {
														cx : 0.5,
														cy : 0.3,
														r : 0.7
													},
													stops : [
															[ 0, color ],
															[
																	1,
																	Highcharts
																			.Color(
																					color)
																			.brighten(
																					-0.3)
																			.get(
																					'rgb') ] // darken
													]
												};
											});

							// Build the chart
							chart = new Highcharts.Chart(
									{
										chart : {
											renderTo : 'keywords',
											plotBackgroundColor : null,
											plotBorderWidth : 1,
											plotShadow : false
										},
										title : {
											text : 'R\u00e9partition des messages par cat\u00e9gories'
										},
										tooltip : {
											pointFormat : '{point.percentage}%</b>',
											percentageDecimals : 1
										},

										legend : {
											enabled : false
										},
										credits : {
											enabled : false
										},
										plotOptions : {
											pie : {
												showInLegend : true,
												size : 200,
												allowPointSelect : true,
												cursor : 'pointer',
												dataLabels : {
													enabled : true,
													color : '#000000',
													connectorColor : '#000000',
													formatter : function() {
														return '<b>'
																+ this.point.name
																+ '</b><br/> '
																+ this.percentage
																+ ' %';
													}
												}
											}
										},
										series : [ {
											type : 'pie',
											name : 'Keywords share',
											data : [ [ 'News', 45.0 ],
													[ 'Update', 26 ],

													[ 'Rappel', 10 ],
													[ 'Promos', 15 ],
													[ 'Urgent', 4 ] ]
										} ]
									});
						});

	});
</script>
<script>
	jq(function() {
		var chart;
		jq(document)
				.ready(
						function() {
							chart = new Highcharts.Chart(
									{
										chart : {
											renderTo : 'push',
											type : 'column'
										},
										title : {
											text : 'Messages envoy\u00e9s par mois'
										},
										xAxis : {
											categories : [ 'Janvier',
													'F\u00e9vrier', 'Mars', 'Avril',
													'Mai' ]
										},
										yAxis : {
											min : 0,
											title : {
												text : 'Messages envoy\u00e9s'
											},
											stackLabels : {
												enabled : true,
												style : {
													fontWeight : 'bold',
													color : (Highcharts.theme && Highcharts.theme.textColor)
															|| 'gray'
												}
											}
										},
										legend : {
											backgroundColor : (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid)
													|| 'white',
											borderColor : '#CCC',
											borderWidth : 1,
											shadow : false
										},

										credits : {
											enabled : false
										},
										tooltip : {
											formatter : function() {
												return '<b>' + this.x
														+ '</b><br/>'
														+ this.series.name
														+ ': ' + this.y
														+ '<br/>' + 'Total: '
														+ this.point.stackTotal;
											}
										},
										plotOptions : {
											column : {
												stacking : 'normal',
												dataLabels : {
													enabled : true,
													color : (Highcharts.theme && Highcharts.theme.dataLabelsColor)
															|| 'white'
												}
											}
										},
										series : [ {
											name : 'iOS',
											data : [ 5, 3, 4, 7, 2 ]
										}, {
											name : 'Android',
											data : [ 2, 2, 3, 2, 1 ]
										} ]
									});
						});

	});
</script>

<script>
	jq(function() {
		var chart;
		jq(document)
				.ready(
						function() {
							chart = new Highcharts.Chart(
									{
										chart : {
											renderTo : 'pushConsumed',
											type : 'column'
										},
										title : {
											text : 'Messages envoy\u00e9s par mois'
										},
										xAxis : {
											categories : [ 'Janvier',
													'F\u00e9vrier', 'Mars', 'Avril',
													'Mai', 'Juin','Juillet' ]
										},
										yAxis : {
											min : 0,
											title : {
												text : 'Messages envoy\u00e9s'
											},
											stackLabels : {
												enabled : true,
												style : {
													fontWeight : 'bold',
													color : (Highcharts.theme && Highcharts.theme.textColor)
															|| 'gray'
												}
											}
										},
										legend : {
											backgroundColor : (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid)
													|| 'white',
											borderColor : '#CCC',
											borderWidth : 1,
											shadow : false
										},

										credits : {
											enabled : false
										},
										tooltip : {
											formatter : function() {
												return '<b>' + this.x
														+ '</b><br/>'
														+ this.series.name
														+ ': ' + this.y
														+ '<br/>' + 'Total: '
														+ this.point.stackTotal;
											}
										},
										plotOptions : {
											column : {
												stacking : 'normal',
												dataLabels : {
													enabled : true,
													color : (Highcharts.theme && Highcharts.theme.dataLabelsColor)
															|| 'white'
												}
											}
										},
										series : [ {
											name : 'Envoy\u00e9',
											data : [ 5, 3, 4, 7, 2,10,30 ]
										}, {
											name : 'Consom\u00e9',
											data : [ 2, 2, 3, 2, 1,5,10 ]
										} ]
									});
						});

	});
</script>