# Age & Zodiac Calculator (Hijri & Gregorian)

A single-page React app: enter your birth date to get your **exact age**, your **Western zodiac sign**, and your birth date in both the **Hijri** and **Gregorian** calendars. The interface is in Arabic (RTL).

## Features

- Full birth-date input (day / month / year)
- Exact age in years, months, and days
- Western zodiac sign (e.g. Scorpio)
- Accurate Umm al-Qura Hijri date via `Intl.DateTimeFormat` — no external libraries
- Arabic RTL "astrolabe" theme with the Cairo font
- **Login & account creation via Supabase Auth** — email/password, Google, and phone OTP

## Authentication (Supabase)

The app is protected: visiting `index.html` redirects to `login.html` unless you are signed in.

Pages:

- `signup.html` — create an account
- `login.html` — sign in
- `index.html` — the calculator (requires a session; has a logout button)

### Setup (one time)

1. **Create a Supabase project** at <https://supabase.com/dashboard> → **New project**.
2. **Run the schema:** open **SQL Editor → New query**, paste the contents of
   [`supabase-schema.sql`](supabase-schema.sql), and run it. This creates a `profiles`
   table with row-level security and a trigger that auto-creates a profile per new user.
3. **Add your keys:** open **Project Settings → API** and copy the **Project URL** and the
   **anon public** key into [`supabase-config.js`](supabase-config.js):

   ```js
   window.SUPABASE_CONFIG = {
     url: "https://YOUR-PROJECT.supabase.co",
     anonKey: "YOUR_ANON_PUBLIC_KEY",
   };
   ```

   > ⚠️ Only ever use the **anon** key here. Never put the `service_role` key or the
   > database password in client-side files.

### Enabling each login method

- **Email + password** — works out of the box once keys are set.
- **Google** — Supabase Dashboard → **Authentication → Providers → Google**: enable it and
  paste a Google OAuth client ID/secret (created in Google Cloud Console). Add your site URL
  to **Authentication → URL Configuration → Redirect URLs**.
- **Phone OTP** — Supabase Dashboard → **Authentication → Providers → Phone**: enable it and
  connect an SMS provider (e.g. Twilio). This is usually a paid service.

## Run

No build step required — just open `index.html` in a browser (or serve the folder with any
static server). Built with React 18 + Babel standalone and `@supabase/supabase-js` via CDN.

> Note: Google/OTP redirects work best when served over `http(s)` rather than the `file://`
> protocol. Any static server works, e.g. `npx serve` in this folder.
