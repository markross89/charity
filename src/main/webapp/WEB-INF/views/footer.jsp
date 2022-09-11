<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<footer>

    <div class="contact">
        <h2><fmt:message key="contact.us"/></h2>
        <h3><fmt:message key="contact.message"/></h3>
        <form class="form--contact" method="get" action="<c:url value="/sendEmail"/>">
            <div class="form-group form-group--50"><input type="text" name="name" placeholder="<fmt:message key="contact.field.name"/>"/></div>
            <div class="form-group form-group--50"><input type="text" name="surname" placeholder="<fmt:message key="contact.field.lastname"/>"/></div>

            <div class="form-group"><textarea name="message" placeholder="<fmt:message key="contact.field.message"/>" rows="1"></textarea></div>

            <button class="btn" type="submit"><fmt:message key="contact.send"/></button>
        </form>
    </div>
    <div class="bottom-line">
        <span class="bottom-line--copy">Copyright &copy; 2018</span>
        <div class="bottom-line--icons">
            <a href="<c:url value="https://pl-pl.facebook.com/"/>" class="btn btn--small"><img src="../resources/images/icon-facebook.svg"/></a> <a href="<c:url value="https://www.instagram.com/"/>"
                                                                                                      class="btn btn--small"><img
                src="../resources/images/icon-instagram.svg"/></a>
        </div>
    </div>
</footer>

<script src="<c:url value="../resources/js/app.js"/>"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js">
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#locales").change(function () {
            var selectedOption = $('#locales').val();
            if (selectedOption !==''){
                window.location.replace('?lang=' + selectedOption);
            }
        });
    });
</script>

</body>
</html>