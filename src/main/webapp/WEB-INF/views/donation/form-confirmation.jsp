<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../header.jsp"/>
  <body>
    <header class="header--form-page" style="margin-top: 30px">
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

      <div class="slogan container container--90">
          <h2>
            Dziękujemy za przesłanie formularza Na maila prześlemy wszelkie
            informacje o odbiorze.
          </h2>
      </div>
    </header>

    <jsp:include page="../footer.jsp"/>
