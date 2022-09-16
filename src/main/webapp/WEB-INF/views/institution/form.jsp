<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../header.jsp"/>
  <body>
    <header style="margin-top: 30px">
      <nav class="container container--70">

        <div class="custom-select">
          <select id="locales" class="select-box">
            <option value="" disabled selected hidden><fmt:message key="lang.change"/></option>
            <option value="en"><fmt:message key="lang.eng"/></option>
            <option value="pl"><fmt:message key="lang.pl"/></option>

          </select>
        </div>
        <ul class="nav--actions">
          <sec:authorize access="isAnonymous()">
            <li><a href="<c:url value="/login" />" class="btn btn--small btn--without-border"><fmt:message key="login.login"/></a></li>
            <li><a href="<c:url value="/register" />" class="btn btn--small btn--highlighted"><fmt:message key="login.register"/></a></li>

          </sec:authorize>
          <sec:authorize access="isAuthenticated()">
            <li class="logged-user" style="margin-top: 6px">
              <sec:authentication property="principal.username"/>
              <ul class="dropdown">
                <sec:authorize access="hasRole('ADMIN')">
                  <li><a href="<c:url value="/institutions"/>"><fmt:message key="login.menu.institutions"/></a></li>
                  <li><a href="<c:url value="/admin"/>"><fmt:message key="login.menu.users"/></a></li>
                </sec:authorize>
                <li><a href="<c:url value="/profile"/>"><fmt:message key="login.menu.profile"/></a></li>
                <li><a href="<c:url value="/userDonations"/>"><fmt:message key="login.menu.donations"/></a></li>
                <li>
                  <form action="<c:url value="/logout"/>" method="post">
                    <input class="logout" type="submit" value="<fmt:message key="login.menu.logout"/>">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                  </form>
                </li>

              </ul>
            </li>
          </sec:authorize>
        </ul>

        <ul>
          <li><a href="<c:url value="/donation" />" class="btn btn--without-border "><fmt:message key="menu.start"/></a></li>
          <li><a href="../#description" class="btn btn--without-border"><fmt:message key="menu.checkout"/></a></li>
          <li><a href="../#about" class="btn btn--without-border"><fmt:message key="menu.about"/></a></li>
          <li><a href="../#institutions" class="btn btn--without-border"><fmt:message key="menu.institutions"/></a></li>
          <li><a href="../#contact" class="btn btn--without-border"><fmt:message key="menu.contact"/></a></li>
        </ul>
      </nav>
    </header>

    <section class="login-page">
      <h2><fmt:message key="institution.add"/></h2>

        <form:form   modelAttribute="institution" method="post" >
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
          <spring:message code="placeholder.title" var="titlePlaceholder"/>
          <form:input path="name" style="margin-left: 170px" class="form-control form-control-user" placeholder="${titlePlaceholder}"/>
        </div> <form:errors path="name" Class="markus-error"  element="div"/>
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
          <spring:message code="placeholder.description" var="descriptionPlaceholder"/>
          <form:textarea path="description" style="margin-left: 65px" class="form-control form-control-user" placeholder="${descriptionPlaceholder}"/>
        </div><form:errors path="description" Class="markus-error" />


        <div class="form-group form-group--buttons" style="margin-left: 210px">

          <button class="btn" type="submit"><fmt:message key="admin.table.add"/></button>
        </div>
          </form:form>
    </section>

    <jsp:include page="../footer.jsp"/>


