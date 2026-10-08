# How the challenge is wired

reCAPTCHA plugs into the **CAPTCHA** framework rather than defining its own plugin type.

- `recaptcha_captcha($op, $captcha_type)` (`hook_captcha()` in `recaptcha.module`):
  - `$op === 'list'` → returns `['reCAPTCHA']` (the selectable challenge type).
  - `$op === 'generate'` for type `reCAPTCHA` → builds the widget: a `g-recaptcha` div with
    `data-sitekey`/`data-theme`/`data-type`/`data-size`, a hidden `captcha_response`, attaches
    the `recaptcha/recaptcha` JS library + Google's per-language script, sets
    `solution = TRUE`, `cacheable = TRUE`, and `captcha_validate = 'recaptcha_captcha_validation'`.
    If site/secret keys are unset it falls back to `captcha_captcha('generate', 'Math')`.
- `recaptcha_library_info_build()` (`hook_library_info_build()`) builds a per-language
  `google.recaptcha_<lang>` external library pointing at `api.js`
  (`www.google.com` or `www.recaptcha.net` when `use_globally` is on), with
  `render=explicit` and `onload=drupalRecaptchaOnload`.
- Validation callback `recaptcha_captcha_validation()` reads the posted `g-recaptcha-response`
  and verifies it server-side. Returns `FALSE` (fails closed) when the response or secret key
  is empty, or when Google's `isSuccess()` is false; logs Google error/info codes.
- Server verification: `Drupal\recaptcha\ReCaptcha\RequestMethod\Drupal8Post` (service
  `recaptcha.drupal8post`) implements the `google/recaptcha` library's `RequestMethod` using
  core's `@http_client`, so no cURL/stream calls bypass Drupal. It POSTs to
  `ReCaptcha::SITE_VERIFY_URL` (`https://www.google.com/recaptcha/api/siteverify`) over HTTPS.
  Hostname check honors `verify_hostname`; client IP is passed to `verify()`.
- Because the validate callback doesn't depend on a session solution, the challenge is marked
  `cacheable` and works on cached pages.
- Config changes: `RecaptchaSettingsConfigSubscriber` (service `recaptcha.config_subscriber`)
  invalidates cache tags when `recaptcha.settings` is saved.

To protect a form, you don't write code — assign the reCAPTCHA challenge to the form_id in the
CAPTCHA admin UI. To add a different challenge, implement CAPTCHA's own `hook_captcha()`.
