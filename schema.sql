CREATE TABLE IF NOT EXISTS survey_responses (
 id BIGSERIAL PRIMARY KEY, student_email TEXT NOT NULL, school TEXT NOT NULL,
 program_level TEXT, program_name TEXT, department TEXT, year_of_study TEXT,
 answers JSONB NOT NULL, reflection TEXT, dimension_scores JSONB NOT NULL,
 submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 CONSTRAINT unique_student_email UNIQUE(student_email)
);
CREATE INDEX IF NOT EXISTS idx_survey_responses_school ON survey_responses(school);
CREATE INDEX IF NOT EXISTS idx_survey_responses_submitted_at ON survey_responses(submitted_at DESC);
