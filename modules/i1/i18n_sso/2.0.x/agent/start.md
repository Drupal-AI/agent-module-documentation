<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internationalization Single Sign-On (i18n_sso) — agent index

**SSO across a multi-language, multi-domain site** (logged-in on one language domain → logged-in on sibling
domains). Depends on core `language`, `system`. Version **2.0.0**. Core `^11.4||^12`.

Design is sound: **short-lived random token** (`Crypt::randomBytesBase64()`, 10-min, bound to uid+IP, DB-
stored, cron-cleaned); **CORS restricted to the configured language domains** (`language.negotiation`
`url.domains`), never `*`, for credentialed requests. **Serve all domains over HTTPS**; keep the domain
allow-list to trusted siblings only. No other access role.
