# Employee Learning & Certification Tracker

A backend system that helps companies manage employee learning, certifications, and project-based training.

## Core Goals

The system helps organizations to:

- Track employee learning progress
- Assign mandatory training
- Manage certifications
- Monitor employee skill gaps
- Track project-specific training

## System Roles

| Role | Description |
|---|---|
| Super Admin | Platform owner managing companies |
| HR/Admin | Manages company users and courses |
| Manager | Manages project teams and project courses |
| Employee | Takes courses and earns certifications |

## Core System Modules

The platform is divided into 8 backend modules:

1. Authentication & Authorization
2. Organization & User Management
3. Course & Learning Management
4. Certification Management
5. Project & Team Management
6. Notification & Alerts
7. Audit & Activity Logging
8. Reporting & Insights

---

## Authentication Module

Handles login, verification, and security.

### Features

- Register user
- Login
- Forgot password
- Email verification
- Mobile verification (optional)
- JWT authentication
- Logout
- Role-based authorization

### APIs

- `POST /auth/register`
- `POST /auth/login`
- `POST /auth/forgot-password`
- `POST /auth/reset-password`
- `POST /auth/logout`
- `POST /auth/verify-email`

---

## Organization & User Management

Handles companies, HR users, managers, and employees.

### Super Admin

- Add company
- Add HR
- Generate HR registration code
- Approve HR request
- Manage companies
- Manage users
- View system logs
- View notifications
- Settings

### HR

- Add users (Manager / Employee)
- Generate registration codes
- Approve user registrations
- Manage company users

### APIs

- `POST /companies`
- `GET /companies`
- `POST /users`
- `GET /users`
- `GET /users/{id}`
- `POST /registration-codes`
- `POST /users/approve`

---

## Course & Learning Management

Main module of the system.

### HR Course Features

- Create course
- Add modules
- Add quizzes
- Upload static content
- Link external course platforms
- Manage course
- Assign courses

#### Assignment Options

- All employees
- Specific designation
- Specific users

### Manager Course Features

- Create project course
- Add modules
- Add quizzes
- Assign courses to project team

### Employee Learning Features

- View courses
- Enroll in course
- Start course
- Continue course
- Complete modules
- Attempt quizzes
- View progress

### APIs

- `POST /courses`
- `GET /courses`
- `GET /courses/{id}`
- `POST /courses/{id}/modules`
- `POST /courses/{id}/quiz`
- `POST /courses/{id}/assign`
- `GET /employees/{id}/courses`
- `PUT /progress/update`

---

## Certification Module

Handles certificates issued after course completion.

### Features

- Generate certificate
- Define certificate validity
- Certification expiry tracking
- Renewal reminders
- Download certificate

### Employee

- View certifications
- Download certificates

### HR

- View certification reports

### APIs

- `POST /certifications/generate`
- `GET /employees/{id}/certifications`
- `GET /certifications/expiring`

---

## Project & Team Management

Used by Managers.

### Features

- Create project
- Add team members
- Assign project courses
- Track team learning progress

### APIs

- `POST /projects`
- `GET /projects`
- `POST /projects/{id}/team`
- `POST /projects/{id}/courses`
- `GET /projects/{id}/progress`

---

## Notification & Alert System

Handles alerts and reminders.

### Notifications

- Course assigned
- Course reminders
- Certification expiry alerts
- Course completion alerts
- Manager notifications

### Alerts

- Overdue courses
- Expiring certificates
- Missing mandatory training

### APIs

- `GET /notifications`
- `POST /notifications/send`

---

## Audit Logs

Tracks important system activities.

### Tracks

- Login attempts
- Course assignments
- Course completions
- User creation
- Settings changes

### APIs

- `GET /audit-logs`
- `GET /audit-logs/user/{id}`

---

## Reporting Module

Provides insights for HR and Managers.

### HR Reports

- Course completion report
- Employee certification report
- Skill gap report

### Manager Reports

- Project learning report
- Team progress report

### APIs

- `GET /reports/course-completion`
- `GET /reports/certifications`
- `GET /reports/team-progress`

---

## General System Features

- JWT authentication
- Role-based access control
- Logout
- Pagination
- Search
- Filtering
- Soft delete
- API versioning

---

## Developer Work Distribution

- **Developer 1 – Authentication & Users**: Login, Register, JWT, Companies, Users
- **Developer 2 – Course System**: Courses, Modules, Quizzes, Enrollments, Progress tracking
- **Developer 3 – Certification & Reporting**: Certificates, Expiry tracking, Reports, Skill gap analysis
- **Developer 4 – Projects, Notifications & Logs**: Project teams, Project courses, Notifications, Audit logs

---

## Tech Stack

### Backend

- Spring Boot
- Spring Security
- Spring Data JPA
- PostgreSQL

### Optional

- Redis
- Kafka / RabbitMQ
- Spring Scheduler

### Tools

- Docker
- Prometheus
- Grafana

---

## Important Features

### Course Progress Tracking

Example flow:

- Module 1 → Completed
- Module 2 → Completed
- Quiz → Passed

### Scheduled Certification Expiry Check

Daily background job to detect expiring certifications.

### Dashboard APIs

Examples:

- Total courses
- Completed courses
- Expiring certifications
- Team learning status

### File Storage

Used for:

- Course materials
- Certificates

### Course Reviews

Employees can rate and review courses after completion.

---

## Database Schema

> Note: This is a high-level schema list (columns abbreviated as provided).

- `companies`: id, company_name, company_code, email_domain, contact_email, contact_phone, status, created_at, updated_at
- `registration_codes`: id, code, company_id, role_type, created_by, expires_at, is_used, used_by, created_at
- `designations`: id, company_id, designation_name, description, created_at
- `users`: id, company_id, designation_id, first_name, last_name, email, phone, password_hash, role, status, email_verified, created_at, updated_at
- `password_reset_tokens`: id, user_id, token, expires_at, used, created_at
- `email_verification_tokens`: id, user_id, token, expires_at, verified, created_at
- `user_sessions`: id, user_id, jwt_token, device_info, ip_address, login_time, logout_time
- `projects`: id, company_id, project_name, description, manager_id, start_date, end_date, status, created_at
- `project_members`: id, project_id, user_id, role, assigned_at
- `courses`: id, company_id, course_name, description, course_type, course_duration, created_by, status, created_at, updated_at
- `course_modules`: id, course_id, module_title, module_description, module_order, content_type, content_url, duration_minutes, created_at
- `course_quizzes`: id, course_id, module_id, quiz_title, passing_score, total_questions, created_at
- `quiz_questions`: id, quiz_id, question_text, question_type, option_a, option_b, option_c, option_d, correct_option, created_at
- `course_assignments`: id, course_id, assigned_by, assignment_type, designation_id, project_id, assigned_at
- `course_assignment_users`: id, assignment_id, user_id, assigned_at
- `enrollments`: id, user_id, course_id, enrollment_type, enrollment_source, enrolled_at, status
- `course_progress`: id, enrollment_id, module_id, progress_status, progress_percentage, started_at, completed_at
- `quiz_attempts`: id, user_id, quiz_id, score, passed, attempt_number, attempted_at
- `certifications`: id, course_id, certificate_name, validity_days, template_url, created_at
- `employee_certifications`: id, user_id, certification_id, course_id, issued_at, expiry_date, certificate_url, status
- `notifications`: id, user_id, title, message, notification_type, read_status, created_at
- `notification_logs`: id, notification_id, delivery_channel, delivery_status, delivered_at
- `audit_logs`: id, user_id, action_type, entity_type, entity_id, description, ip_address, created_at
- `activity_logs`: id, user_id, activity_type, activity_details, created_at
- `skills`: id, skill_name, skill_category, description, created_at
- `user_skill_mapping`: id, user_id, skill_id, years_of_experience, created_at, updated_at
- `skill_levels`: id, level_name, level_rank, description, created_at
- `user_skill_levels`: id, user_skill_id, skill_level_id, self_assessed, assessed_by, assessed_at
- `course_skills`: id, course_id, skill_id
- `course_reviews`: id, user_id, course_id, enrollment_id, rating, review_text, created_at, updated_at
- `course_comments`: id, course_id, module_id, user_id, comment_text, parent_comment_id, created_at, updated_at
- `course_review_reactions`: id, review_id, user_id, reaction_type, created_at
