
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>


<script type="text/javascript" src="resources/js/stats/installStats.js"></script>


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

									updateInstallData(appId,window.allChart);
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

		getInstallData();


	});
</script>


<ul>
	<li style="display: inline-block;"><label>Applications</label></li>
	<li style="display: inline-block;"><select name="application"
		id="application">
			<!-- 	<option value="">Choisissez une application</option> -->
	</select></li>
</ul>



<div id="allPlatform"
	style="min-width: 700px; height: 400px; margin: 0 auto"></div>


	


<script>
	jq("#application").change(function() {
		updateInstallData(jq("#application").val(), window.allChart);

	}).change();
</script>


