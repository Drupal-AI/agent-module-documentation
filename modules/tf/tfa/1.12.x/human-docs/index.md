# Two-factor Authentication (TFA) — manual setup guide

**Two-factor Authentication** (`tfa`) adds a second step to Drupal login. After a
user enters the correct username and password, TFA interrupts the login and
requires them to pass a second-factor challenge — a code from an authenticator app,
a counter-based one-time password, or a printed recovery code — before they're
fully signed in. That way a stolen password alone is not enough to get into an
account.

TFA is a pluggable base module. It ships three ways to verify the second factor:
**TOTP** (time-based codes from apps like Google Authenticator, Authy, or FreeOTP),
**HOTP** (counter-based codes), and **recovery codes** (printable one-time codes for
when a device isn't available). It generates a QR code during setup so users can
scan their account straight into an authenticator app. A trusted-browser option
lets users skip the second step on a device they mark as trusted. Developers can
add their own methods (SMS, WebAuthn, a third-party service) through the module's
plugin types.

Because TFA stores its secrets (authenticator seeds, recovery codes) **encrypted**,
it requires the **Encrypt** module and an encryption profile (which is built on the
**Key** module). This is a hard requirement: TFA will not let you enable
two-factor authentication until an encryption profile exists. Enabling the module
does not switch TFA on by itself — you configure it, choose which methods are
allowed, select the encryption profile, and (optionally) require it for specific
roles, then each user enrolls from their account's security tab.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — including the
[plugin types](../agent/plugins/tfa.md) reference if you plan to add a custom
second-factor method.

## Contents

1. [Installation](installation/index.md) — install TFA and its Encrypt/Key
   prerequisites with Composer, and enable them.
2. [Configuration](configuration/index.md) — set up an encryption profile, turn TFA
   on, choose the allowed methods, require it per role, and walk through how users
   enroll.

## Where it lives in the admin menu

The global settings form sits at **Configuration → People → Two-factor
Authentication** (`/admin/config/people/tfa`). Individual users enroll on their own
account under **security → TFA** (`/user/{uid}/security/tfa`).

## How to use it

The typical rollout is: create an encryption profile, enable TFA on the settings
form, pick the allowed and default validation methods, select the encryption
profile, set which roles are required to use TFA, grant users the *Setup own tfa*
permission, and then have each user enroll from their security tab. The module also
provides Drush commands for resetting or managing a user's TFA data if someone gets
locked out.
