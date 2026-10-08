# rest password — manual setup guide

**rest password** (`rest_password`) exposes Drupal's forgotten-password flow over
REST, so a headless or decoupled front end (React, Vue, a mobile app) can offer
"forgot my password" without redirecting users to Drupal's own login forms. An
anonymous client POSTs an email address and Drupal mails back a **temporary
password**; the client can then either set a brand-new password using that temp
password, or log in directly with it through the JSON login endpoint.

The module adds two REST resources — `POST /user/lost-password` (request a reset)
and `POST /user/lost-password-reset` (set a new password with the temp password)
— which you enable like any REST resource. It also teaches core's JSON login
endpoint (`/user/login?_format=json`) to accept the temporary password as the
password. To keep the flow usable by not-yet-authenticated visitors, the two
lost-password endpoints are made anonymous and CSRF-exempt; the reset itself is
protected by the emailed temp token, which is compared in a timing-safe way and
deleted once used.

The lost-password request always returns the same generic success message,
whether or not the email is registered, so account existence is never disclosed.
Because these endpoints are intentionally unauthenticated, you should front them
with rate limiting or a WAF exactly as you would core's `/user/password`. The
reset email's subject, body, and the temp-password length are all editable on the
Account settings page.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the exact request and
response shapes and the events API — read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enabling the REST resources and
   editing the reset email.

## Where it lives in the admin menu

There is no dedicated settings page. You enable the two REST resources (the REST
UI module is the easy path, under **Configuration → Web services → REST**), and
you edit the reset email in a "Rest Password recovery" section added to
**Configuration → People → Account settings**
(`/admin/config/people/accounts`).
