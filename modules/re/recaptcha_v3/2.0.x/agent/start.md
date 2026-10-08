# recaptcha_v3 — agent start

Score-based Google reCAPTCHA v3 as a CAPTCHA-module challenge type. Invisible: scores each
submit; below a per-action **threshold** it triggers a **fallback challenge**. Requires
`captcha` + the `google/recaptcha` PHP library. Config UI:
`/admin/config/people/captcha/recaptcha-v3` (route `recaptcha_v3.settings`, permission
`administer CAPTCHA settings`). Assign to forms via CAPTCHA's per-form points.

- Keys, global options, and reCAPTCHA v3 **action** entities → [configure/settings.md](configure/settings.md)
