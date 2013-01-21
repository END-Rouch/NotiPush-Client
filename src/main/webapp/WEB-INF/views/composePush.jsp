<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>



<script type="text/javascript"
	src="http://jzaefferer.github.com/jquery-validation/jquery.validate.js"></script>
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript"
	src="resources/js/jquery-ui-timepicker-addon.js"></script>

<script type="text/javascript"  src="resources/js/jquery.ui.datepicker-fr.js"></script>

<script type="text/javascript"  src="resources/js/localization/jquery-ui-timepicker-fr.js"></script>


<script>
	var jq = jQuery.noConflict();
	jq(document).ready(function() {
		jq.extend(jQuery.validator.messages, {
			required : "Champ obligatoire",
		});

		droplinemenu.buildmenu("droplinetabs1");

		jq("#composePushForm").validate({
			rules : {

				"message" : {
					"required" : true,
					"minlength" : 2,
					"maxlength" : 60000

				},

				"application" : {
					"required" : true
				},

				"platform" : {
					"required" : true
				},
				"radio" : {
					"required" : true
				}
			}
		});

		jq("#composePushForm").submit(function() {
			return false;
		});
	});
</script>


<script>
	var jq = jQuery.noConflict();
	jq(function() {
		jq("#platform").buttonset();
		jq("#radio").buttonset();

		jq("#publicationTime").datetimepicker({

			numberOfMonths : 1,
			minDate : 0,
			showOn : "both",
			buttonImageOnly : false,
// 			currentText : 'Maintenant',
// 			closeText : 'Valider',
// 			timeOnlyTitle : 'Choix de la date',
// 			timeText : 'Horaire',
// 			hourText : 'Heure',
// 			minuteText : 'Minute',
// 			secondText : 'Seconde',

		});
// 		jq("#publicationTime").datepicker.setDefaults(jq.timepicker.regional['fr']);
// 		jq(function() {
// 			jq("#publicationTime").datetimepicker( {
// 				currentText : 'Maintenant',
// 				closeText : 'Valider',
// 				ampm : false,
// 				timeFormat : 'hh:mm tt',
// 				timeSuffix : '',
// 				timeOnlyTitle : 'Choix de la date',
// 				timeText : 'Horaire',
// 				hourText : 'Heure',
// 				minuteText : 'Minute',
// 				secondText : 'Seconde',
// 				timezoneText : 'Zone'
// 			});
// 			jq("#publicationTime").datetimepicker.setDefaults(jq.timepicker.regional['fr']);
// // 			jq.datepicker.setDefaults(jq.timepicker.regional['fr']);
// 		});


jq( "#publicationTime" ).datepicker( jq.datepicker.regional[ "fr" ] )

		jq
				.getJSON(
						'http://localhost:8080/statistics/service/statistics/commons/app/',
						{
							count : this.value
						}, function(responseData) {
							jq.each(responseData, function(index, item) {
								jq("#application").append(
										jq("<option />").val(
												item.applicationTechId).text(
												item.applicationName));
							});
						});

		jq
				.getJSON(
						'http://localhost:8080/statistics/service/statistics/commons/push/keywords',
						{
							count : this.value
						}, function(responseData) {
							jq.each(responseData, function(index, item) {
								console.log(item);
								jq("#keywords").append(
										jq("<option />").val(item).text(item));

							});

						});
		jq("#resetBtn").button({
			icons : {
				primary : "ui-icon-reset"
			}
		}).click(function() {

			jq("#composePushForm").each(function() {
				this.reset();

			});
		});

		jq("#validateBtn")
				.button({
					icons : {
						primary : "ui-icon-search"
					}
				})
				.click(
						function() {

							console.log(jq("#composePushForm").validate()
									.form());

							if (jq("#composePushForm").validate().form()) {
								var isForIOS = jq('#ios').prop('checked');
								var isForAndroid = jq('#android').prop(
										'checked');
								var message = jq("#message").val();
								var keyword = jq("#keywords").val();
								var publicationDate = new Date();
								var type = 1;
								var status = 0;
								if (jq('#later').prop('checked') == true) {
									type = 2;
									publicationDate = jq("#publicationTime")
											.datepicker('getDate');
								}

								if (keyword == '') {
									keyword = jq("#keyInput").val();
								}
								var url = '';
								var data = '';
								if (isForIOS == true && isForAndroid == true) {
									url = 'http://localhost:8080/intact/service/notifications/commons/notifyApp/';
									data = '{"alert":"' + message
											+ '","keyword":"' + keyword
											+ '","type":' + type + '}';

								} else if (isForIOS == true
										&& isForAndroid == false) {
									url = 'http://localhost:8080/intact/service/notifications/ios/notifyApp/';
									data = '{"alert":"' + message
											+ '","keyword":"' + keyword
											+ '","type":' + type + '}';
								} else if (isForIOS == false
										&& isForAndroid == true) {
									var title = jq("#title").val();
									var ticker = jq("#ticker").val();
									url = 'http://localhost:8080/intact/service/notifications/android/notifyApp/';
									data = '{"text":"' + message
											+ '","keyword":"' + keyword
											+ '","type":' + type + ',"title":"'
											+ title + '","ticker":"' + ticker
											+ '"}';
								}

								url = url + jq("#application").val();
								console.log(url);
								console.log(data);

								jq
										.ajax({
											type : "POST",
											url : url,
											data : data,
											dataType : "json",
											contentType : "application/json; charset=utf-8",
											success : function(data) {

												console.log('success');
												jq("#dialog")
														.dialog(
																{
																	modal : true,
																	buttons : {
																		Ok : function() {
																			jq(
																					this)
																					.dialog(
																							"close");
																		}
																	}
																});

											}

										});
							}

						});

		jq("#ios").click(function() {

			var isChecked = jq('#ios').prop('checked');

			if (isChecked == true) {
				jq("#title").prop('disabled', true);
				jq("#ticker").prop('disabled', true);
				jq("#caracters").show();

			} else {
				jq("#title").prop('disabled', false);
				jq("#ticker").prop('disabled', false);
				jq("#caracters").hide();
			}

		});

		jq("#now").click(function() {

			var isChecked = jq('#now').prop('checked');
			if (isChecked == true) {
				jq("#publicationTime").datepicker('disable');

			}

		});

		jq("#later").click(function() {

			var isChecked = jq('#later').prop('checked');
			if (isChecked == true) {
				jq("#publicationTime").datepicker('enable');

				jq("#publicationTime").datepicker('show');

			}

		});

	});
</script>


<form id="composePushForm" style="width: 700px;" class="cmxform"
	action="">
	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			style="width: 150px; text-align: right;"
			style="width: 150px; text-align: right;">Application *</label></li>
		<li style="display: inline-block; vertical-align: middle;"><select
			style="width: 250px;" name="application" id="application">
				<option value="">Choisissez une application</option>
		</select></li>
	</ul>

	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			style="width: 150px; text-align: right;">Plateforme *</label></li>
		<li style="display: inline-block; vertical-align: middle;">
			<div id="platform" style="width: 250px;">
				<input type="checkbox" id="ios" name="platform" /> <label
					style="width: 50%; text-align: center;" for="ios">iOS</label> <input
					type="checkbox" id="android" name="platform" /> <label
					style="width: 50%; text-align: center;" for="android">Android</label>

			</div>
		</li>
	</ul>

	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			style="width: 150px; text-align: right;">Date d'envoie *</label></li>

		<li id="radio"
			style="display: inline-block; width: 250px; vertical-align: middle;"><input
			type="radio" id="now" name="radio" /> <label
			style="width: 50%; text-align: center;" for="now">Imm&eacute;diat</label>
			<input type="radio" id="later" name="radio" /> <label
			style="width: 50%; text-align: center;" for="later">Diff&eacute;r&eacute;</label></li>
	</ul>

	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			style="width: 150px; text-align: right; vertical-align: middle;"></label></li>
		<li style="display: inline-block; vertical-align: middle;">
			<div id="picker">
				<input type="text" id="publicationTime" name="publicationTime"
					style="width: 220px;" />

			</div>
		</li>
	</ul>

	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			id="titleLabel" style="width: 150px; text-align: right;">Titre</label></li>
		<li style="display: inline-block; vertical-align: middle;"><input
			type="text" id="title" name="title" style="width: 250px;" /></li>
	</ul>

	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			id="tickerLabel" style="width: 150px; text-align: right;">Ticker</label></li>
		<li style="display: inline-block; vertical-align: middle;"><input
			type="text" id="ticker" name="ticker" style="width: 250px;" /></li>
	</ul>


	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			style="width: 150px; text-align: right;">Cat&eacute;gorie</label></li>
		<li style="display: inline-block; vertical-align: middle;"><select
			style="width: 250px;" name="keywords" id="keywords">
				<option value="">Choisissez une cat&eacute;gorie</option>
		</select></li>

	</ul>
	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			style="width: 150px; text-align: right;"></label></li>

		<li style="display: inline-block; width: 115px;">Cr&eacute;er une
			nouvelle</li>
		<li style="display: inline-block; vertical-align: middle;"><input
			type="text" id="keyInput" name="title" style="width: 130px;" /></li>
	</ul>

	<ul style="margin: 20px;">
		<li style="display: inline-block; vertical-align: middle;"><label
			style="width: 150px; text-align: right;">Message *</label></li>
		<li style="display: inline-block; vertical-align: middle;"><textarea
				rows="6" cols="40" id="message" name="message" style="width: 250px;"></textarea></li>
		<!-- 		<li style="display: inline-block; vertical-align: middle;"> -->
		<!-- 		<label -->
		<!-- 			id="caracters" style="width: 150px; text-align: right;">236 -->
		<!-- 				caracteres</label></li> -->
	</ul>




	<ul style="margin: 20px;">
		<li
			style="display: inline-block; vertical-align: middle; margin-left: 200px;">
			<button id="validateBtn">Valider</button>
		</li>
		<li style="display: inline-block; vertical-align: middle;"><button
				id="resetBtn">R&eacute;initialiser</button></li>
	</ul>

</form>