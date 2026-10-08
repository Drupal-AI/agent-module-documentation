<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object, and the reset-link token

## Admin form

- **`src/Form/PasswordResetConfigForm.php`** (`ConfigFormBase`, form id
  `rest_password_reset_settings`), route **`rest_password_reset.password_reset`** at
  **`/admin/config/services/rest-password-reset`**.
- Menu link under *Configuration → Web services* (`rest_password_reset.links.menu.yml`), plus a
  local task tab and `config_translation` mapping for the config object.
- **Route access** is a `_custom_access` check, `PasswordResetAccessCheck::checkAccess()`
  (service `rest_password_reset.access_check`): allowed if the account has
  `administer site configuration` **or** the module permission **`rest password reset`**
  (`rest_password_reset.permissions.yml`, `restrict access: true`).
- Editable config: `rest_password_reset.password_reset` (`getEditableConfigNames()`).

## Config object `rest_password_reset.password_reset`

Schema in `config/schema/rest_password_reset.schema.yml` (type `config_object`); install defaults
in `config/install/rest_password_reset.password_reset.yml`.

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `fe_uri` | string | `''` | Frontend base URI reset links point at. Form field is `#type url`, **required**. |
| `fe_uri_custom` | boolean | `false` | Use a custom URL suffix instead of the default `/password-reset/`. |
| `fe_uri_suffix` | string | `/password-reset/` | Custom suffix (shown only when `fe_uri_custom` is checked). |
| `name_mail_subject` | label | `Your username for [site:name]` | Username-email subject. |
| `name_mail_body` | text | (see install yml) | Username-email body; uses `[user:account-name]`. |
| `reset_mail_subject` | label | `Replacement login information for [user:display-name] at [site:name]` | Reset-email subject. |
| `reset_mail_body` | text | (see install yml) | Reset-email body; must include `[rest_password_reset:login_link]`. |

Form default values are passed through `Xss::filter()` when rendered. `update_10001`
(`rest_password_reset.install`) backfills `fe_uri_custom`/`fe_uri_suffix` on older installs.

## Reset-link token (`rest_password_reset.tokens.inc`)

- `hook_token_info()` registers token type `rest_password_reset` (needs a `user`) and token
  `login_link` (labelled "One-time login URL"; note the config default body uses it as
  `[rest_password_reset:login_link]`).
- `hook_tokens()` builds the URL for `login_link`:
  `Url::fromUri( fe_uri . (langcode ? '/'.langcode : '') . (fe_uri_custom && fe_uri_suffix ? fe_uri_suffix : '/password-reset/') . uid . '/' . timestamp . '/' . hash )`
  where `timestamp = \Drupal::time()->getRequestTime()` and
  `hash = user_pass_rehash($account, $timestamp)` (same algorithm core uses). Cache max-age is set
  to 300s on the bubbleable metadata.
- So an emitted link looks like `https://frontend.example[/de]/password-reset/{uid}/{timestamp}/{hash}`.
  Your frontend page parses those three path parts and POSTs them (plus `new_password`) to
  `/api/user/reset/password` — see [../api/endpoints.md](../api/endpoints.md).

## Mail assembly

`rest_password_reset_mail()` in `rest_password_reset.module` implements `hook_mail()` for keys
`reset_mail` and `username_mail`, copying the token-replaced `subject` and `body` from the calling
resource into the message.
