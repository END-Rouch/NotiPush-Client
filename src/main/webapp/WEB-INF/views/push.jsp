<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<script type="text/javascript" src="resources/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/grid.locale-fr.js"></script>


<link type="text/css" rel="stylesheet" media="all"
	href="resources/css/ui.jqgrid.css" />


<script type="text/javascript"  src="resources/js/jquery-ui-1.9.2.custom.js"></script>

<script type="text/javascript"  src="resources/js/jquery.ui.datepicker-fr.js"></script>

<script>
	var jq = jQuery.noConflict();

	jq(function() {
		jq("#advancedSearch").accordion({
			collapsible : true,
			heightStyle : "content",
			active : false
		});

		droplinemenu.buildmenu("droplinetabs1");
	});

	jq(function() {

		jq("#resetBtn")
				.button({
					icons : {
						primary : "ui-icon-search"
					}
				})
				.click(
						function() {

							jq("#advanceSearchForm")
									.each(
											function() {
												this.reset();
												jq("#jsonmap")
														.setGridParam(
																{
																	url : 'http://localhost:8080/statistics/service/statistics/commons/push/get?appId=&keyword=&creationDateFrom=-1&creationDateTo=-1&publicationDateFrom=-1&publicationDateTo=-1&status=-1&type=-1',
																	page : 1
																}).trigger(
																"reloadGrid");
											});
						});
		jq("#searchBtn")
				.button({
					icons : {
						primary : "ui-icon-search"
					}
				})
				.click(
						function() {
							var appId = jq("#application").val();
							var keyword = jq("#keywords").val();
							var status = jq("#status").val();
							var type = jq("#type").val();
							var creationFrom = jq("#creationFrom").datepicker(
									'getDate');
							var creationTo = jq("#creationTo").datepicker(
									'getDate');
							var publicationFrom = jq("#publicationFrom")
									.datepicker('getDate');
							var publicationTo = jq("#publicationTo")
									.datepicker('getDate');

							var creationFromTime = -1;
							var creationToTime = -1;
							var publicationFromTime = -1;
							var publicationToTime = -1;

							if (creationFrom) {
								creationFromTime = new Date(creationFrom)
										.getTime();
							}
							if (creationTo) {
								creationToTime = new Date(creationTo).getTime();

							}
							if (publicationFrom) {
								publicationFromTime = new Date(publicationFrom)
										.getTime();

							}
							if (publicationTo) {
								publicationToTime = new Date(publicationTo)
										.getTime();

							}

							jq("#jsonmap")
									.setGridParam(
											{
												url : 'http://localhost:8080/statistics/service/statistics/commons/push/get?appId='
														+ appId
														+ '&keyword='
														+ keyword
														+ '&creationDateFrom='
														+ creationFromTime
														+ '&creationDateTo='
														+ creationToTime
														+ '&publicationDateFrom='
														+ publicationFromTime
														+ '&publicationDateTo='
														+ publicationToTime
														+ '&status='
														+ status
														+ '&type=' + type,
												page : 1
											}).trigger("reloadGrid");
						});
	});
</script>
<div id=advancedSearch style="margin-Top: 40px; margin-bottom: 20px; width: 900px;">
	<label>Recherche avancée :</label>

	<div id="advanceSearchDetails" style="display: none;">
		<form id="advanceSearchForm">

			<ul style="margin-top: 10px; margin-bottom: 10px;">
				<li style="display: inline-block;"><label>Applications
						:</label> <select name="application" id="application">
						<option value="">Choisissez une application</option>
				</select></li>

				<li style="display: inline-block;"><label>Catégories :</label>
					<select name="keywords" id="keywords">
						<option value="">Choisissez une catégorie</option>
				</select></li>

				<li style="display: inline-block;"><label>Status :</label> <select
					name="status" id="status">
						<option value="-1">Choisissez un status</option>
						<option value="1">Envoyé</option>
						<option value="2">En Attente</option>
						<option value="3">Annulé</option>
				</select></li>

				<li style="display: inline-block;"><label>Type :</label> <select
					name="type" id="type">
						<option value="-1">Choisissez un type</option>
						<option value="1">Manuel</option>
						<option value="2">Programé</option>
						<option value="3">Externe (à changer !!! )</option>
				</select></li>
			</ul>
			<ul>
				<li style="display: inline-block;"><label>Date de
						création :</label>
					<ul style="margin: 10px;">
						<li style="display: inline-block;"><label for="creationFrom">Entre</label>
						</li>
						<li style="display: inline-block;"><input type="text"
							id="creationFrom" name="creationFrom" /></li>
						<li style="display: inline-block;"><label for="creationTo">et</label>
						</li>
						<li style="display: inline-block;"><input type="text"
							id="creationTo" name="creationTo" /></li>
					</ul></li>
				<li style="display: inline-block;"><label>Date de
						publication :</label>
					<ul style="margin: 10px;">
						<li style="display: inline-block;"><label
							for="publicationFrom">Entre</label></li>
						<li style="display: inline-block;"><input type="text"
							id="publicationFrom" name="publicationFrom" /></li>
						<li style="display: inline-block;"><label for="creationTo">et</label>
						</li>
						<li style="display: inline-block;"><input type="text"
							id="publicationTo" name="publicationTo" /></li>
					</ul></li>
			</ul>





		</form>

		<ul>
			<li style="display: inline-block;">
				<button id="resetBtn">Réinitialiser</button>
			</li>
			<li style="display: inline-block;">
				<button id="searchBtn">Rechercher</button>
			</li>
		</ul>
	</div>
</DIV>


<table id="jsonmap" style="width: 80%;"></table>
<div id="pjmap" style="width: 80%;"></div>
<script type="text/javascript">
	jQuery("#jsonmap")
			.jqGrid(
					{
						scrollOffset:0,
						width:900,
						height : 250,
						url : 'http://localhost:8080/statistics/service/statistics/commons/push/get?appId=&keyword=&creationDateFrom=-1&creationDateTo=-1&publicationDateFrom=-1&publicationDateTo=-1&status=-1&type=-1',
						datatype : "json",
						colNames : [ 'id', 'Status', 'Date de création',
								'Date de publication', 'Application', 'Type',
								'Message', 'Catégorie',
								'Destinataires' ],
						colModel : [
								{
									name : 'id',
									index : 'id',
									hidden : true
								},
								{
									name : 'status',
									index : 'status',
									formatter : function(cellValue, options) {
										if (cellValue == '1') {
											return 'Envoyé';
										} else if (cellValue == '2') {
											return 'En attente';
										} else if (cellValue == '3') {
											return 'Annulé';
										} else {
											return 'Non défini';
										}
									}
								},
								{
									name : 'creationDate',
									index : 'creationDate',
									formatter : function(cellValue, options) {
										if (cellValue) {
											return jq.fmatter.util
													.DateFormat(
															'',
															new Date(+cellValue),
															'ShortDate',
															jq
																	.extend(
																			{},
																			jq.jgrid.formatter.date,
																			options));
										} else {
											return '';
										}
									}
								},
								{
									name : 'publicationDate',
									index : 'publicationDate',
									formatter : function(cellValue, options) {
										if (cellValue) {
											return jq.fmatter.util
													.DateFormat(
															'',
															new Date(+cellValue),
															'ShortDate',
															jq
																	.extend(
																			{},
																			jq.jgrid.formatter.date,
																			options));
										} else {
											return '';
										}
									}
								}, {
									name : 'application',
									index : 'application'
								}, {
									name : 'type',
									index : 'type',
									formatter : function(cellValue, options) {
										if (cellValue == '1') {
											return 'Manuel';
										} else if (cellValue == '2') {
											return 'Programé';
										} else if (cellValue == '3') {
											return 'Externe';
										} else {
											return 'Non défini';
										}
									}
								}, {
									name : 'message',
									index : 'message'
								}, {
									name : 'keyword',
									index : 'keyword'
								}, {
									name : 'number',
									index : 'number'
								} ],
						rowNum : 10,
						rowList : [ 10, 20, 30 ],
						pager : '#pjmap',
						sortname : 'creationDate',
						viewrecords : true,
						sortorder : "desc",
						jsonReader : {
							repeatitems : false,
							id : "0",
							root : "rows"
						},
						onSelectRow : function(id, status) {
							if (!status)
								alert(id);

						},
						caption : "Historique des messages",
					});
	jQuery("#jsonmap").jqGrid('navGrid', '#pjmap', {
		edit : false,
		add : false,
		del : false,
		search : false,
		refresh : false
	});
</script>

<script>
	jq(function() {

		jq("#advanceSearch").click(function() {
			jq("#advanceSearchDetails").toggle("slow");
			return true;
		});
	});

	jq(function() {
		jq("#creationFrom").datepicker(
				{
					defaultDate : "+1w",
					changeMonth : true,
					numberOfMonths : 1,
					onClose : function(selectedDate) {
						jq("#creationTo").datepicker("option", "minDate",
								selectedDate);
					}
				});

// 		jq("#creationFrom").datepicker( jq.datepicker.regional[ "fr" ] );

		jq("#creationTo").datepicker(
				{
					defaultDate : "+1w",
					changeMonth : true,
					numberOfMonths : 1,
					onClose : function(selectedDate) {
						jq("#creationFrom").datepicker("option", "maxDate",
								selectedDate);
					}
				});

		jq("#publicationFrom").datepicker(
				{
					defaultDate : "+1w",
					changeMonth : true,
					numberOfMonths : 1,
					onClose : function(selectedDate) {
						jq("#publicationTo").datepicker("option", "minDate",
								selectedDate);
					}
				});
		jq("#publicationTo").datepicker(
				{
					defaultDate : "+1w",
					changeMonth : true,
					numberOfMonths : 1,
					onClose : function(selectedDate) {
						jq("#publicationFrom").datepicker("option", "maxDate",
								selectedDate);
					}
				});

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

	});
</script>
