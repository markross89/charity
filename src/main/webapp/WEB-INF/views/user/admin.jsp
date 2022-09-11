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

<section class="help">
    <h2> ${user.firstName} ${user.lastName}</h2>

    <!-- SLIDE 1 -->
    <div>
        <p style="font-size: large"><fmt:message key="admin.users.list"/>: </p>
    </div>
    </section>
    <section class="help" style="width: 100% ">
        <table style="width: 150% " class="users">
            <tr>
                <th>Nr</th>
                <th>Id</th>
                <th><fmt:message key="admin.users.firstname"/></th>
                <th><fmt:message key="admin.users.lastname"/></th>
                <th><fmt:message key="admin.users.email"/></th>
                <th><fmt:message key="admin.users.active"/></th>
                <th><fmt:message key="admin.users.role"/></th>
                <th><fmt:message key="admin.users.options"/></th>


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
                <td>
                <c:forEach items="${u.roles}" var="r">
                    ${r.name} &nbsp &nbsp
                </c:forEach>
                </td>
                <td><a href="<c:url value="/editCredentials/${u.id}" />" style="color: orange"><fmt:message key="admin.table.edit"/></a></td>

            </tr>
            </c:forEach>
        </table>
        </section>
</a>
<a id="contact">
<jsp:include page="../footer.jsp"/>
