<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>
</head>
<body>





	<table border="0" align="center" width="900px">
		<tr>
			<td height="30" colspan="2"><tiles:insertAttribute name="header" />
			</td>
		</tr>
		<tr>
<%-- 			<td style="vertical-align: top;"><tiles:insertAttribute --%>
<%-- 					name="menu" /></td> --%>
			<td id="body"><tiles:insertAttribute name="body" /></td>
		</tr>
		<tr>
			<td height="30" colspan="2"><tiles:insertAttribute name="footer" />
			</td>
		</tr>
	</table>
</body>

<div id="dialog" title="" style="visibility: hidden;">
	<p>Message envoyé</p>
</div>
</html>
