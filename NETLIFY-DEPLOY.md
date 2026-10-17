# Netlify deployment

1. Repository is now configured for Netlify.
2. In Netlify, choose Add new site → Import an existing project and select this repository.
3. Build command: `npm run build`; publish directory: `.`.
4. Add environment variables `DATABASE_URL` (Neon pooled connection string) and `ADMIN_PASSWORD` (strong secret) in Netlify site settings.
5. Run `schema.sql` in Neon SQL Editor, then redeploy.
6. Test `/api/health` for `database: connected`. Admin dashboard: `/?admin=1`.

Student email is a unique identifier, not OTP-verified. Do not use for real student data until institutional email verification, consent, access controls, and data retention have been reviewed.
