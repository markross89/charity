<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <h2><fmt:message key="admin.credentials.message"/></h2>

    <form:form modelAttribute="institution" method="post" action="/editInstitution">
        <form:hidden path="id" value="${institution.id}"/>
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
            <form:input path="name" style="margin-left: 170px" class="form-control form-control-user"
                        placeholder="Nazwa"/>
        </div>
        <form:errors path="name" Class="markus-error" element="div"/>
        <div class="form-group" style="margin-bottom: 10px; margin-top: 20px">
            <form:textarea path="description" style="margin-left: 65px" class="form-control form-control-user"
                           placeholder="Opis"/>
        </div>
        <form:errors path="description" Class="markus-error"/>
        <div class="markus-inline">
            <span >
            <div class="form-group form-group--checkbox">
              <label class="radiobutton">
                <form:radiobutton path="active" value="true"/>

                <span class="checkbox radio"></span>
                <span class="description">
                  <div class="title"><fmt:message key="admin.credentials.on"/></div>

                </span>
              </label>

            </div>
            </span>
            <span style="margin-left: 50px">
            <div class="form-group form-group--checkbox">
                <label class="radiobutton">
                    <form:radiobutton path="active" value="false"/>

                    <span class="checkbox radio"></span>
                    <span class="description">
                  <div class="title"><fmt:message key="admin.credentials.off"/></div>

                </span>
                </label>

            </div>

        </div>
        </span>

        <div class="form-group form-group--buttons" style="margin-left: 210px">

            <button class="btn" type="submit"><fmt:message key="admin.credentials.save"/></button>
        </div>
    </form:form>
</section>

<jsp:include page="../footer.jsp"/>
