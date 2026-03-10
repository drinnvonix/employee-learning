package com.company.lms.modules.course.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.Instant;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "course_modules")
@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class CourseModule {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@EqualsAndHashCode.Include
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "course_id")
	private Course course;

	@Column(name = "module_title")
	private String moduleTitle;

	@Column(name = "module_description")
	private String moduleDescription;

	@Column(name = "module_order")
	private Integer moduleOrder;

	@Column(name = "content_type")
	private String contentType;

	@Column(name = "content_url")
	private String contentUrl;

	@Column(name = "duration_minutes")
	private Integer durationMinutes;

	@Column(name = "created_at")
	private Instant createdAt;
}

