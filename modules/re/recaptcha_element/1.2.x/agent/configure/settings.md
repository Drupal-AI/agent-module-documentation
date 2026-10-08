<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring ReCaptcha Element

## Prerequisites

Register a reCAPTCHA **v3** key pair at <https://www.google.com/recaptcha/admin/create>
(site key + secret key). The `google/recaptcha` PHP library ships as a Composer dependency
(`composer require drupal/recaptcha_element` pulls it in). Enable with
`drush en recaptcha_element -y`.

## Settings form

Route `recaptcha_element.settings` → `/admin/config/services/recaptcha_element`
(`Drupal\recaptcha_element\Form\RecaptchaElementSettingsForm`, form id
`recapcha_element_settings`), permission **administer recaptcha_element**. A menu link
(`recaptcha_element.links.menu.yml`) under *Configuration › Web services* and a local task
tab point at it. Edits config object `recaptcha_element.settings`.

![ReCAPTCHA Element settings form](../../../../../../../screenshots/recaptcha_element/1.2.x/settings-form.png)

| Key | Type | Install default | Purpose |
|---|---|---|---|
| `enabled` | bool | `true` | Master switch. When off, elements render `#access = FALSE` and validation is skipped (use on dev/test). |
| `site_key` | string | `''` | Public site key (max 40 chars, required in form). |
| `secret_key` | string | `''` | Server secret key (max 40 chars, required in form). |
| `element_defaults.action` | string | `default` | reCAPTCHA action name to execute + verify. |
| `element_defaults.threshold` | string | `0.5` | Minimum passing score, 0.0 (bot) – 1.0 (human). |
| `element_defaults.verify_hostname` | bool | `false` | Server-side hostname check (enable only if "Verify origin" is off on the key). |
| `element_defaults.error_message` | text | `Antibot verification failed, please try again.` | Shown on failure; rendered via `Xss::filterAdmin`. |
| `log_successes` | bool | `false` | Also log successful verifications (at INFO) via the logger service. |

On submit, if `site_key` changed the form clears cached library definitions
(`library.discovery` → `clear()`) so the Google API URL is rebuilt with the new key.

Drush example:
```bash
drush config:set recaptcha_element.settings site_key '6Lc...' -y
drush config:set recaptcha_element.settings secret_key '6Lc...' -y
drush config:set recaptcha_element.settings element_defaults.threshold '0.7' -y
```

## Config schema

`config/schema/recaptcha_element.schema.yml` defines:
- `recaptcha_element.settings` (the object above).
- `recaptcha_element.element` — reusable mapping (`action`, `threshold`, `verify_hostname`,
  `error_message`) used by both `element_defaults` and the webform handler.
- `webform.handler.recaptcha_element` — handler config (`element_name`, `recaptcha`).

`recaptcha_element.config_translation.yml` makes the settings translatable.

## Logging

Service `recaptcha_element.logger` (`Drupal\recaptcha_element\RecaptchaLogger`) logs to the
`recaptcha_element` channel: failures at ERROR for hard errors
(`E_BAD_RESPONSE`, `E_UNKNOWN_ERROR`, `E_CONNECTION_FAILED`, `E_INVALID_JSON`,
`invalid-input-secret`), otherwise NOTICE; successes at INFO only when `log_successes` is on
(see `RecaptchaLogger::getLogLevel()` / `log()`).

For adding the element to forms/webforms see [../api/element.md](../api/element.md).
