# MRU Student Well-being Platform — Cloudflare + Neon

This version adapts the project to Cloudflare Workers/Pages-style static assets plus a Worker API, using the existing Neon PostgreSQL database. It keeps the 27-question survey, reverse scoring, one response per verified email, admin dashboard, settings and aggregate CSV export.

## Before you deploy
- You must create the Cloudflare account and authorize the GitHub repository yourself. I cannot sign in to your hosting accounts or publish a live URL on your behalf from this chat.
- Cloudflare plan/account verification requirements can change; confirm the dashboard lets you create a Worker on the Free plan before proceeding.
- Email OTP requires a Resend API key and a verified sender domain/address. The app intentionally does not print OTP codes into production logs.
- This is an MVP and has not been independently security-audited. Do not collect real student well-being data until the university reviews consent, privacy, access control, data retention, and support procedures.

## Deploy (no Blueprint)
1. Extract this folder and upload its **contents** to a new GitHub repository.
2. Open https://dash.cloudflare.com/ and go to **Workers & Pages**.
3. Create a Worker from the Git repository (or use the Cloudflare Git integration flow). Build/deploy commands: `npm install && npm run deploy` only if the dashboard uses a build command; otherwise use the Wrangler Git deployment instructions. Set the root directory to the repository root.
4. In Worker **Settings → Variables and Secrets**, add the secrets below. Do not put secrets in GitHub.
   - `DATABASE_URL`: Neon Connect URL for the `production` branch; ensure it includes SSL (`sslmode=require`).
   - `SESSION_SECRET`: long random secret (at least 32 random characters).
   - `ADMIN_PASSWORD`: strong unique password.
   - `RESEND_API_KEY`: Resend API key.
   - `RESEND_FROM`: sender identity verified in Resend.
5. Add optional plain-text variables `SURVEY_START`, `SURVEY_END`, `ACCESS_CODE_REQUIRED`, and `ACCESS_CODE` if desired. Defaults are in `wrangler.toml`.
6. Deploy, then visit `https://YOUR-WORKER-URL/api/health`. Expected response: `{"ok":true,"database":"connected"}`.
7. Open the base URL, test email OTP and submit one test response. Sign in to Team dashboard using `ADMIN_PASSWORD`.

## Important implementation notes
- The Worker uses signed HttpOnly cookies for session state and Neon’s serverless driver for PostgreSQL access.
- First request initializes database tables and default settings. The database connection must be allowed by Neon; use the Neon connection string, not a guessed host.
- `RESEND_FROM` must be an authorized sender. If email is not configured, OTP requests return an error rather than exposing codes.
- The default assessment dates are examples and must be updated for the institution before launch.
- Dimension scores are descriptive only and not a clinical diagnostic tool. Aggregate groups under five are not included in CSV exports.
- Free plans have usage limits and can change. Keep a secure backup and verify current provider terms.

## Local development
Install Node.js 20+, run `npm install`, copy `.dev.vars.example` to `.dev.vars`, fill valid credentials, then `npm run dev`. Never commit `.dev.vars`.
