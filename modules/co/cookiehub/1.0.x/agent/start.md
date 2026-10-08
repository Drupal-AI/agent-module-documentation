<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookiehub (cookiehub) — agent index

**Injects the CookieHub consent script into `html_head` site-wide (path-excludable) and provides a cookie-declaration field type/widget/formatter.**

- **Version:** 1.0.x
- **Core:** ^8.9 || ^9 || ^10 || ^11
- **Route:** `cookiehub.settings` → `/admin/config/services/cookiehub` (requires `administer cookiehub configuration`, restrict access).
- **Config (`cookiehub.settings`):** `id`, `enable`, `dev_mode`, `automatic_cookie_blocking`, `disable_on_paths`.
- **Hook:** `cookiehub_page_attachments()` — loads `cookiehub.net/c2/<id>.js` (or `dash.cookiehub.com/dev/<id>.js` in dev mode) unless the current path matches `disable_on_paths`.
- **Field API:** `CookieDeclaration` field type + widget + `CookieDeclarationFormatter`.
- **Security:** admin-gated config; embeds a known third-party consent script by design.

See [configure/cookiehub.md](configure/cookiehub.md)
