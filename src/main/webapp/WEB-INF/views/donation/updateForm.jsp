<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="header.jsp"/>
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
        <div class="slogan--item">
          <h1>
            Edytuj, zanim przyjedzie<br />
            <span class="uppercase">Kurier</span>
          </h1>

          <div class="slogan--steps">
            <div class="slogan--steps-title">4 proste kroki:</div>
            <ul class="slogan--steps-boxes">
              <li>
                <div><em>1</em><span>Popraw zawartość</span></div>
              </li>
              <li>
                <div><em>2</em><span>Popraw ilość worków</span></div>
              </li>
              <li>
                <div><em>3</em><span>Zmień Fundację</span></div>
              </li>
              <li>
                <div><em>4</em><span>Zmień date lub miejsce odbioru</span></div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>

    <section class="form--steps">
      <div class="form--steps-instructions">
        <div class="form--steps-container">
          <h3>Ważne!</h3>
          <p data-step="1" class="active">
            Uzupełnij szczegóły dotyczące Twoich rzeczy. Dzięki temu będziemy
            wiedzieć komu najlepiej je przekazać.
          </p>
          <p data-step="2">
            Uzupełnij szczegóły dotyczące Twoich rzeczy. Dzięki temu będziemy
            wiedzieć komu najlepiej je przekazać.
          </p>
          <p data-step="3">
           Wybierz jedną, do
            której trafi Twoja przesyłka.
          </p>
          <p data-step="4">Podaj adres oraz termin odbioru rzeczy.</p>
        </div>
      </div>

      <div class="form--steps-container">
        <div class="form--steps-counter">Krok <span>1</span>/4</div>

        <form:form  modelAttribute="donation" class="form" method="post" action="/update">
          <!-- STEP 1: class .active is switching steps -->
          <div data-step="1" class="active">
            <h3>Zaznacz co chcesz oddać:</h3>
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
              <button type="button" class="btn next-step">Dalej</button>
            </div>
          </div>

          <!-- STEP 2 -->
          <div data-step="2">
            <h3>Podaj liczbę 60l worków, w które spakowałeś/aś rzeczy:</h3>

            <div class="form-group form-group--inline">
              <label>
                Liczba 60l worków:
                <form:input path="quantity" id="quantity" value="1" placeholder="sfhsfihsf"/><br>
              </label>
              <form:errors path="quantity" element="div" class="error" style="margin-left: 175px; margin-top: 10px"/>
            </div>

            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step">Wstecz</button>
              <button type="button" class="btn next-step">Dalej</button>
            </div>
          </div>



          <!-- STEP 4 -->
          <div data-step="3">
            <h3>Wybierz organizacje, której chcesz pomóc:</h3>
            <c:forEach items="${institutions}" var="i">
            <div class="form-group form-group--checkbox">
              <label class="radiobutton">
                <form:radiobutton path="institution" value="${i}" title="${i.name}"/>

                <span class="checkbox radio"></span>
                <span class="description">
                  <div class="title">Fundacja “${i.name}”</div>
                  <div class="subtitle">
                    Cel i misja: ${i.description}
                  </div>
                </span>
              </label>

            </div>
            </c:forEach>
            <form:errors path="institution" element="div" class="error" style="margin-left: 75px"/>

            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step">Wstecz</button>
              <button type="button" class="btn next-step">Dalej</button>
            </div>
          </div>

          <!-- STEP 5 -->
          <div data-step="4">
            <h3>Podaj adres oraz termin odbioru rzeczy przez kuriera:</h3>

            <div class="form-section form-section--columns">
              <div class="form-section--column">
                <h4>Adres odbioru</h4>
                <div class="form-group form-group--inline">
                  <label> Ulica <form:input path="street" id="street"/></label>
                  <form:errors path="street" element="div" class="error" style="margin-top: 10px"/>
                </div>

                <div class="form-group form-group--inline">
                  <label> Miasto <form:input path="city" id="city"/> </label><br>
                  <form:errors path="city" element="div" class="error"/>
                </div>

                <div class="form-group form-group--inline">
                  <label>
                    Kod pocztowy<form:input path="postCode" id="postCode"/></><br>
                  </label><br>
                  <form:errors path="postCode" element="div" class="error"/>

                </div>
              </div>

              <div class="form-section--column">
                <h4>Termin odbioru</h4>
                <div class="form-group form-group--inline">
                  <label> Data <form:input type="date" path="pickUpDate"  id="pickUpDate"/> </label>
                  <form:errors path="pickUpDate" element="div" class="errorTime" />
                </div>

                <div class="form-group form-group--inline">
                  <label> Godzina <form:input type="time"  path="pickUpTime" id="time" /> </label>
                  <form:errors path="pickUpTime" element="div" class="errorTime" />
                </div>

                <div class="form-group form-group--inline">
                  <label>
                    Uwagi dla kuriera
                    <form:textarea path="pickUpComment" id="comment"/>
                  </label>
                  <form:errors path="pickUpComment" element="div" class="errorTime" />
                </div>
              </div>
            </div>
            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step">Wstecz</button>
              <button type="button" class="btn next-step" id="summary">Dalej</button>
            </div>
          </div>

          <!-- STEP 6 -->
          <div data-step="5">
            <h3>Podsumowanie Twojej darowizny</h3>

            <div class="summary">
              <div class="form-section">
                <h4>Oddajesz:</h4>
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
                  <h4>Adres odbioru:</h4>
                  <ul>
                    <li id="streetSummary"></li>
                    <li id="citySummary"></li>
                    <li id="postCodeSummary"></li>
                  </ul>
                </div>

                <div class="form-section--column">
                  <h4>Termin odbioru:</h4>
                  <ul>
                    <li id="dateSummary"></li>
                    <li id="timeSummary"></li>
                    <li id="commentSummary"></li>
                  </ul>
                </div>
              </div>
            </div>

            <div class="form-group form-group--buttons">
              <button type="button" class="btn prev-step">Wstecz</button>
              <button type="submit" value="save" class="btn">Potwierdzam</button>

            </div>
          </div>
        </form:form>

      </div>
    </section>

<jsp:include page="footer.jsp"/>