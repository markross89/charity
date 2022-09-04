<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer>
    <div class="contact">
        <h2>Skontaktuj się z nami</h2>
        <h3>Formularz kontaktowy</h3>
        <form class="form--contact">
            <div class="form-group form-group--50"><input type="text" name="name" placeholder="Imię"/></div>
            <div class="form-group form-group--50"><input type="text" name="surname" placeholder="Nazwisko"/></div>

            <div class="form-group"><textarea name="message" placeholder="Wiadomość" rows="1"></textarea></div>

            <button class="btn" type="submit">Wyślij</button>
        </form>
    </div>
    <div class="bottom-line">
        <span class="bottom-line--copy">Copyright &copy; 2018</span>
        <div class="bottom-line--icons">
            <a href="<c:url value="https://pl-pl.facebook.com/"/>" class="btn btn--small"><img src="resources/images/icon-facebook.svg"/></a> <a href="<c:url value="https://www.instagram.com/"/>"
                                                                                                      class="btn btn--small"><img
                src="resources/images/icon-instagram.svg"/></a>
        </div>
    </div>
</footer>

<script src="<c:url value="../resources/js/app.js"/>"></script>
</body>
</html>