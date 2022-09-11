<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../header.jsp"/>
  <body>
    <header class="header--form-page" style="margin-top: 30px">
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

      <div class="slogan container container--90">
        <div class="slogan--item">
          <h1>
            <fmt:message key="donation.edit.message"/>
          </h1>

          <div class="slogan--steps">
            <div class="slogan--steps-title"><fmt:message key="donation.edit.steps.message"/>:</div>
            <ul class="slogan--steps-boxes">
              <li>
                <div><em>1</em><span><fmt:message key="donation.edit.step.one"/></span></div>
              </li>
              <li>
                <div><em>2</em><span><fmt:message key="donation.edit.step.two"/></span></div>
              </li>
              <li>
                <div><em>3</em><span><fmt:message key="donation.edit.step.three"/></span></div>
              </li>
              <li>
                <div><em>4</em><span><fmt:message key="donation.edit.step.four"/></span></div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>

    <section class="form--steps">
      <div class="form--steps-instructions">
        <div class="form--steps-container">
          <h3><fmt:message key="donation.message.important"/>!</h3>
          <p data-step="1" class="active">
            <fmt:message key="donation.message.data"/>
          </p>
          <p data-step="2">
            <fmt:message key="donation.message.data"/>
          </p>
          <p data-step="3">
            <fmt:message key="donation.message.institution"/>
          </p>
          <p data-step="4"> <fmt:message key="donation.message.address"/></p>
        </div>
      </div>

      <div class="form--steps-container">
        <div class="form--steps-counter"> <fmt:message key="donation.step"/><span>1</span>/4</div>

        <form:form  modelAttribute="donation" class="form" method="post" action="/update">
          <!-- STEP 1: class .active is switching steps -->
          <div data-step="1" class="active">
            <h3> <fmt:message key="donation.pick.category"/>:</h3>
            <form:hidden path="id" value="${donation.id}" />
            <c:forEach items="${categories}" var="i">
            <div class="form-group form-group--checkbox">
              <label class="container">
                <form:checkbox path="category" value="${i}"  title="${i.name}"/>

                <span class="checkbox" ></span>
                <span class="description">${i.name}</span>
              </label>

            </div>
            </c:forEach>
            <form:errors path="category" element="div" class="error" style="margin-left: 95px"/>

            <div class="form-group form-group--buttons">
              <button type="button" class="btn next-step"> <fmt:message key="donation.button.next"/></button>
            </div>
          </div>

          <!-- STEP 2 -->
          <div data-step="2">
            <h3> <fmt:message key="donation.pick.quantity"/>:</h3>

            <div class="form-group form-group--inline">
              <label>
                <fmt:message key="donation.quantity.message"/>:
                <form:input path="quantity" id="quantity" value="1" placeholder="sfhsfihsf"/><br>
              </label>
              <form:errors path="quantity" element="div" class="error" style="margin-left: 175px; margin-top: 10px"/>
            </div>

            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step"><fmt:message key="donation.button.next"/></button>
              <button type="button" class="btn next-step"><fmt:message key="donation.button.back"/></button>
            </div>
          </div>



          <!-- STEP 4 -->
          <div data-step="3">
            <h3><fmt:message key="donation.message.institution"/>:</h3>
            <c:forEach items="${institutions}" var="i">
            <div class="form-group form-group--checkbox">
              <label class="radiobutton">
                <form:radiobutton path="institution" value="${i}" title="${i.name}"/>

                <span class="checkbox radio"></span>
                <span class="description">
                  <div class="title"><fmt:message key="institutions.charity"/> “${i.name}”</div>
                  <div class="subtitle">
                    <fmt:message key="institutions.mission"/>: ${i.description}
                  </div>
                </span>
              </label>

            </div>
            </c:forEach>
            <form:errors path="institution" element="div" class="error" style="margin-left: 75px"/>

            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step"><fmt:message key="donation.button.next"/></button>
              <button type="button" class="btn next-step"><fmt:message key="donation.button.back"/></button>
            </div>
          </div>

          <!-- STEP 5 -->
          <div data-step="4">
            <h3><fmt:message key="donation.message.address"/>:</h3>

            <div class="form-section form-section--columns">
              <div class="form-section--column">
                <h4><fmt:message key="donation.address"/></h4>
                <div class="form-group form-group--inline">
                  <label> <fmt:message key="donation.street"/> <form:input path="street" id="street"/></label>
                  <form:errors path="street" element="div" class="error" style="margin-top: 10px"/>
                </div>

                <div class="form-group form-group--inline">
                  <label> <fmt:message key="donation.city"/> <form:input path="city" id="city"/> </label><br>
                  <form:errors path="city" element="div" class="error"/>
                </div>

                <div class="form-group form-group--inline">
                  <label>
                    <fmt:message key="donation.postcode"/><form:input path="postCode" id="postCode"/></><br>
                  </label><br>
                  <form:errors path="postCode" element="div" class="error"/>

                </div>
              </div>

              <div class="form-section--column">
                <h4><fmt:message key="donation.pickup"/></h4>
                <div class="form-group form-group--inline">
                  <label> <fmt:message key="donation.date"/> <form:input type="date" path="pickUpDate"  id="pickUpDate"/> </label>
                  <form:errors path="pickUpDate" element="div" class="errorTime" />
                </div>

                <div class="form-group form-group--inline">
                  <label> <fmt:message key="donation.time"/> <form:input type="time"  path="pickUpTime" id="time" /> </label>
                  <form:errors path="pickUpTime" element="div" class="errorTime" />
                </div>

                <div class="form-group form-group--inline">
                  <label>
                    <fmt:message key="donation.comment"/>
                    <form:textarea path="pickUpComment" id="comment"/>
                  </label>
                  <form:errors path="pickUpComment" element="div" class="errorTime" />
                </div>
              </div>
            </div>
            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step"><fmt:message key="donation.button.back"/></button>
              <button type="button" class="btn next-step" id="summary"><fmt:message key="donation.button.next"/></button>
            </div>
          </div>

          <!-- STEP 6 -->
          <div data-step="5">
            <h3><fmt:message key="donation.summary.message"/></h3>

            <div class="summary">
              <div class="form-section">
                <h4><fmt:message key="donation.give.message"/>:</h4>
                <ul>
                  <li>
                    <span class="icon icon-bag "></span>
                    <span class="summary--text donation"
                      ></span
                    >
                  </li>

                  <li>
                    <span class="icon icon-hand"></span>
                    <span class="summary--text charity"
                      ></span
                    >
                  </li>
                </ul>
              </div>

              <div class="form-section form-section--columns">
                <div class="form-section--column">
                  <h4><fmt:message key="donation.address"/>:</h4>
                  <ul>
                    <li id="streetSummary"></li>
                    <li id="citySummary"></li>
                    <li id="postCodeSummary"></li>
                  </ul>
                </div>

                <div class="form-section--column">
                  <h4><fmt:message key="donation.pickup"/>:</h4>
                  <ul>
                    <li id="dateSummary"></li>
                    <li id="timeSummary"></li>
                    <li id="commentSummary"></li>
                  </ul>
                </div>
              </div>
            </div>

            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step"><fmt:message key="donation.button.back"/></button>
              <button type="submit" value="save" class="btn"><fmt:message key="donation.button"/></button>

            </div>
          </div>
        </form:form>

      </div>
    </section>

<jsp:include page="../footer.jsp"/>