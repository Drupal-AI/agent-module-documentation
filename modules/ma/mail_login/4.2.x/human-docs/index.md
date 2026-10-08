# Mail Login — manual setup guide

**Mail Login** (`mail_login`) lets your users sign in with their email address in
addition to — or instead of — their username. It's a small, focused module that
solves a common support headache: people forget the username they picked at
registration, but they always remember their email. With Mail Login enabled, they
can type either one into the standard login form and get in.

The module works the moment you enable it, and it ships with sensible defaults
already switched on, so email login is available immediately with no
configuration. It has no dependencies and no submodules. Under the hood it
decorates Drupal's core authentication service so that when the login identifier
looks like an email address, it's matched to the account by email before the
password is checked — Drupal's flood (rate-limit) protection still works correctly
because the email is resolved to the canonical username first.

An optional settings form lets you go further: force **email-only** login
(disabling usernames entirely), control whether email matching is case-sensitive,
and relabel the login and password-reset form fields so they mention email. Note
that Mail Login only affects authentication and the login/reset forms — it does
not change the user registration process.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   email-only mode, case sensitivity, and custom labels.

## Where it lives in the admin menu

The settings form sits at **Configuration → People → Mail Login**
(`/admin/config/people/mail-login`). Everything the module does is controlled from
that one screen.
