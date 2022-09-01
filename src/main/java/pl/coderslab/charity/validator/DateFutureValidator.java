package pl.coderslab.charity.validator;


import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import java.time.LocalDate;



public class DateFutureValidator implements ConstraintValidator<DateFuture, LocalDate> {
	
	@Override
	public boolean isValid (LocalDate value, ConstraintValidatorContext context) {

		if (value.isAfter(LocalDate.now()) ){
			return true;
		}
		return false;
	}
}