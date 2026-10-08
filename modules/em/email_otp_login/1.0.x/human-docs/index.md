# Email OTP Login — manual setup guide

**Email OTP Login** (`email_otp_login`) adds passwordless login to your site.
Instead of typing a password, a registered user asks for a login code, receives a
six‑digit one‑time password (OTP) by email, and enters that code to sign in. It
depends only on core's **User** module, and it is meant for registered users —
there is no anonymous login. To make it reachable, you add a menu link (or link
anywhere you like) pointing at `/otp-email`, which is where the "request a code"
flow begins.

> **Evaluate before production use.** Before you put this login method in front of
> real users, review it against your own authentication requirements and test it on
> a non‑production site first. As with any alternative sign‑in path, make sure the
> flow fits your site's login policy and that outbound email is reliable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no configuration page for this module. Once enabled, the login flow is
reached by linking to `/otp-email`; the code delivery relies on your site's
standard mail setup.

## How to use it

The module works through two paths that Drupal exposes once it is enabled:

- **`/otp-email`** — the visitor enters their registered email address and
  requests a one‑time code, which is emailed to them.
- **`/validate-otp/{email}`** — the visitor enters the six‑digit code they
  received to complete the login.

To surface the flow to users, add a menu link to `/otp-email` (for example under
**Structure → Menus**). The code is generated with a secure random source and
compared with a constant‑time check, and the login session is established through
core's standard `user_login_finalize()`.
