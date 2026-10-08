<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — config object & keys

Form `\Drupal\simple_recaptcha\Form\SimpleRecaptchaSettingsForm`, route
`simple_recaptcha.settings` → `/admin/config/services/simple_recaptcha`
(permission `administer simple_recaptcha`).

**Config object: `simple_recaptcha.config`** (the class constant `SETTINGS`). Do not confuse
with the route name `simple_recaptcha.settings`.

## Keys (schema `simple_recaptcha.config`, defaults from `config/install`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `form_ids` | text | `user_pass,user_register_form` | Comma-separated form IDs to protect. Supports `*` wildcards (e.g. `contact_message_*`). |
| `recaptcha_type` | text | `v2` | `v2` (checkbox) or `v3` (invisible). |
| `site_key` | text | `''` | reCAPTCHA **v2** site key. |
| `secret_key` | text | `''` | reCAPTCHA **v2** secret key. |
| `site_key_v3` | text | `''` | reCAPTCHA **v3** site key. |
| `secret_key_v3` | text | `''` | reCAPTCHA **v3** secret key. |
| `v3_score` | integer | `80` | Minimum v3 score (0–100) to accept. |
| `recaptcha_use_globally` | boolean | `false` | Protect **every** form, ignoring `form_ids`. |
| `hide_badge_v3` | boolean | `false` | Hide the v3 badge (you must still show the required attribution). |

Get the keys from Google's reCAPTCHA admin console; without valid keys the widget renders but
verification cannot succeed.

## Set with drush

```bash
drush config:set simple_recaptcha.config form_ids 'user_login_form,user_register_form,contact_message_*' -y
drush config:set simple_recaptcha.config recaptcha_type v2 -y
drush config:set simple_recaptcha.config site_key   'YOUR_V2_SITE_KEY' -y
drush config:set simple_recaptcha.config secret_key 'YOUR_V2_SECRET_KEY' -y
drush cr
```

Read back: `drush config:get simple_recaptcha.config`.

## How a form is matched

`hook_form_alter()` explodes `form_ids` and calls
`SimpleReCaptchaFormManager::formIdInList($form_id, $list)`, which treats each entry as a
regex with `*` → `.*`. If `recaptcha_use_globally` is TRUE the check is skipped and all forms
are protected. Users with `bypass simple_recaptcha` are always exempt. See
[../api/api.md](../api/api.md).
