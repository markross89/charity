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
    <h2> ${user.firstName} ${user.lastName}</h2>

    <!-- SLIDE 1 -->
    <div>
        <p style="font-size: large">Lista użytkowników: </p>
    </div>
    </section>
    <section class="help" style="width: 100% ">
        <table style="width: 150% " class="users">
            <tr>
                <th>Nr</th>
                <th>Id</th>
                <th>Imię</th>
                <th>Nazwisko</th>
                <th>Email</th>
                <th>Blokada</th>
                <th>Ranga</th>
                <th>Opcje</th>


            </tr>
            <c:forEach items="${users}" var="u">
            <tr>
                <c:set var="counter" value="${counter + 1}"  scope="request" />
                <td>${counter}</td>
                <td>${u.id}</td>
                <td>${u.firstName}</td>
                <td>${u.lastName}</td>
                <td>${u.username}</td>
                <td>${u.enabled}</td>
                <c:forEach items="${u.roles}" var="r">
                    <td> ${r.name}</td>
                </c:forEach>
                <td><a href="<c:url value="/editUser" />" style="color: orange; margin-right: 30px; margin-left: 30px">Edytuj</a><a href="<c:url value="/deleteUser" />" style="color: red">Usuń</a></td>

            </tr>
            </c:forEach>
        </table>
        </section>
</a>
<a id="contact">
<jsp:include page="../footer.jsp"/>
