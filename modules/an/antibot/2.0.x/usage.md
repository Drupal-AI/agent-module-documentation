Antibot blocks automated spam bots by requiring JavaScript to submit protected forms — a lightweight, invisible alternative to CAPTCHA that never bothers real (JS-enabled) visitors.

---

Antibot works on the premise that most spam bots do not execute JavaScript. When a configured form is rendered, Antibot rewrites its `action` to a dead `/antibot` endpoint and adds a secret, per-form key; a small JS library restores the real action and key at submit time. Bots that post directly to the form without running JS therefore submit to the wrong place and are rejected, and server-side validation double-checks the key. Which forms are protected is controlled by a list of form IDs (wildcards like `comment_*` supported) in the settings form, with an optional exclusion list. Out of the box it protects comment, user register/password, contact, and webform submission forms. A "Display form IDs" debug mode reveals every form's ID and whether Antibot guards it, to make configuration easy. There are no external dependencies, no puzzles for users, and users with the `skip antibot` permission bypass it entirely. Developers can toggle protection per form, react to rejections, and alter the generated key via hooks. It requires no third-party services and adds negligible overhead.

---

- Stop spam comments without showing users a CAPTCHA.
- Protect the user registration form from automated signups.
- Guard the password-reset form against bot abuse.
- Shield the site contact form from spam messages.
- Protect Webform submissions from bot flooding.
- Add invisible spam protection to a custom form by its form ID.
- Use a wildcard (`comment_*`) to cover every comment form at once.
- Exclude one specific form from protection while keeping a wildcard match.
- Provide an accessibility-friendly alternative to image CAPTCHAs.
- Reduce spam without any external anti-spam service or API key.
- Display form IDs temporarily to discover which ID to protect.
- Let trusted roles bypass protection via the `skip antibot` permission.
- Show a "please enable JavaScript" message to non-JS visitors via the template.
- Combine with Honeypot for layered, service-free spam defense.
- Protect newsletter or subscription signup forms.
- Keep e-commerce checkout or coupon forms free of bot submissions.
- Force-enable protection on a specific form via `hook_antibot_form_status_alter()`.
- Log or count rejected bot submissions via `hook_antibot_reject()`.
- Alert an admin when a particular form is repeatedly hit by bots.
- Protect multiple sites with the same exportable configuration.
- Restrict who can change Antibot settings with a dedicated permission.
- Avoid the maintenance burden of CAPTCHA keys and services.
- Harden anonymous-accessible forms on a public site.
- Reduce database bloat from spam by rejecting bots before submission.
- Theme the no-JS warning message to match site branding.
