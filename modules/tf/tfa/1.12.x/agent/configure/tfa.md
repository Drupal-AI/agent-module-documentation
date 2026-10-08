# Configure TFA

![TFA settings form](../../../../../../../screenshots/tfa/1.12.x/tfa.png)

## Prerequisites — encryption profile (required)

TFA stores secrets encrypted and **will not enable** until an encryption profile is selected.
Set up, in order:

1. An encryption method module (e.g. Real AES or Sodium).
2. `key` — create an Encryption key.
3. `encrypt` — create an encryption profile using that method + key.

`tfa` depends on `encrypt` (info.yml `dependencies: encrypt:encrypt`); `key` comes in via the
encryption profile. The settings form disables the "Enable TFA" checkbox and blocks saving when
no encryption profile exists.

## Settings UI — `tfa.settings`

Route `tfa.settings` at `/admin/config/people/tfa` (permission `admin tfa settings`).
Config object `tfa.settings` (schema `config/schema/tfa.schema.yml`). Key settings:

| Key | Default | Meaning |
|---|---|---|
| `enabled` | `false` | Master on/off for the TFA login interrupt |
| `allowed_validation_plugins` | `{}` (form defaults to `tfa_totp`) | Which validation plugins users may set up |
| `default_validation_plugin` | `''` (form defaults to `tfa_totp`) | Plugin used by default during authentication |
| `encryption` | `''` | ID of the Encrypt encryption profile used for secrets |
| `required_roles` | `{}` | Roles for which TFA is required |
| `validation_skip` | `3` | Times a required user may log in before setup is enforced |
| `users_without_tfa_redirect` | `false` | Send users straight to their TFA setup page on login |
| `reset_pass_skip_enabled` | `false` | Let super admin skip TFA on password reset |
| `tfa_flood_threshold` | `6` | Failed code attempts before flood block |
| `tfa_flood_window` | `300` | Flood window (seconds) |
| `tfa_flood_uid_only` | `1` | Flood ban by uid only |
| `help_text` | "Contact support to reset your access" | Message for users who can't complete TFA |
| `login_plugins` | `{}` | Enabled login plugins (e.g. `tfa_trusted_browser`) |
| `send_plugins` | `{}` | Enabled send plugins |
| `mail.tfa_enabled_configuration` / `mail.tfa_disabled_configuration` | (templated) | Emails sent when a user enables/disables TFA |

Per-plugin settings live under `validation_plugin_settings` (e.g. `tfa_totp`: `time_skew`,
`issuer`, `name_prefix`, `site_name_prefix`; `tfa_hotp`: `counter_window`; `tfa_recovery_code`:
`recovery_codes_amount`) and `login_plugin_settings` (e.g. `tfa_trusted_browser`:
`cookie_name`, `cookie_expiration`, `cookie_allow_subdomains`).

Config is a plain config object, so it exports/deploys with `drush config:export`. Quick toggles:

```
drush config:set tfa.settings enabled 1     # turn on
drush config:set tfa.settings enabled 0     # turn off (useful in dev/test)
```

`settings.php` override: `$settings['tfa.only_restrict_with_enabled_plugins'] = TRUE;` limits the
"is TFA required" check to enabled plugins only (default also counts disabled but provisioned
plugins, per the 8.x-1.4 security advisory).

## Per-user setup flow

Users enroll on their account security tab (via a "TFA" user operation / local task):

| Route | Path | Purpose |
|---|---|---|
| `tfa.overview` | `/user/{user}/security/tfa` | Overview of the user's TFA methods |
| `tfa.validation.setup` | `/user/{user}/security/tfa/{method}` | Set up a validation method (scan QR, save recovery codes) |
| `tfa.plugin.reset` | `/user/{user}/security/tfa/{method}/{reset}` | Reset a method |
| `tfa.disable` | `/user/{user}/security/tfa/disable` | Disable TFA for the account |

These require `setup own tfa` (or `disable own tfa`); admins with `administer tfa for other
users` can manage others. At login the second step is served at `tfa.entry`
(`/tfa/{uid}/{hash}`). Typical rollout: enable TFA, choose allowed/default validation plugins,
select the encryption profile, set `required_roles`, grant `setup own tfa` to authenticated
users, then have each user enroll.
