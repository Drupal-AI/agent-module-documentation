# How the challenge is wired

reCAPTCHA plugs into the **CAPTCHA** framework rather than defining its own plugin type.

- `recaptcha_captcha($op, $captcha_type)` (`hook_captcha()` in `recaptcha.module`):
  - `$op === 'list'` → returns `['reCAPTCHA']` (the selectable challenge type).
  - `$op === 'generate'` for type `reCAPTCHA` → builds the widget: a `g-recaptcha` div with
    `data-sitekey`/`data-theme`/`data-type`/`data-size`, a hidden `captcha_response`, attaches
    the `recaptcha/recaptcha` JS library + Google's per-language script, sets
    `solution = TRUE`, `cacheable = TRUE`, and `captcha_validate = 'recaptcha_captcha_validation'`.
- Validation callback `recaptcha_captcha_validation()` reads the posted `g-recaptcha-response`
  and verifies it server-side.
- Server verification: `Drupal\recaptcha\ReCaptcha\RequestMethod\Drupal8Post` (service
  `recaptcha.drupal8post`) implements the `google/recaptcha` library's `RequestMethod` using
  core's `@http_client`, so no cURL/stream calls bypass Drupal. Hostname check honors
  `verify_hostname`.
- Because the validate callback doesn't depend on a session solution, the challenge is marked
  `cacheable` and works on cached pages.
- Config changes: `RecaptchaSettingsConfigSubscriber` (service `recaptcha.config_subscriber`)
  invalidates cache tags when `recaptcha.settings` is saved.

To protect a form, you don't write code — assign the reCAPTCHA challenge to the form_id in the
CAPTCHA admin UI. To add a different challenge, implement CAPTCHA's own `hook_captcha()`.
