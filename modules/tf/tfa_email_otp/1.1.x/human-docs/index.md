# TFA Email OTP Plugin — manual setup guide

**TFA Email OTP Plugin** (`tfa_email_otp`) adds an "email one-time password" second
factor to the [TFA (Two-Factor Authentication)](https://www.drupal.org/project/tfa)
module. When a user logs in and reaches the 2FA challenge, the site emails them an
8-digit numeric code; they type it in to finish signing in. It is the no-smartphone
alternative to an authenticator app — useful as a fallback alongside TOTP and
recovery codes, or as the primary second factor for users who can't run an app.

The module plugs into TFA as a **validation plugin** plus a **setup plugin**; it
does not define plugin types of its own. Each user turns the factor on for
themselves from their TFA setup page (a single "Enable two-factor authentication via
email" checkbox — offered only when the account has a valid email address). As an
administrator you allow the plugin site-wide, optionally make it the default, choose
how long a code stays valid, and customize the email subject and body — all on the
standard TFA settings page.

Security is handled carefully. Codes are generated with TFA's cryptographically
secure random generator (an 8-digit numeric space of 100 million), **encrypted at
rest** via the [Encrypt](https://www.drupal.org/project/encrypt) module using the
same profile TFA is configured with — the plaintext code only ever appears in the
outgoing email — and compared in constant time. A code is **single-use**: on a
successful check it is deleted, so it can't be replayed, and expired codes are
cleared and rejected. Flood control caps sends at 6 per 5 minutes per user, and the
web-services validation path at 6 failed attempts per 5 minutes; brute-force
lockout on the interactive login form is handled by TFA core's own failed-validation
limit. On the login form the recipient address is shown **masked**, and the code
field only appears once a code has been sent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## What's new in 1.1.x

- Enabling the factor now requires the account to have a valid email address.
- The login form shows a masked recipient address, hides the code field until a code
  is sent, and states how long the code stays valid.
- OTP emails are sent in the user's preferred language (fixes a fatal error with
  some mail systems).
- Requesting a code for a deleted account no longer errors — it is logged and stopped.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside TFA and Encrypt.
2. [Configuration](configuration/index.md) — allow the plugin, set the code
   validity period, customize the OTP email, and how users enable it.

## Where it lives in the admin menu

TFA Email OTP has no page of its own. Its settings are part of the **TFA settings**
page at **Configuration → People → Two-factor authentication**
(`/admin/config/people/tfa`). Individual users enable the factor from their own TFA
setup flow on their account page. See [Configuration](configuration/index.md).
