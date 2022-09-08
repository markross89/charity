<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../header.jsp"/>
<body>
<a id="#description">
<header  style="margin-top: 30px">
    <nav class="container container--70">

        <ul class="nav--actions">
            <sec:authorize access="isAnonymous()">
                <li><a href="<c:url value="/login" />" class="btn btn--small btn--without-border">Zaloguj</a></li>
                <li><a href="<c:url value="/register" />" class="btn btn--small btn--highlighted">Załóż konto</a></li>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <li class="logged-user" style="margin-top: 6px">
                    <sec:authentication property="principal.username"/>
                    <ul class="dropdown">
                        <sec:authorize access="hasRole('ADMIN')">
                            <li><a href="<c:url value="/institutions"/>">Fundacje</a></li>
                            <li><a href="<c:url value="/admin"/>">Użytkownicy</a></li>
                        </sec:authorize>
                        <li><a href="<c:url value="/profile"/>">Profil</a></li>
                        <li><a href="<c:url value="/userDonations"/>">Moje zbiórki</a></li>
                        <li> <form action="<c:url value="/logout"/>" method="post">
                            <input class="logout" type="submit" value="Wyloguj">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                        </li>

                    </ul>
                </li>
            </sec:authorize>
        </ul>

        <ul>
            <li><a href="<c:url value="/donation" />" class="btn btn--without-border ">Start</a></li>
            <li><a href="../#description" class="btn btn--without-border">O co chodzi?</a></li>
            <li><a href="../#about" class="btn btn--without-border">O nas</a></li>
            <li><a href="../#institutions" class="btn btn--without-border">Fundacje i organizacje</a></li>
            <li><a href="../#contact" class="btn btn--without-border">Kontakt</a></li>
        </ul>
    </nav>

</header>

<section class="help">
    <h2>${user.firstName} ${user.lastName}</h2>

    <!-- SLIDE 1 -->
    <div class="help--slides active" data-id="1">
        <p>Przekazane dary</p>

        <ul class="help--slides-items">
            <c:forEach items="${donations}" var="d">
            <li>
                <c:forEach items="${d}" var="e">
                <c:set var="counter" value="${counter + 1}"  scope="request" />
                <div class="col">
                    <div class="font-markus" style="font-weight: bold">${counter}</div>
                    <div class="font-markus">
                        <c:forEach items="${e.category}" var="u">
                            ${u.name}
                        </c:forEach> przekazane dla Fundacji
                    </div>
                    <div class="title">"${e.institution.name}"</div>
                    <div class="font-markus">worki: ${e.quantity}</div>
                    <div class="font-markus"> Data odbioru: ${e.pickUpDate} </div>
                    <div class="font-markus"> Adres odbioru:  </div>
                    <div class="font-markus"> ul. ${e.street}</div>
                    <div class="font-markus"> ${e.city}, ${e.postCode}</div>
                    <p>
                        <jsp:useBean id="today" class="java.util.Date" />
                        <fmt:parseDate value="${e.pickUpDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                        <fmt:formatDate value="${parsedDate}" var="newDate"  pattern="dd-MM-yyyy" />
                        <fmt:formatDate value="${today}" var="todayDate" pattern="dd-MM-yyyy " />
                    </p>
                    <div class="font-markus" style="display: inline">Status:
                        <c:choose>
                            <c:when test="${todayDate gt newDate}">
                                <div style="color: green"> Wysłane</div>
                            </c:when>
                            <c:otherwise>
                                <div style="color: orange">  Oczekuje na kuriera</div>
                                <div style="margin-top: 10px"><a href="<c:url value="/updateDonation/${e.id}" />" style="color: red; font-weight: bold; font-size: small">edytuj</a></div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                </c:forEach>
            </li>
            </c:forEach>
        </ul>
    </div>
</section>
</a>
<a id="contact">
<jsp:include page="../footer.jsp"/>
