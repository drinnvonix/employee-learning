package com.company.lms.modules.user.entity;

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
@Table(name = "user_skill_levels")
@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class UserSkillLevel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@EqualsAndHashCode.Include
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_skill_id")
	private UserSkillMapping userSkill;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "skill_level_id")
	private SkillLevel skillLevel;

	@Column(name = "self_assessed")
	private Boolean selfAssessed;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "assessed_by")
	private User assessedBy;

	@Column(name = "assessed_at")
	private Instant assessedAt;
}

