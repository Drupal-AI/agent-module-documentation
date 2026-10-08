# User Field Login — manual setup guide

**User Field Login** (`field_login`) lets people sign in with the value of an
arbitrary user field — a phone number, a membership ID, or any other custom field
on the user account — instead of typing their Drupal username. The login form
still asks for a password, and that password is still verified the normal way; all
this module changes is *how the account is looked up* from what the visitor types
in the "username" box.

Under the hood it decorates Drupal's core user-authentication service. When someone
submits the login form, the module finds the account whose configured field
matches the entered value, and then hands off to **core's password checker** to
verify the password exactly as Drupal always does. Because of that, it does **not**
weaken the credential check: a wrong password is still rejected, and core's login
flood protection still applies. It simply widens what counts as a valid
"identifier" at the front door.

Two things are important to get right when you adopt it. First, the field you use
for login **must be unique** across accounts — if two users could share the same
value, a login attempt becomes ambiguous, which is both a usability and a security
problem. Second, exposing an extra login identifier slightly widens the surface for
identifier *enumeration* (an attacker probing which phone numbers or IDs exist), so
keep your login error messages neutral ("Unrecognized username or password") rather
than confirming whether a given identifier exists.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the login field and, if you
   like, reword the login form's username label.

## Where it lives in the admin menu

The settings form sits under the account settings, at **Configuration → People →
Account settings → Field login**
(`/admin/config/people/accounts/field-login`).
