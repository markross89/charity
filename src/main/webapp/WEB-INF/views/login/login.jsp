<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../header.jsp"/>
  <body>
    <header style="margin-top: 30px">
      <nav class="container container--70" >
        <ul class="nav--actions">
          <sec:authorize access="isAnonymous()">
            <li><a href="<c:url value="/login" />" class="btn btn--small btn--without-border">Zaloguj</a></li>
            <li><a href="<c:url value="/register" />" class="btn btn--small btn--highlighted">Załóż konto</a></li>
          </sec:authorize>
          <sec:authorize access="isAuthenticated()">
            <li class="logged-user" style="margin-top: 6px">
              <sec:authentication property="principal.username"/>
              <ul class="dropdown">
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

    <section class="login-page" >
      <h2>Zaloguj się</h2>
      <form method="post">
        <div class="form-group" style="margin-left: 180px">
          <input type="email" name="username" placeholder="Email" />
        </div>
        <div class="form-group" style="margin-left: 180px">
          <input type="password" name="password" placeholder="Hasło" />

        </div>

        <div class="form-group form-group--buttons" style="margin-left: 180px">
          <input type="submit"  value="Zaloguj się" class="btn">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </div>
        <a href="#"  style="margin-left: 225px" class="btn btn--small btn--without-border reset-password">Przypomnij hasło</a>
      </form>
    </section>

    <jsp:include page="../footer.jsp"/>
