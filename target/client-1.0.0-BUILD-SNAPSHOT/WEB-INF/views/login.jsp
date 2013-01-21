<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<script src="resources/js/jquery-1.8.3.js"></script>
<script src="resources/js/jquery-ui-1.9.2.custom.js"></script>
<link rel="stylesheet"
	href="resources/css/ui-lightness/jquery-ui-1.9.2.custom.css" />

<script type="text/javascript">
	var jq = jQuery.noConflict();
	alert("test");
</script>

<script>
	jq(function() {
		jq("#submit").button();
		jq("#reset").button();
		jq("#format").buttonset();
	});
</script>


</head>



<body onload='document.f.j_username.focus();'>
	<h3>Login with Username and Password (Custom Page)</h3>

	<c:if test="${not empty error}">
		<div class="errorblock">
			Your login attempt was not successful, try again.<br /> Caused :
			${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
		</div>
	</c:if>

	<form name='f' action="<c:url value='j_spring_security_check' />"
		method='POST'>

		<table>
			<tr>
				<td>User:</td>
				<td><input type='text' name='j_username' value=''></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type='password' name='j_password' /></td>
			</tr>
			<tr>
				<td colspan='2'><input id="submit" name="submit" type="submit"
					value="submit" /></td>
				<td colspan='2'><input id="reset" name="reset" type="reset" /></td>
			</tr>
		</table>

	</form>

</body>
</html>