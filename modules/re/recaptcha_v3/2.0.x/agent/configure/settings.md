# Configure reCAPTCHA v3

Settings page `/admin/config/people/captcha/recaptcha-v3` (route `recaptcha_v3.settings`,
permission `administer CAPTCHA settings` — inherited from the CAPTCHA module; this module
defines no permissions of its own).

## Global settings (config object `recaptcha_v3.settings`)
| Key | Meaning |
|---|---|
| `site_key` | Google reCAPTCHA v3 site key (public). |
| `secret_key` | Google reCAPTCHA v3 secret key (server-side verify). |
| `default_challenge` | Fallback challenge used when an action says "default" (install default `captcha/Math`). |
| `verify_hostname` | Validate the response hostname. |
| `hide_badge` | Hide the reCAPTCHA badge (loads `recaptcha_v3_no_badge` CSS; you must show attribution). |
| `cacheable` | Allow the CAPTCHA element to be cached. |
| `library_use_recaptcha_net` | Load from recaptcha.net instead of google.com. |
| `error_message` | Message shown on verification failure (translatable). |

Install defaults live in `config/install/recaptcha_v3.settings.yml`; schema in
`config/schema/recaptcha_v3.schema.yml`.

## reCAPTCHA v3 action entities (config entity `recaptcha_v3.recaptcha_v3_action.*`)
Managed on the same page (list builder `ReCaptchaV3ActionListBuilder`,
form `ReCaptchaV3ActionForm`). Each action = one Google "action" name with:
- `id` / `label` — machine name + label.
- `threshold` (float, `#type` number) — minimum score to pass; below it the fallback fires.
- `challenge` (string) — fallback challenge type (a CAPTCHA challenge id, or `default` to use
  `default_challenge`). reCAPTCHA v3 challenge types are excluded from the fallback options.

Exportable config, so actions deploy between environments.

## Applying to forms
This module only registers the challenge type + actions. Choose which action protects which
form using the **CAPTCHA** module's per-form points UI (`/admin/config/people/captcha`) —
select the reCAPTCHA v3 challenge/action as the CAPTCHA type for that form id.
