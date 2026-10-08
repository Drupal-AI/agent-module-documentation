<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install / enable

```
composer require drupal/recaptcha   # hard dependency
drush en antibot_redirect -y
```

Configure the reCAPTCHA module first (site key / secret at `/admin/config/people/captcha/recaptcha`)
— AntiBot Redirect renders `#captcha_type => 'recaptcha/reCAPTCHA'` and has no keys of its own.

## Settings form

`Drupal\antibot_redirect\Form\AntibotSettingsForm` (`getFormId()` → `antibot_settings_form`), a
`ConfigFormBase`. Route `antibot_redirect.settings` at `/admin/config/system/antibot-redirect`,
guarded by `_permission: administer site configuration`. Exposed via the `configure` link and an
admin menu link (`antibot_redirect.links.menu.yml`, parent `system.admin_config_system`).

`getEditableConfigNames()` → `['antibot_redirect.settings']`. Fields:

| Form field | Type | Config key |
|---|---|---|
| Verification page title | `textfield` | `verify_page_title` |
| Verification page description | `text_format` | `verify_page_description` (`.value` + `.format`) |
| Protected URLs | `textarea` | `protected_paths` |

`validateForm()` splits `protected_paths` on line breaks and errors if any non-empty line does not
start with `/` (message names the line number). `submitForm()` saves all three keys.

## Config object `antibot_redirect.settings`

No `config/install` default and no `config/schema` ship with the module (there is no `config/`
directory), so the object is created on first save and is untyped. Keys:

- `verify_page_title` — string, shown as the `/verify-human` page title (blank hides it).
- `verify_page_description.value` / `verify_page_description.format` — rich text rendered on the
  verify page via `processed_text` (format defaults to `basic_html` when unset).
- `protected_paths` — newline-separated list of paths to gate.

## Protected-path syntax

- One path per line, each must start with `/` (enforced by `validateForm`).
- Matching is a **case-insensitive, full-path regex** built in `BotBlockSubscriber::onRequest()`:
  the path is `preg_quote`d and `*` is turned into `.*`, then anchored `^...$`.
  - `/resources` matches only `/resources` (not `/resources/x`).
  - `/news/*` matches `/news/` and any sub-path under it.
  - Other regex metacharacters are literal (they are quoted).
- Always-excluded prefixes (never gated): `/verify-human`, `/admin*`, `/core/*`,
  `/sites/default/files/*`.

## End-to-end

1. Enable + configure reCAPTCHA keys.
2. At `/admin/config/system/antibot-redirect`, set a title/description and list protected paths.
3. An anonymous request to a protected path **without** a same-site `Referer` is redirected to
   `/verify-human`; after passing the CAPTCHA the session is flagged `verified_human` and the visitor
   is returned to the original URL, then browses protected paths freely for that session.

See also: [Request interception & the verify page](../flow/interception.md).
