<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Email Login (rest_mail_login) — agent index

**REST login by email address instead of username; password still verified by core.**

- **Version:** 8.x-2.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** user
- **Package:** Web services

**Surface:** one route `POST /user/email-login` (`_format: json`, anonymous only). Controller `RestMailLoginController` extends core `UserAuthenticationController`. No permissions/config/services.

**Security:** email is resolved to a username, then delegated to core `login()` — the `pass` field is still required, so it is NOT an email-only bypass. Notes: unknown-email returns a distinct 400 (minor user enumeration); rate limiting relies on core flood control. Serve over HTTPS.
