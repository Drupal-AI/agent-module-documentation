# Configure TFA Email OTP

The module has no page of its own. Configuration is part of the **TFA settings** page,
`admin/config/people/tfa` (route `tfa.settings`, this module's `configure`). Prerequisites:
the `tfa` and `encrypt` modules must be set up (TFA needs an encryption profile selected — the
same profile is used to encrypt OTPs).

## Allow / default the plugin (TFA-level config)

On the TFA settings form, add `tfa_email_otp` to the allowed validation plugins and optionally
make it the default. Stored in `tfa.settings`:

```yaml
allowed_validation_plugins:
  tfa_email_otp: tfa_email_otp
default_validation_plugin: tfa_email_otp          # optional
validation_plugin_settings:
  tfa_email_otp:
    code_validity_period: 300                     # seconds (see options below)
    email_setting:
      subject: '[site:name] Authentication code'
      body: |
        [user:display-name],

        This code is valid for [length] minutes. Your code is: [code]

        This code will expire once you have logged in.
```

Config schema: `tfa.validation.plugin.config.tfa_email_otp` (`code_validity_period` int,
`email_setting.subject` label, `email_setting.body` text).

### Validity period

`buildConfigurationForm()` exposes a select of **minutes → seconds**: 1→60, 2→120, 3→180,
4→240, 5→300, 10→600. Stored as seconds in `code_validity_period`. The plugin defaults its
in-memory `validityPeriod` to 60 s if unset.

### OTP email template

Subject + body textarea. Two custom placeholders are substituted in `send()` by literal
`str_replace` **before** Drupal token replacement:
- `[length]` → validity in **minutes** (`code_validity_period / 60`).
- `[code]` → the plaintext OTP.

Then `hook_mail` (`tfa_email_otp_mail`) runs standard token replacement for `[site:*]` /
`[user:*]` tokens, in the recipient's preferred language. Subject is flattened with
`PlainTextOutput::renderFromHtml()`.

## Per-user enablement (not admin config)

Each user turns the factor on from their own TFA setup flow (see
[../plugins/tfa.md](../plugins/tfa.md) → setup plugin). The single checkbox persists to
`user.data`:

```
collection=tfa, name=tfa_email_otp  → ['enable' => 1]
```

`ready()` returns true only when `enable` is truthy, so an allowed-but-not-enabled user is not
challenged with email OTP.

## Install-time migration

`tfa_email_otp_install()` renames any legacy `tfa_email_code` plugin references to
`tfa_email_otp` in `tfa.settings` (allowed/default/settings) and in every user's
`tfa_user_settings`, and seeds `enable => 1` for migrated users. No action needed on fresh
installs.
