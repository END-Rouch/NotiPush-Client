
<script src="resources/js/jquery-1.8.3.js"></script>
<script src="resources/js/jquery-ui-1.9.2.custom.js"></script>
<link rel="stylesheet"
	href="resources/css/ui-lightness/jquery-ui-1.9.2.custom.css" />

<script>
	var jq = jQuery.noConflict();
	jq(function() {
		jq("#menu").accordion({
			collapsible : true,
			heightStyle : "content"
		});
		// 		jq("#stats").click(function() {
		// 			jq('#body').children().remove();
		// 			jq('#body').load('graph');

		// 		});
	});
</script>

<div id="menu" style="margin: 20px; width: 200px;">
	<h3>Mes Push</h3>
	<div>
		<ul>
			<li><a href="mainPage">Historique</a></li>
			<li><a href="composePush">Composer un push</a></li>
		</ul>
	</div>
	<h3 id="stats">Mes Stats</h3>
	<div>
		<ul>
			<li><a href="subscription">Enregistrement</a></li>
			<li><a href="push">Push</a></li>
			<li><a href="session">Session</a></li>
			<li><a href="install">Installation</a></li>
			<li><a href="launch">Lancement</a></li>
		</ul>
	</div>
	<h3>Configuration</h3>
	<div>
		<ul>
			<li>List item one</li>
			<li>List item two</li>
			<li>List item three</li>
		</ul>
	</div>
</div>