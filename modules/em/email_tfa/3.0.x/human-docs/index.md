# Email TFA — manual setup guide

**Email TFA** (`email_tfa`) adds email-based two-factor authentication to your
site. After a user signs in with their username and password, the module emails
them a one-time numeric security code and holds their session at a verification
page until they type that code in. It's a lightweight second factor — no SMS
gateway and no authenticator app required, just the user's ability to read their
email inbox.

Because it protects the login itself, Email TFA replaces Drupal's core login
form and also guards the REST login endpoint, so both browser logins and API
logins are covered. You choose who gets challenged: everyone on the site, only
certain roles, everyone *except* certain roles, or each user individually opting
in from their own account page. You also control the code length (4–9 digits),
how long a code stays valid, how many attempts are allowed before flood control
kicks in, and the wording of the email and the verification page.

Everything lives in one settings form and one master on/off switch, so a security
team can turn site-wide 2FA on or off instantly. The module is off until you
enable it in configuration, and it has one important prerequisite: your site must
have a `hash_salt` set in `settings.php` (Drupal installs normally already have
one) — the one-time code's hash depends on it, and the settings form warns you if
it's missing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the `hash_salt` prerequisite.
2. [Configuration](configuration/index.md) — the settings form field by field:
   the master switch, who gets challenged, code length and timeout, flood
   control, and the email and verification-page text.

## Where it lives in the admin menu

The settings form sits at **Configuration → People → Email TFA settings**
(`/admin/config/people/email-tfa`). Access is gated by the
**Administer email tfa** permission, so grant that only to trusted
administrators.

## How to use it

At a high level:

1. Enable the module and make sure `hash_salt` is set (see
   [Installation](installation/index.md)).
2. Open the settings form, turn the master **status** switch on, and decide who
   is challenged — everyone, specific roles, or per-user opt-in (see
   [Configuration](configuration/index.md)).
3. From then on, when a covered user logs in they receive a code by email and are
   redirected to `/tfa/verify/…` to enter it. If the first email is slow, they
   can resend a fresh code from that page.

While testing, you can turn on **dev mode** to print the code on-screen instead of
waiting for the email — but never leave dev mode on for a live site.
