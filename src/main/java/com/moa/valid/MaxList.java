package com.moa.valid;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = MaxListValidator.class)
@Target({ElementType.FIELD,ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)  // 컴파일 이후에도 JVM에 의해서 참조가 가능합니다.
public @interface MaxList {
    String message() default "Length is too long";
    Class<?>[] groups() default { };
    Class<? extends Payload>[] payload() default { };
    int max();
    int min() default 0;
}
