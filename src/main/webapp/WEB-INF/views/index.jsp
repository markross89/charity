<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="header.jsp"/>
<body>
<a id="#description">
    <header class="header--main-page" style="margin-top: 30px">
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
                <li><a href="#description" class="btn btn--without-border"><fmt:message key="menu.checkout"/></a></li>
                <li><a href="#about" class="btn btn--without-border"><fmt:message key="menu.about"/></a></li>
                <li><a href="#institutions" class="btn btn--without-border"><fmt:message key="menu.institutions"/></a></li>
                <li><a href="#contact" class="btn btn--without-border"><fmt:message key="menu.contact"/></a></li>
            </ul>
        </nav>

        <div class="slogan container container--90">
            <div class="slogan--item">
                <h1>
                    <fmt:message key="home.message"/>
                </h1>
            </div>
        </div>
    </header>

    <section class="stats">
        <div class="container container--85">
            <div class="stats--item">
                <em>${quantity}</em>

                <h3><fmt:message key="home.bags"/></h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius est beatae, quod accusamus illum
                    tempora!</p>
            </div>

            <div class="stats--item">
                <em>${donations}</em>
                <h3><fmt:message key="home.donations"/></h3>
                <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Laboriosam magnam, sint nihil cupiditate
                    quas
                    quam.</p>
            </div>

        </div>
    </section>

    <section class="steps">
        <h2><fmt:message key="home.steps"/></h2>

        <div class="steps--container">
            <div class="steps--item">
                <span class="icon icon--hands"></span>
                <h3><fmt:message key="home.step.one.message"/></h3>
                <p><fmt:message key="home.step.one.description"/></p>
            </div>
            <div class="steps--item">
                <span class="icon icon--arrow"></span>
                <h3><fmt:message key="home.step.two.message"/></h3>
                <p><fmt:message key="home.step.two.description"/></p>
            </div>
            <div class="steps--item">
                <span class="icon icon--glasses"></span>
                <h3><fmt:message key="home.step.three.message"/></h3>
                <p><fmt:message key="home.step.three.description"/></p>
            </div>
            <div class="steps--item">
                <span class="icon icon--courier"></span>
                <h3><fmt:message key="home.step.four.message"/></h3>
                <p><fmt:message key="home.step.four.description"/></p>
            </div>
        </div>

        <a href="<c:url value="/register" />" class="btn btn--large"><fmt:message key="home.register"/></a>
    </section>
</a>
<a id="about">
    <section class="about-us">
        <div class="about-us--text">
            <h2><fmt:message key="home.about"/></h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptas vitae animi rem pariatur incidunt
                libero
                optio esse quisquam illo omnis.</p>
            <img src="<c:url value="resources/images/signature.svg"/>" class="about-us--text-signature"
                 alt="Signature"/>
        </div>
        <div class="about-us--image"><img src="<c:url value="resources/images/about-us.jpg"/>" alt="People in circle"/>
        </div>
    </section>
</a>
<a id="institutions">
    <section class="help">
        <h2><fmt:message key="institutions.title"/></h2>

        <!-- SLIDE 1 -->
        <div class="help--slides active" data-id="1">
            <p><fmt:message key="institutions.message"/></p>

            <ul class="help--slides-items">
                <c:forEach items="${list}" var="e">
                    <li>
                        <c:forEach items="${e}" var="f">
                            <div class="col">
                                <div class="title"><fmt:message key="institutions.charity"/> "${f.name}"</div>
                                <div class="subtitle"><fmt:message key="institutions.mission"/>: ${f.description}.</div>
                            </div>
                        </c:forEach>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </section>
</a>
<a id="contact">
    <jsp:include page="footer.jsp"/>
</a>