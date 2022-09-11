package pl.coderslab.charity.validator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

import java.lang.annotation.Target;


import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;


@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = DateFutureValidator.class)
@Documented
public @interface DateFuture {
	
	java.lang.String message () default "{javax.validation.constraints.DateFuture.message}";
	
	Class<?>[] groups () default {};
	
	Class<? extends Payload>[] payload () default {};
}


