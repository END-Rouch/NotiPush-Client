<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link type="text/css" rel="stylesheet" media="all"
	href="resources/css/common-gestion.css" />
<link type="text/css" rel="stylesheet" media="all"
	href="resources/css/common-gestion-responsive.css" />
<!-- <link rel="stylesheet" href="resources/css/main.css" /> -->


<link rel="stylesheet" type="text/css"
	href="resources/css/droplinetabs.css" />

<script src="resources/js/jquery-1.8.3.js"></script>
<script src="resources/js/jquery-ui-1.9.2.custom.js"></script>
<link rel="stylesheet"
	href="resources/css/ui-lightness/jquery-ui-1.9.2.custom.css" />


<script src="resources/js/droplinemenu.js" type="text/javascript"></script>



<header>
	<div class="inner">
		<h1 id="logo">In-Tact</h1>

		<c:if test="${not empty userName}">


			<section id="infos">
				<aside>
					<h3 id="hello">
						Bonjour, <span class="user-name"> ${userName}</span>
					</h3>
					<a id="logout" href="<c:url value="/j_spring_security_logout" />">
						${logout}</a>
				</aside>
			</section>
		</c:if>
		<h2 class="city-name">${appName }</h2>
	</div>
</header>
<c:if test="${not empty userName}">
	<div id="droplinetabs1" class="droplinetabs">
		<ul>
			<li><a href="mainPage"><span>Home</span></a></li>
			<li><a href="#"><span>Mes Push</span></a>
				<ul>
					<li><a href="history">Historique</a></li>
					<li><a href="composePush">Composer un Push</a></li>
				</ul></li>
			<li><a href="#"><span>Mes Stats</span></a>
				<ul>
					<li><a href="subscription">Enregistrement</a></li>
					<li><a href="push">Push</a></li>
					<li><a href="session">Session</a></li>
					<li><a href="install">Installation</a></li>
					<li><a href="launch">Lancement</a></li>
				</ul></li>
			<li><a href="#"><span>Configuration</span></a>
				<ul>
					<li><a href="#">item</a></li>
					<li><a href="#">item</a></li>
				</ul></li>


		</ul>
	</div>
</c:if>
<script type="text/javascript">
	droplinemenu.buildmenu("droplinetabs1");
</script>
