CREATE TABLE IF NOT EXISTS survey_responses (
 id BIGSERIAL PRIMARY KEY,
 student_email TEXT NOT NULL,
 school TEXT NOT NULL,
 program_level TEXT,
 program_name TEXT,
 department TEXT,
 year_of_study TEXT,
 semester TEXT,
 answers JSONB NOT NULL,
 reflection TEXT,
 dimension_scores JSONB NOT NULL,
 submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 CONSTRAINT unique_student_email UNIQUE(student_email)
);
ALTER TABLE survey_responses ADD COLUMN IF NOT EXISTS semester TEXT;
CREATE INDEX IF NOT EXISTS idx_survey_responses_school ON survey_responses(school);
CREATE INDEX IF NOT EXISTS idx_survey_responses_department ON survey_responses(department);
CREATE INDEX IF NOT EXISTS idx_survey_responses_program ON survey_responses(program_name);
CREATE INDEX IF NOT EXISTS idx_survey_responses_semester ON survey_responses(semester);
CREATE TABLE IF NOT EXISTS student_strength (
 id BIGSERIAL PRIMARY KEY,
 school TEXT NOT NULL,
 department TEXT NOT NULL DEFAULT '',
 program_name TEXT NOT NULL DEFAULT '',
 semester TEXT NOT NULL DEFAULT '',
 total_students INTEGER NOT NULL CHECK (total_students >= 0),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 UNIQUE(school, department, program_name, semester)
);
