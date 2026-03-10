package com.company.lms.modules.course.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class CourseSkillId implements Serializable {

	@Column(name = "course_id")
	private Long courseId;

	@Column(name = "skill_id")
	private Long skillId;
}

