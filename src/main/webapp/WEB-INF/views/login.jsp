<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
<title>Login Page</title>
<style>
.errorblock {
	color: #ff0000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}
</style>
<!-- <link rel="stylesheet" -->
<!-- 	href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" /> -->

<!-- <script type="text/javascript" src="resources/jquery-1.8.3.js"></script> -->


<!-- <link rel="stylesheet" -->
<!-- 	href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" /> -->

<link type="text/css" rel="stylesheet" media="all"
	href="resources/css/common-gestion.css" />
<link type="text/css" rel="stylesheet" media="all"
	href="resources/css/common-gestion-responsive.css" />
<link rel="stylesheet" href="resources/css/main.css" />


<script src="resources/js/jquery-1.8.3.js"></script>
<script src="resources/js/jquery-ui-1.9.2.custom.js"></script>
<link rel="stylesheet"
	href="resources/css/ui-lightness/jquery-ui-1.9.2.custom.css" />


<script type="text/javascript">
	var jq = jQuery.noConflict();
</script>

<script>
	jq(function() {
		jq("#submit").button();

	});
</script>


<title><tiles:insertAttribute name="title" ignore="true" /></title>
<tiles:insertAttribute name="header" />
</head>



<body onload='document.f.j_username.focus();'>

	<c:if test="${not empty error}">
		<div class="errorblock">
			Your login attempt was not successful, try again.<br /> Caused :
			${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
		</div>
	</c:if>

	<form name='f' action="<c:url value='j_spring_security_check' />"
		method='POST' style="text-align: center;">

		<table style="width:50%;">
			<tr>
				<td style="width:50%;text-align: right;">Identifiant :</td>
				<td style="width:50%;"><input  type='text' name='j_username' style="width:50%;" ></td>
			</tr>
			<tr>
				<td style="width:50%;text-align: right;">Mot de passe :</td>
				<td><input type='password' name='j_password' style="width:50%;"/></td>
			</tr>
			<tr>
				<td colspan='2' align="center" ><input id="submit" name="submit" type="submit"
					value="Connexion" width="100%"  /></td>
			</tr>
		</table>

	</form>
	<tiles:insertAttribute name="footer" />
</body>
</html>