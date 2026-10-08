<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hCaptcha — agent index

Registers a **`hCaptcha`** challenge type with the contrib **CAPTCHA** module (hard dependency
`captcha:captcha`). All settings live in one config object, `hcaptcha.settings`; the admin form
is at `/admin/config/people/captcha/hcaptcha` (route `hcaptcha.admin_settings_form`, permission
`administer hcaptcha`). No plugins, no Drush. Falls back to CAPTCHA's Math challenge when keys
are unset.

- **Configure keys/widget & assign hCaptcha to a form (CAPTCHA point / default challenge)** →
  [configure/settings.md](configure/settings.md)
- **How it works: hook_captcha, the widget, siteverify validation, fallback, logging** →
  [api/captcha-integration.md](api/captcha-integration.md)

Key facts:
- Config keys: `hcaptcha.settings` → `site_key`, `secret_key`, `hcaptcha_src`
  (default `https://hcaptcha.com/1/api.js`), `widget.theme` (`''`=light / `dark`),
  `widget.size` (`''`=normal / `compact`), `widget.tabindex`, `widget.max_score` (enterprise).
- A form is protected by giving it the challenge `hcaptcha/hCaptcha` — either a
  `captcha.captcha_point.<form_id>` config entity or `captcha.settings.default_challenge`.
- Verification POSTs to `https://hcaptcha.com/siteverify`; errors log to the `hCaptcha` channel.
