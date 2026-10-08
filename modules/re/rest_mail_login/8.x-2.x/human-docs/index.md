# REST Email Login — manual setup guide

**REST Email Login** (`rest_mail_login`) lets front-end and decoupled clients log in
with an **email address** and password instead of a Drupal username. Drupal's default
REST login route (`/user/login`) expects a username; on sites where usernames are
opaque or where users only ever know their email, that is awkward. This module adds a
single JSON login route that accepts the email instead.

You call it with a POST:

```
POST /user/email-login?_format=json

{"mail": "user@example.com", "pass": "the-password"}
```

Under the hood the module is a thin translation layer. Its controller extends
Drupal core's authentication controller: it looks the account up by the submitted
email, swaps in the resolved username, and then hands off to core's normal `login()`
method. That means **password verification, flood control and the CSRF/logout tokens
in the response are all core's** — the returned payload is identical to Drupal's
standard login response, so you can feed the returned token into `X-CSRF-Token` for
subsequent authenticated write calls exactly as you would with the core route.

A few things to know about its security posture, taken from the public code review:

- The **password is still required**, so this is a convenience over the username
  login, **not** an email-only authentication bypass.
- The route is restricted to anonymous callers (`_user_is_logged_in: FALSE`).
- An **unknown email returns a distinct 400 error**, which is a mild user-enumeration
  signal (a caller can tell a registered email from an unregistered one).
- **Rate limiting is only whatever core flood control provides** — the module adds
  none of its own. As with any credential endpoint, serve it strictly over HTTPS so
  the email and password are protected in transit.

Note this module targets Drupal 8–10; check compatibility before using it on
Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module and no settings to fill in — it
adds one route and has no permissions, config form or services of its own.

## Where it lives in the admin menu

REST Email Login adds no admin page. Its entire surface is the
`POST /user/email-login` route; there is nothing to click through in the admin UI.
