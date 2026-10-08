# REST Password Reset — manual setup guide

**REST Password Reset** (`rest_password_reset`) gives a decoupled or headless front
end the REST endpoints it needs to drive Drupal's password-reset flow over an API,
instead of sending users to Drupal's own pages. It provides three REST resources:

- `GET /user/username/{email}` — email a user their forgotten username.
- `GET /user/password/{email}` — request a password-reset link by email.
- `POST /user/password/reset` — complete the reset with the hash and timestamp from
  that link.

The intended shape is that your front end offers a "forgot password" page; the user
submits their email to the second endpoint; Drupal emails a reset link that points at
a **configurable page in your front end**; the user follows it, enters a new password,
and your front end posts the parameters from the link to the third endpoint to finish
the reset. The reset link uses the same hashing approach Drupal itself uses, so it
behaves like a normal Drupal reset — a React (or similar) front end is effectively a
hard requirement for this module to be useful.

Password reset over an API is a classic place to leak whether an account exists or to
mishandle tokens, and the public code review found this module gets the important
parts right: the request endpoints return a **generic message** ("If there is an
active user…") for both existing and non-existing emails, so they do not enumerate
accounts; the reset completion compares the reset hash with **`hash_equals()`**
(constant-time) against core's `user_pass_rehash()`, honours the configured reset
timeout, and there is a **5-minute per-user flood check** on requests. One minor
caveat worth knowing: the request endpoints take the email as part of the **GET URL**,
so the email address lands in server/proxy logs and browser history — a POST body
would keep it out of logs, but this does not affect the security of the reset itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   then activate the three REST endpoints and open them to anonymous callers.
2. [Configuration](configuration/index.md) — the module's settings form, where you
   point the reset link at your front end's page.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Web services → Rest Password
Reset**. The three REST resources are activated alongside your other resources at
**Configuration → Web services → REST** (`/admin/config/services/rest`, provided by
the REST UI module), and their access is granted at **People → Permissions**.
