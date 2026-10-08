Friendly Captcha adds the privacy-friendly Friendly Captcha service as a CAPTCHA challenge type in Drupal: instead of an interactive puzzle, visitors' browsers silently solve a cryptographic proof-of-work while the widget runs, so real people pass without clicking or reading anything.

---

Friendly Captcha is an add-on for the CAPTCHA module (it depends on `captcha:captcha`) and registers itself as a challenge type through `hook_captcha()`, so it appears as a "friendlycaptcha" option wherever CAPTCHA points are configured (per form, or as the default challenge). The front end uses the `friendly-challenge` JavaScript widget (dropped into `/libraries/friendly-challenge/`), which fetches a puzzle, solves it via CPU proof-of-work in the background, and posts a solution token in the hidden `frc-captcha-solution` field. On submit, the module's validation callback verifies that token server-side. There are four selectable API endpoints: `global` (default) and `eu`/`eu_fallback` verify against Friendly Captcha's hosted `siteverify` API using your **site key** + **API key** (EU endpoints require a Business/Enterprise plan), while `local` makes the Drupal site itself serve puzzles (`/api/v1/puzzle`) and verify solutions locally through the `friendlycaptcha.siteverify` service — no account or keys required. Configuration lives at **Admin → Configuration → People → CAPTCHA → Friendly Captcha** (`/admin/config/people/captcha/friendlycaptcha`), gated by CAPTCHA's `administer CAPTCHA settings` permission, and stores `site_key`, `api_key`, `api_endpoint`, and `enable_validation_logging` in the `friendlycaptcha.settings` config object. Because the challenge does not depend on session or solution state, the widget is marked cacheable and works on cached pages. If keys are missing the module falls back to CAPTCHA's Math challenge and warns administrators. Being no-tracking and puzzle-free, it is a common privacy/GDPR-conscious alternative to reCAPTCHA.

---

- Add spam protection to a form without making users click images or read distorted text.
- Register Friendly Captcha as the default challenge for all CAPTCHA-protected forms.
- Protect the user registration, login, or password-reset forms from bots.
- Protect a webform or contact form using the Friendly Captcha challenge type.
- Offer a privacy/GDPR-friendly alternative to Google reCAPTCHA (no user tracking).
- Let real visitors pass automatically via background proof-of-work (no puzzle to solve).
- Configure the site key and API key from your Friendly Captcha account.
- Choose the Global API endpoint (default) for solution verification.
- Choose the EU API endpoint to keep verification traffic in the EU (Business/Enterprise plan).
- Use the EU endpoint with automatic fallback to the Global endpoint if unavailable.
- Run fully self-hosted with the "local" endpoint so no external service or API key is needed.
- Serve puzzles from your own Drupal site at `/api/v1/puzzle` in local mode.
- Verify proof-of-work solutions server-side against Friendly Captcha's `siteverify` API.
- Verify solutions locally (signature, replay, timeout, difficulty checks) via the SiteVerify service.
- Enable validation logging to debug failed CAPTCHA attempts in the Drupal log.
- Localize the widget to the visitor's current language automatically.
- Keep CAPTCHA working on cached/anonymous pages (the challenge is marked cacheable).
- Fall back to the Math CAPTCHA automatically when keys are not yet configured.
- Install the `friendly-challenge` widget via a downloaded file, Composer npm-asset, or NPM.
- Deploy Friendly Captcha configuration between environments via config export/import.
- Scale puzzle difficulty automatically based on request frequency per IP (local mode).
- Anonymize client IPs when serving local puzzles.
- Reduce bot signups and spam submissions on high-traffic public forms.
- Combine with the CAPTCHA module's per-form-id placement to target only risky forms.
