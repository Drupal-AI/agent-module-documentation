<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring TFA (settings & config object)

## Install & enable

```bash
composer require drupal/tfa
drush en tfa -y
```

Runtime module dependency: **`encrypt`** (which requires **`key`**). Composer also pulls the
`christian-riesen/otp`, `chillerlan/php-qrcode`, and `paragonie/constant_time_encoding` libraries.
`tfa_requirements()` (`tfa.install`) errors if the `otp` library is missing and if PHP has neither
OpenSSL nor Mcrypt; it also verifies the core login routes are still TFA-overridden.

**Before TFA can be enabled you must create an Encrypt encryption profile** (Key + Encrypt). The
settings form refuses to save (`SettingsForm::dataEmptyCheck`) if there are no validation plugins
or no encryption profiles, and the *Enable TFA* checkbox is disabled until a profile exists.

## The settings form

`Drupal\tfa\Form\SettingsForm` (`getFormId` = `tfa_settings_form`), route **`tfa.settings`** at
**`/admin/config/people/tfa`**, permission **`admin tfa settings`**, `_admin_route: TRUE`. It is a
`ConfigFormBase` editing the single config object **`tfa.settings`**.

![TFA settings form](../../../../../../../screenshots/tfa/1.13.x/settings-form.png)

Fields map to config keys as follows (see `submitForm()`):

| Form field | Config key | Notes |
|---|---|---|
| Enable TFA | `enabled` | Master switch (bool). |
| Roles required to set up TFA | `required_roles` | Roles that must configure TFA; a role needs `setup own tfa` to appear usefully. |
| Allow TFA bypass during password reset | `reset_pass_skip_enabled` | Lets uid 1 skip TFA on password reset (`canResetPassSkip`). |
| Allowed Validation plugins | `allowed_validation_plugins` | Which validators users may set up (checkboxes). |
| Default Validation plugin | `default_validation_plugin` | Primary validator (default `tfa_totp`); always force-added to allowed. |
| Validation Settings | `validation_plugin_settings` | Per-plugin config (built by each plugin's `buildConfigurationForm`). |
| Encryption Profile | `encryption` | ID of the Encrypt profile used to encrypt seeds/codes. |
| Skip Validation | `validation_skip` | Times a user without TFA may still log in (default 3). |
| Redirect users on login to TFA Setup Page | `users_without_tfa_redirect` | Bool. |
| Login plugins | `login_plugins` | Plugins that can let a user skip the second factor (e.g. `tfa_trusted_browser`). Use with caution. |
| Login Settings | `login_plugin_settings` | Per-login-plugin config. |
| Send plugins | `send_plugins` | Only shown if any `TfaSend` plugins exist. |
| Flood Control With UID Only | `tfa_flood_uid_only` | 1 = throttle per uid (most secure); 0 = uid+IP. |
| TFA Flood Window | `tfa_flood_window` | Seconds (default 300). |
| TFA Flood Threshold | `tfa_flood_threshold` | Max failed codes per window (default 6). |
| User enabled/disabled TFA emails | `mail.tfa_enabled_configuration.*`, `mail.tfa_disabled_configuration.*` | Subject/body, token-replaced in `tfa_mail()`. |
| Help text | `help_text` | Message shown when a user is locked out. |

## Config object `tfa.settings`

Install defaults: `config/install/tfa.settings.yml`; schema: `config/schema/tfa.schema.yml`
(`type: config_object`, plus per-plugin schema keys such as `tfa.validation.plugin.config.tfa_totp`,
`tfa.validation.plugin.config.tfa_hotp`, `tfa.validation.plugin.config.tfa_recovery_code`,
`tfa.login.plugin.config.tfa_trusted_browser`). Shipped defaults: `enabled: false`,
`validation_skip: 3`, `tfa_flood_uid_only: 1`, `tfa_flood_window: 300`, `tfa_flood_threshold: 6`,
`help_text: 'Contact support to reset your access'`. Translatable via `tfa.config_translation.yml`.

Quick enable/disable (handy for dev/test environments):

```bash
drush config-set tfa.settings enabled 1   # enable
drush config-set tfa.settings enabled 0   # disable
```

### Per-validation-plugin settings (`validation_plugin_settings`)

- **`tfa_totp`** — `time_skew` (number of past 30s windows accepted, default 2), `site_name_prefix`
  (bool), `name_prefix` (default `TFA`), `issuer` (default `Drupal`).
- **`tfa_hotp`** — `counter_window` (look-ahead, default 10), `site_name_prefix`, `name_prefix`,
  `issuer`.
- **`tfa_recovery_code`** — `recovery_codes_amount` (default 10).

### Trusted-browser settings (`login_plugin_settings.tfa_trusted_browser`)

`cookie_allow_subdomains` (bool, default TRUE), `cookie_expiration` (days, default 30),
`cookie_name` (default `tfa-trusted-browser`). Older configs are migrated by
`tfa_update_8012/8013`.

## Notification emails

`tfa_mail()` (`tfa.module`) implements `hook_mail` for keys `tfa_enabled_configuration` and
`tfa_disabled_configuration`, pulling subject/body from `tfa.settings.mail.*` and running them
through the token service with `[site:*]` / `[user:*]` tokens. Sent from `TfaSetupForm` (enable) and
`TfaDisableForm` / `TfaTokenManagement` (disable).
