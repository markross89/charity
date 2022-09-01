<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../header.jsp"/>
  <body>
    <header>
      <nav class="container container--70">
        <ul class="nav--actions">
          <li><a href="#">Zaloguj</a></li>
          <li class="highlighted"><a href="#">Załóż konto</a></li>
        </ul>

        <ul>
          <li><a href="<c:url value="/" />" class="btn btn--without-border ">Dom</a></li>
          <li><a href="<c:url value="/donation" />" class="btn btn--without-border ">Start</a></li>
          <li><a href="index.html#steps" class="btn btn--without-border">O co chodzi?</a></li>
          <li><a href="index.html#about-us" class="btn btn--without-border">O nas</a></li>
          <li><a href="index.html#help" class="btn btn--without-border">Fundacje i organizacje</a></li>
          <li><a href="index.html#contact" class="btn btn--without-border">Kontakt</a></li>
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
