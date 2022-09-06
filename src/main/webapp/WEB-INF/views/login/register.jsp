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

    <section class="login-page">
      <h2>Załóż konto</h2>

        <form:form   modelAttribute="user" method="post">
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
          <form:input path="firstName" style="margin-left: 170px" class="form-control form-control-user" placeholder="Imię"/>
        </div> <form:errors path="firstName" Class="markus-error"  element="div"/>
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
          <form:input path="lastName" style="margin-left: 170px" class="form-control form-control-user" placeholder="Nazwisko"/>
        </div><form:errors path="lastName" Class="markus-error" />
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
          <form:input path="username" style="margin-left: 170px" class="form-control form-control-user" placeholder="Email"/>
        </div> <form:errors path="username" Class="markus-error" />
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
          <form:password path="password" style="margin-left: 170px" class="form-control form-control-user" placeholder="Hasło"/>
        </div> <form:errors path="password" Class="markus-error" />
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
          <form:password path="passwordRepeat" style="margin-left: 170px" class="form-control form-control-user" placeholder="Powtórz hasło"/>
        </div><form:errors path="passwordRepeat" Class="markus-error" />

        <div class="form-group form-group--buttons" style="margin-left: 195px">

          <button class="btn" type="submit">Załóż konto</button>
        </div>
          </form:form>
    </section>

    <jsp:include page="../footer.jsp"/>
