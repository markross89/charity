<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../header.jsp"/>
<body>
<header style="margin-top: 30px">
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
                        <li>
                            <form action="<c:url value="/logout"/>" method="post">
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

<section class="login-page">
    <h2>${user.firstName} ${user.lastName}</h2>

    <form:form modelAttribute="user" method="post" action="/editCredentials">
        <form:hidden path="id" value="${user.id}"/>
        <form:hidden path="firstName" value="${user.firstName}"/>
        <form:hidden path="lastName" value="${user.lastName}"/>
        <form:hidden path="username" value="${user.username}"/>
        <form:hidden path="password" value="${user.password}"/>

        <h1 style="margin-left: 210px; margin-bottom: 50px">Modyfikuj Dane:</h1>
        <div class="markus-inline" >

            <c:forEach items="${roles}" var="i">
                <div class="form-group form-group--checkbox">
                    <label class="container">
                        <form:checkbox path="roles" value="${i}"  title="${i.name}"/>

                        <span class="checkbox radio" ></span>
                        <span class="description">
                                <div class="title">${i.name}</div></span>
                    </label>

                </div>
            </c:forEach>
            <form:errors path="roles" Class="markus-error" element="div"/>
        </div>


        <div class="markus-inline">
            <span >
            <div class="form-group form-group--checkbox">
              <label class="radiobutton" style="margin-left: 15px">
                <form:radiobutton path="enabled" value="1"/>

                <span class="checkbox radio"></span>
                <span class="description">
                  <div class="title">Włącz</div>

                </span>
              </label>

            </div>
            </span>
            <span style="margin-left: 50px">
            <div class="form-group form-group--checkbox" style="margin-left: 10px">
                <label class="container" style="margin-left: 20px">
                    <form:radiobutton path="enabled" value="0"/>

                    <span class="checkbox radio"></span>
                    <span class="description">
                  <div class="title">Wyłącz</div>

                </span>
                </label>

            </div>
          </span>

        </div>

        <div class="form-group form-group--buttons" style="margin-left: 210px">

            <button class="btn" type="submit">Zapisz</button>
        </div>
    </form:form>
</section>

<jsp:include page="../footer.jsp"/>
