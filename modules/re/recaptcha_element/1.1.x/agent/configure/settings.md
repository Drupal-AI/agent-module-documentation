# Configuring ReCaptcha Element

## Prerequisites

Register a reCAPTCHA **v3** key pair at <https://www.google.com/recaptcha/admin/create>
(site key + secret key). The `google/recaptcha` PHP library ships as a Composer dependency.

## Settings form

Route `recaptcha_element.settings` → `/admin/config/services/recaptcha_element`
(`RecaptchaElementSettingsForm`), permission **administer recaptcha_element**. Edits config
object `recaptcha_element.settings`.

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

Changing `site_key` clears cached library definitions so the Google API URL is rebuilt.

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

Service `recaptcha_element.logger` (`RecaptchaLogger`) logs to channel
`recaptcha_element`: failures at ERROR for hard errors
(`E_BAD_RESPONSE`, `E_UNKNOWN_ERROR`, `E_CONNECTION_FAILED`, `E_INVALID_JSON`,
`invalid-input-secret`) else NOTICE; successes at INFO only when `log_successes` is on.

For adding the element to forms/webforms see [../api/element.md](../api/element.md).
