
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>


<script type="text/javascript" src="resources/js/stats/pushStats.js"></script>


<script>
	var jq = jQuery.noConflict();

	jq(function() {
		jq("#menu").accordion({
			active : 1
		});
		droplinemenu.buildmenu("droplinetabs1");

	});
</script>



<script>
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

									updatePushData(appId, window.iOSChart);
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

<script>
	jq(document).ready(function() {

		getPushData();

	});
</script>


<ul>
	<li style="display: inline-block;"><label>Applications</label></li>
	<li style="display: inline-block;"><select name="application"
		id="application">
			<!-- 	<option value="">Choisissez une application</option> -->
	</select></li>
</ul>


<table style="width: 900px;">
	<tr style="width: 900px;">
		<td>
			<div id="sentAllPlatform"
				style="min-width: 450px;  margin: 0 auto"></div>
		</td>
		<td>
			<div id="consumedAllPlatform"
				style="min-width: 450px;  margin: 0 auto"></div>
		</td>
	</tr>
	<tr>
		<td>
			<div id="ios" style="min-width: 450px; margin: 0 auto"></div>
		</td>
		<td>
			<div id="android"
				style="min-width: 450px; margin: 0 auto"></div>
		</td>
	</tr>
</table>












<script>
	jq("#application").change(function() {
		updatePushData(jq("#application").val(), window.iOSChart);

	}).change();
</script>


