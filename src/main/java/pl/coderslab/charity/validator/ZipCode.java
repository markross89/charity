package pl.coderslab.charity.validator;


import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static java.lang.annotation.ElementType.*;


@Target({FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = ZipCodeValidator.class) // #1
public @interface ZipCode {
	
	
	java.lang.String message () default "{javax.validation.constraints.ZipCode.message}";
	
	
	Class<?>[] groups () default {}; // #3
	
	Class<? extends Payload>[] payload () default {};
	
}
