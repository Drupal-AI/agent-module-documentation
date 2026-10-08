# recaptcha — agent start

Registers a **reCAPTCHA** (Google v2) challenge for the core CAPTCHA module via
`hook_captcha()`. Requires `captcha`. Settings UI: **Admin → Config → People → CAPTCHA →
reCAPTCHA** (`/admin/config/people/captcha/recaptcha`, route
`recaptcha.admin_settings_form`). Server-side verification uses the `google/recaptcha` PHP lib.

- Keys + widget settings (`recaptcha.settings`) → [configure/settings.md](configure/settings.md)
- How the challenge/validation is wired (hooks, request method, cacheability) → [extend/integration.md](extend/integration.md)
- Theme hook / noscript fallback template → [theming/theming.md](theming/theming.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
