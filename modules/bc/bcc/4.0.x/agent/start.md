<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blind Carbon Copy (bcc) — agent index

Adds **one configured Bcc recipient to every email the site sends**. Version **4.0.1**,
core `^9 || ^10 || ^11`, package `Mail`. No dependencies, no Composer requirements.

## What it actually does

- `bcc_mail_alter()` (an implementation of `hook_mail_alter()`) runs on every outgoing
  message. When config `bcc.settings:enable` is TRUE, it appends the configured
  `bcc.settings:bcc_mail` address to the message's `Bcc` header (space-joined onto any
  existing Bcc value).
- **Global only.** One address, one on/off switch. There are **no per-mail-key rules, no
  exclusions, no Cc/Reply-To handling, and no token support.** Every mail key — including
  `user_password_reset` and one-time-login — is copied when enabled.
- The address is admin config, entered on the settings form as an email-typed field, so it
  is trusted and format-validated (not visitor-influenced).

## Configuration

- Route `bcc.settings` → `/admin/config/system/bcc-settings`, menu link under
  *Configuration › System*.
- Permission: **`administer bcc settings`** (`restrict access: true`).
- Config object `bcc.settings`: `enable` (boolean, default FALSE), `bcc_mail` (email,
  default `''`). Ships with a config schema. See [config/settings.md](config/settings.md).
- Form: `Drupal\bcc\Form\BccSettingsForm` (extends `ConfigFormBase`, marked `@internal`).

## Operational security caveat (by design, not a bug)

**This is a data-protection decision before it is a configuration one.** A blanket BCC
copies things nobody expected to be copied:

- **every password reset link** — a reset link is a **credential**, so the BCC mailbox
  becomes able to **take over any account on the site**;
- every one-time login link, account activation, order with an address on it, and message
  containing personal data a user submitted.

Consequences: (1) the BCC mailbox needs the protection of the most sensitive thing in it —
account takeover — so use a controlled, tightly held address, not a forwarded team alias;
(2) the module **cannot exclude** credential-bearing mail, so weigh whether the archive is
worth what it unavoidably collects; (3) recipients are not told (that is what BCC means) —
a compliance archive needs a privacy notice and a real retention period. Volume caveat: a
bulk send to 1,200 users produces 1,200 BCC copies.

Legitimate drivers: archiving for support reconstruction; a shared inbox that notices when
confirmations stop arriving; a retention requirement; and debugging, since "did the email
go out" is otherwise unanswerable from inside Drupal.
