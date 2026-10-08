<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & mail template

Everything the module lets you configure, from `src/Form/SettingsForm.php`,
`config/install/authenticate_by_mail.settings.yml`, and `config/schema/authenticate_by_mail.schema.yml`.

## Where

Settings form `SettingsForm` (id `authenticate_by_mail_settings_form`, extends `ConfigFormBase`) at
**`/admin/config/people/authenticate-by-mail`** (route `authenticate_by_mail.settings`). Menu link under
*Configuration → People* (`authenticate_by_mail.links.menu.yml`, parent `user.admin_index`); a "Settings"
local task (`authenticate_by_mail.links.task.yml`). Route permission is `administer authenticate_by_mail
settings` — **not declared by this module**, so grant/define it yourself or use uid 1. `#tree` form; submit
writes cleaned values straight into the config object.

## Config object: `authenticate_by_mail.settings`

Single config object (`type: config_object`). Install defaults + schema:

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `timeout` | integer | `3600` | Validity of a login link, in seconds. **Not** enforced for users who have never logged in. |
| `flood_request_ip.threshold` | integer | `50` | Max login requests per IP per window. |
| `flood_request_ip.window` | integer | `3600` | IP flood tracking window, seconds. |
| `flood_request_user.threshold` | integer | `5` | Max requests per target user per window. |
| `flood_request_user.window` | integer | `21600` | Per-user flood window, seconds (6h). |
| `login.subject` | label | `Login information for [user:display-name] at [site:name]` | Mail subject (token-replaced). |
| `login.body` | text | see below | Mail body (token-replaced). |

Default body (install config):

```
[user:display-name],

A login request for your account has been made at [site:name].

You may now log in by clicking this link or copying and pasting it into your browser:

[user:one-time-login-url]

This link can only be used once to log in. It expires after one hour and nothing will happen if it's not used.

-- [site:name]
```

Form field constraints: `timeout` and all flood fields are `#type: number`, required, `min: 1`,
`max: PHP_INT_MAX`, `step: 1`. Subject `#maxlength: 180`; body is a 12-row textarea.

## Mail tokens

Body/subject support the usual site/user tokens plus the module's own **`[user:one-time-login-url]`** (the
form help lists: `[site:name]`, `[site:url]`, `[user:display-name]`, `[user:account-name]`, `[user:mail]`,
`[site:login-url]`, `[site:url-brief]`, `[user:one-time-login-url]`). `[user:one-time-login-url]` is
registered as an unsafe token by `_authenticate_by_mail_tokens()` and only resolves inside this module's mail.

## Config translation

`authenticate_by_mail.config_translation.yml` registers the settings under
`base_route_name: authenticate_by_mail.settings`, so the subject/body (schema types `label`/`text`) are
translatable per language via the Config Translation module. `authenticate_by_mail_mail()` sets the
config-override language from the message langcode before token replacement, so users receive the mail in
their preferred language.

## Drush / config export example

```yaml
# config export: authenticate_by_mail.settings.yml
timeout: 900
flood_request_ip:
  threshold: 20
  window: 3600
flood_request_user:
  threshold: 3
  window: 3600
login:
  subject: 'Your login link for [site:name]'
  body: "Hi [user:display-name],\n\n[user:one-time-login-url]\n\n-- [site:name]"
```

Import with `drush config:set` per key or via a full config import. Lowering `timeout` shortens link
validity; tightening the flood thresholds hardens against link-request abuse.
