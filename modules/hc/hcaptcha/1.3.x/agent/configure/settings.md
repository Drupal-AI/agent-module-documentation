<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure hCaptcha

## The settings config object: `hcaptcha.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `site_key` | string | `''` | Public site key from your hCaptcha account. |
| `secret_key` | string | `''` | Secret key used for server-side verification. |
| `hcaptcha_src` | string | `https://hcaptcha.com/1/api.js` | URL of the hCaptcha JS API. |
| `widget.theme` | string | `''` | `''` = Light (default), `dark` = Dark. |
| `widget.size` | string | `''` | `''` = Normal (default), `compact` = Compact. |
| `widget.tabindex` | integer | `0` | Tabindex applied to the widget/challenge (min -1). |
| `widget.max_score` | float | `0.8` | Max acceptable risk score (0–1); **enterprise only** — score-based verification requires an enterprise hCaptcha account. |

If **either** `site_key` or `secret_key` is empty, the module does **not** render the hCaptcha
widget — it falls back to CAPTCHA's built-in **Math** challenge (see
[../api/captcha-integration.md](../api/captcha-integration.md)).

## Admin form

Route `hcaptcha.admin_settings_form` → `/admin/config/people/captcha/hcaptcha`
(a tab under CAPTCHA settings), permission **`administer hcaptcha`**. Fields map to the config
keys above (form field `hcaptcha_site_key` → `site_key`, `hcaptcha_theme` → `widget.theme`, etc.).

## Set values with drush

```bash
drush cset hcaptcha.settings site_key   '0x0000000000000000000000000000000000000000' -y
drush cset hcaptcha.settings secret_key '0x0000000000000000000000000000000000000000' -y
drush cset hcaptcha.settings widget.theme dark -y
drush cset hcaptcha.settings widget.size compact -y
drush cget hcaptcha.settings          # read them back
```

(hCaptcha publishes public test keys for local development on its docs site; production keys
come from your hCaptcha dashboard.)

## Actually applying hCaptcha to a form

Configuring keys is not enough — you must tell the **CAPTCHA** module to use the `hCaptcha`
challenge on a form. Two ways:

**1. Per-form CAPTCHA point** — a `captcha.captcha_point.<form_id>` config entity whose
`captchaType` is `hcaptcha/hCaptcha`:

```php
\Drupal::entityTypeManager()->getStorage('captcha_point')->create([
  'id' => 'user_register_form',
  'formId' => 'user_register_form',
  'captchaType' => 'hcaptcha/hCaptcha',
  'label' => 'User register form',
  'status' => TRUE,
])->save();
```

Read it back: `drush cget captcha.captcha_point.user_register_form`.

**2. Site-wide default** — make hCaptcha the default challenge for every protected form:

```bash
drush cset captcha.settings default_challenge 'hcaptcha/hCaptcha' -y
```

The challenge identifier is `<module>/<challenge>` = `hcaptcha/hCaptcha` (the `hCaptcha`
label comes from `hook_captcha('list')` in this module).

## Config schema

The module ships `config/schema/hcaptcha.schema.yml` defining `hcaptcha.settings` as a
`config_object` (so the keys above are typed/validated). `provides_config_schema: true`.
