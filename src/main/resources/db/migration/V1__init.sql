-- Initial schema (PostgreSQL)
-- Flyway will run this automatically on app startup.

CREATE TABLE IF NOT EXISTS companies (
  id BIGSERIAL PRIMARY KEY,
  company_name VARCHAR(255),
  company_code VARCHAR(100),
  email_domain VARCHAR(255),
  contact_email VARCHAR(255),
  contact_phone VARCHAR(50),
  status VARCHAR(50),
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS designations (
  id BIGSERIAL PRIMARY KEY,
  company_id BIGINT REFERENCES companies(id),
  designation_name VARCHAR(255),
  description TEXT,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  company_id BIGINT REFERENCES companies(id),
  designation_id BIGINT REFERENCES designations(id),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(50),
  password_hash VARCHAR(255),
  role VARCHAR(50),
  status VARCHAR(50),
  email_verified BOOLEAN,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS registration_codes (
  id BIGSERIAL PRIMARY KEY,
  code VARCHAR(100),
  company_id BIGINT REFERENCES companies(id),
  role_type VARCHAR(50),
  created_by BIGINT REFERENCES users(id),
  expires_at TIMESTAMPTZ,
  is_used BOOLEAN,
  used_by BIGINT REFERENCES users(id),
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS password_reset_tokens (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  token VARCHAR(255),
  expires_at TIMESTAMPTZ,
  used BOOLEAN,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS email_verification_tokens (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  token VARCHAR(255),
  expires_at TIMESTAMPTZ,
  verified BOOLEAN,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS user_sessions (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  jwt_token TEXT,
  device_info TEXT,
  ip_address VARCHAR(64),
  login_time TIMESTAMPTZ,
  logout_time TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS projects (
  id BIGSERIAL PRIMARY KEY,
  company_id BIGINT REFERENCES companies(id),
  project_name VARCHAR(255),
  description TEXT,
  manager_id BIGINT REFERENCES users(id),
  start_date DATE,
  end_date DATE,
  status VARCHAR(50),
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS project_members (
  id BIGSERIAL PRIMARY KEY,
  project_id BIGINT REFERENCES projects(id),
  user_id BIGINT REFERENCES users(id),
  role VARCHAR(50),
  assigned_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS courses (
  id BIGSERIAL PRIMARY KEY,
  company_id BIGINT REFERENCES companies(id),
  course_name VARCHAR(255),
  description TEXT,
  course_type VARCHAR(50),
  course_duration VARCHAR(50),
  created_by BIGINT REFERENCES users(id),
  status VARCHAR(50),
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS course_modules (
  id BIGSERIAL PRIMARY KEY,
  course_id BIGINT REFERENCES courses(id),
  module_title VARCHAR(255),
  module_description TEXT,
  module_order INTEGER,
  content_type VARCHAR(50),
  content_url TEXT,
  duration_minutes INTEGER,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS course_quizzes (
  id BIGSERIAL PRIMARY KEY,
  course_id BIGINT REFERENCES courses(id),
  module_id BIGINT REFERENCES course_modules(id),
  quiz_title VARCHAR(255),
  passing_score INTEGER,
  total_questions INTEGER,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS quiz_questions (
  id BIGSERIAL PRIMARY KEY,
  quiz_id BIGINT REFERENCES course_quizzes(id),
  question_text TEXT,
  question_type VARCHAR(50),
  option_a TEXT,
  option_b TEXT,
  option_c TEXT,
  option_d TEXT,
  correct_option VARCHAR(10),
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS course_assignments (
  id BIGSERIAL PRIMARY KEY,
  course_id BIGINT REFERENCES courses(id),
  assigned_by BIGINT REFERENCES users(id),
  assignment_type VARCHAR(50),
  designation_id BIGINT REFERENCES designations(id),
  project_id BIGINT REFERENCES projects(id),
  assigned_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS course_assignment_users (
  id BIGSERIAL PRIMARY KEY,
  assignment_id BIGINT REFERENCES course_assignments(id),
  user_id BIGINT REFERENCES users(id),
  assigned_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS enrollments (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  course_id BIGINT REFERENCES courses(id),
  enrollment_type VARCHAR(50),
  enrollment_source VARCHAR(50),
  enrolled_at TIMESTAMPTZ,
  status VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS course_progress (
  id BIGSERIAL PRIMARY KEY,
  enrollment_id BIGINT REFERENCES enrollments(id),
  module_id BIGINT REFERENCES course_modules(id),
  progress_status VARCHAR(50),
  progress_percentage INTEGER,
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS quiz_attempts (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  quiz_id BIGINT REFERENCES course_quizzes(id),
  score INTEGER,
  passed BOOLEAN,
  attempt_number INTEGER,
  attempted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS certifications (
  id BIGSERIAL PRIMARY KEY,
  course_id BIGINT REFERENCES courses(id),
  certificate_name VARCHAR(255),
  validity_days INTEGER,
  template_url TEXT,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS employee_certifications (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  certification_id BIGINT REFERENCES certifications(id),
  course_id BIGINT REFERENCES courses(id),
  issued_at TIMESTAMPTZ,
  expiry_date DATE,
  certificate_url TEXT,
  status VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS notifications (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  title VARCHAR(255),
  message TEXT,
  notification_type VARCHAR(50),
  read_status VARCHAR(50),
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS notification_logs (
  id BIGSERIAL PRIMARY KEY,
  notification_id BIGINT REFERENCES notifications(id),
  delivery_channel VARCHAR(50),
  delivery_status VARCHAR(50),
  delivered_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS audit_logs (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  action_type VARCHAR(100),
  entity_type VARCHAR(100),
  entity_id VARCHAR(100),
  description TEXT,
  ip_address VARCHAR(64),
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS activity_logs (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  activity_type VARCHAR(100),
  activity_details TEXT,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS skills (
  id BIGSERIAL PRIMARY KEY,
  skill_name VARCHAR(255),
  skill_category VARCHAR(255),
  description TEXT,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS user_skill_mapping (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  skill_id BIGINT REFERENCES skills(id),
  years_of_experience INTEGER,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS skill_levels (
  id BIGSERIAL PRIMARY KEY,
  level_name VARCHAR(255),
  level_rank INTEGER,
  description TEXT,
  created_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS user_skill_levels (
  id BIGSERIAL PRIMARY KEY,
  user_skill_id BIGINT REFERENCES user_skill_mapping(id),
  skill_level_id BIGINT REFERENCES skill_levels(id),
  self_assessed BOOLEAN,
  assessed_by BIGINT REFERENCES users(id),
  assessed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS course_skills (
  course_id BIGINT REFERENCES courses(id),
  skill_id BIGINT REFERENCES skills(id),
  PRIMARY KEY (course_id, skill_id)
);

CREATE TABLE IF NOT EXISTS course_reviews (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT REFERENCES users(id),
  course_id BIGINT REFERENCES courses(id),
  enrollment_id BIGINT REFERENCES enrollments(id),
  rating INTEGER,
  review_text TEXT,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS course_comments (
  id BIGSERIAL PRIMARY KEY,
  course_id BIGINT REFERENCES courses(id),
  module_id BIGINT REFERENCES course_modules(id),
  user_id BIGINT REFERENCES users(id),
  comment_text TEXT,
  parent_comment_id BIGINT REFERENCES course_comments(id),
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS course_review_reactions (
  id BIGSERIAL PRIMARY KEY,
  review_id BIGINT REFERENCES course_reviews(id),
  user_id BIGINT REFERENCES users(id),
  reaction_type VARCHAR(50),
  created_at TIMESTAMPTZ
);

-- Helpful indexes
CREATE INDEX IF NOT EXISTS idx_users_company_id ON users(company_id);
CREATE INDEX IF NOT EXISTS idx_courses_company_id ON courses(company_id);
CREATE INDEX IF NOT EXISTS idx_projects_company_id ON projects(company_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_user_id ON enrollments(user_id);

