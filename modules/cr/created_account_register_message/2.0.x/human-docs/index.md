# Created Account Register Message — manual setup guide

**Created Account Register Message** (`created_account_register_message`) makes the
registration form kinder to people who already have an account. Out of the box,
when someone tries to register with an email that Drupal already knows, core
stops them with an unfriendly error such as "This email is already in use." That
is confusing for a visitor who genuinely forgot they signed up — or whose account
was created for them by an administrator and who never used the link they were
sent.

This module replaces that dead end with a helpful message and a password reset
email. Instead of an error, the person is told their account already exists and
that a reset link has been sent so they can set a password and log in — something
like "You already have an account, we have e-mailed a password reset link in case
you do not remember your password." It turns a frustrating failure into a clear
next step.

There is one trade-off to weigh before you enable it. Confirming to an anonymous
visitor that a given email or username already has an account is a small
information leak — it can help an attacker enumerate which addresses are
registered on your site. That is a usability-versus-privacy decision: enable this
module only if that disclosure is acceptable for your site. The module works the
moment you enable it and has no settings form to configure. It needs no other
modules and supports Drupal 10.1 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. Once
enabled, it changes the behavior of the standard user registration form
automatically.

## How to use it

After enabling the module, simply visit the registration form as an anonymous
visitor and try to register with an email address that already belongs to an
account. Instead of the core "already in use" error, you should see the friendly
message and the account owner should receive a password reset email. No further
setup is required.
