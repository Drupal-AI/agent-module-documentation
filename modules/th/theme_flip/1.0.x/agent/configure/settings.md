<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Theme Flip

Settings form: `/admin/config/user-interface/theme-flip` (`administer theme flip`).

- **Allowed themes**: only installed themes you select appear in the widget and are accepted by `/theme-flip/switch/{theme}`; anything else returns 400.
- **Widget visibility**: choose which pages show the floating widget.

How switching works:
1. The browser fetches a CSRF seed from `/theme-flip/token` (GET) — this also seeds the session so the token validates later.
2. It POSTs to `/theme-flip/switch/{theme}` with an `X-CSRF-Token` header and a JSON body `{ "path": "/current/path" }`.
3. `SwitchController` validates the token, checks the theme against the allow-list and `themeExists()`, stores it under the session key, resets the active theme, and re-renders the page via an internal sub-request.
4. The negotiator (`FlipThemeNegotiator`) applies the session theme on subsequent requests, except on admin routes.

The preview is per-visitor and never writes to `system.theme` — the site default is untouched.
