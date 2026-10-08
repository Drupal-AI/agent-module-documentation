<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ReCaptcha Element (recaptcha_element) — agent index

A Google reCAPTCHA **v3** (invisible, score-based) form element plus a Webform handler.
Add bot protection to any form in code or on a webform. Core `^11`. Requires the
`google/recaptcha` Composer library (PHP >= 7.2). Webform handler needs the Webform module.

- **Settings form, keys, element defaults, enabled/logging switches, config schema** →
  [configure/settings.md](configure/settings.md)
- **Using the `recaptcha_element` form element in custom code, the `#recaptcha` props,
  server-side validation, and the Webform handler** → [api/element.md](api/element.md)

Key facts:
- Config object `recaptcha_element.settings`: `enabled` (bool), `site_key`, `secret_key`,
  `element_defaults` (`action`, `threshold`, `verify_hostname`, `error_message`),
  `log_successes` (bool). Install defaults: enabled true, keys empty, threshold 0.5,
  action `default`, verify_hostname false, error message set.
- Settings route `recaptcha_element.settings` →
  `/admin/config/services/recaptcha_element` (`RecaptchaElementSettingsForm`), permission
  **administer recaptcha_element** (the only permission this module defines). Not declared
  as `configure` in info.yml.
- Form element `recaptcha_element` (`Drupal\recaptcha_element\Element\RecaptchaElement`,
  `@FormElement`, extends core `Hidden`). Webform handler plugin id `recaptcha_element`
  (`RecaptchaElementWebformHandler`).
- Validation uses `google/recaptcha` `ReCaptcha` with secret key + expected action +
  score threshold (optional hostname); failure → `$form_state->setError()` with
  `Xss::filterAdmin`'d message. All results logged via service `recaptcha_element.logger`
  (`RecaptchaLogger`) to channel `recaptcha_element`.
- JS `js/recaptcha_element.js` provisions tokens via `grecaptcha.execute()` on submit
  (regular + AJAX); Google API v3 script loaded via `hook_library_info_alter()` with the
  site key appended (`?render=<site_key>`).
- Hooks live in `src/Hook/RecaptchaElementHooks.php` (`#[Hook]` attributes, with
  `#[LegacyHook]` shims in `recaptcha_element.module`): `help`, `library_info_alter`,
  `js_alter`. No new plugin types, no Drush.
