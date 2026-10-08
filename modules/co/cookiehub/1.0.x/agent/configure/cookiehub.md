<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Cookiehub

## Settings
`/admin/config/services/cookiehub` (permission `administer cookiehub configuration`). Stored in `cookiehub.settings`:
- `id` — 8-digit CookieHub code (from https://dash.cookiehub.com/domain).
- `enable` — master switch; when off, no script is attached.
- `dev_mode` — load `https://dash.cookiehub.com/dev/<id>.js` instead of `https://cookiehub.net/c2/<id>.js`.
- `automatic_cookie_blocking` — when on, attaches the script via `src` and runs `window.cookiehub.load(cpm)` on `DOMContentLoaded`; when off, injects the classic inline async loader snippet.
- `disable_on_paths` — newline-separated path patterns (`*` wildcard); the current path's alias is resolved and matched with `path.matcher`, and on a match the script is not attached.

## Injection
`cookiehub_page_attachments()` runs only when `enable` is set. It adds two `html_head` entries (the loader and the init script) at weights -1000/-999.

## Cookie declaration field
The module also ships a `CookieDeclaration` field type with a widget and `CookieDeclarationFormatter`, so a cookie-declaration element can be placed on a page/entity for a cookie-policy display.

## Note
Provide `id` as a plain 8-digit code.
