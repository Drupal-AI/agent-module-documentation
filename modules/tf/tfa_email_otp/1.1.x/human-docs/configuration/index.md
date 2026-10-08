# Configuration

TFA Email OTP has no page of its own. Its configuration is part of the **TFA
settings** page at **Configuration → People → Two-factor authentication**
(`/admin/config/people/tfa`). Make sure TFA and Encrypt are set up first, including
an encryption profile selected in TFA — the same profile encrypts the codes.

## Allow the plugin (site-wide, admin)

On the TFA settings form:

1. Add **TFA Email OTP** to the **allowed validation plugins**.
2. Optionally set it as the **default validation plugin** so it is offered first.

Until it is in the allowed list, users won't see it as an option.

## Code validity period

Choose how long a sent code stays usable, from a dropdown of minute options: **1,
2, 3, 4, 5, or 10 minutes**. The value is stored as seconds. If left unset, the
plugin falls back to 60 seconds. Shorter windows are more secure; longer windows are
friendlier to users on slow mail.

## The OTP email template

You can fully customize the message that carries the code:

- **Subject** — for example `[site:name] Authentication code`.
- **Body** — the message text, with two special placeholders plus standard tokens:
  - `[code]` — the one-time code itself.
  - `[length]` — the validity period in **minutes**.
  - Standard `[site:*]` and `[user:*]` tokens (for example `[site:name]`,
    `[user:display-name]`) are also replaced, in the recipient's preferred
    language.

A typical default body reads:

```
[user:display-name],

This code is valid for [length] minutes. Your code is: [code]

This code will expire once you have logged in.
```

## How users turn it on (per user)

Allowing the plugin doesn't force it on anyone — each user enables it themselves.
From their account's TFA setup flow they tick **"Enable two-factor authentication
via email"** and save. The checkbox is only offered when the account has a **valid
email address**; if it doesn't, the setup page instead links to the account edit
form so an address can be added first. Only users who have enabled it are challenged
with an email code; an allowed-but-not-enabled user is skipped. This is a personal
setting, not something an administrator configures per user.

## What happens at login

Once enabled, at the 2FA challenge the user sees their **masked** email address and,
after pressing **Send**, an **Authentication code** field with **Verify** and
**Resend** buttons. Pressing Send emails a fresh 8-digit code (subject to the
6-per-5-minutes flood cap). The code is stored encrypted with an expiry timestamp;
on a correct, unexpired entry it is verified in constant time and then deleted so it
cannot be reused. Expired codes are cleared and rejected, and requesting a new code
supersedes the old one. The message is sent in the user's preferred language.

## Configuring with Drush (optional)

The settings live in `tfa.settings` under the plugin's config. For example:

```bash
ddev drush config:set tfa.settings validation_plugin_settings.tfa_email_otp.code_validity_period 300 -y
```

(`300` seconds = 5 minutes.) Most sites will find the settings form on the TFA page
easier than editing config directly.
