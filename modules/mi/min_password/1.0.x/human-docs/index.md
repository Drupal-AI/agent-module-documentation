# Min Password — manual setup guide

**Min Password** (`min_password`) does one small, useful thing: it lets you set a
**minimum password length** for every user account on the site, and enforces it. A
password shorter than the configured length is rejected with a validation message
when someone sets or changes it. Existing passwords are left untouched — the module
only adds a check at the point a password is entered.

Drupal core famously has no built-in minimum-password-length setting (an issue
that's been open for many years), and the full
[Password Policy](https://www.drupal.org/project/password_policy) module is more
than you need if all you want is a length floor. Min Password is the deliberately
tiny alternative: length only, nothing else. If you need character-type rules,
password history, expiry, or username-in-password checks, reach for Password Policy
instead — but for "passwords must be at least N characters," this is all it takes.

It also fixes a related edge case: on the password reset form, it prevents the
situation where clicking Save could leave a user with a zero-length password.

The setting is added directly to Drupal's existing **Account settings** page, so
there's no separate form to hunt for. It has no module dependencies beyond Drupal
core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the minimum password length on
   the Account settings page.

## Where it lives in the admin menu

Min Password doesn't add its own settings page. Instead it adds a
**minimum password length** field to the core **Account settings** page at
**Configuration → People → Account settings**
(`/admin/config/people/accounts`). See [Configuration](configuration/index.md).
