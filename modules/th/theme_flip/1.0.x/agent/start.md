<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme Flip (theme_flip) — agent index

**Front-end floating widget to preview allowed themes per-session via AJAX; never changes the site default theme.**

- **Version:** 1.0.3 → dir 1.0.x
- **Core:** ^10.2 || ^11
- **Configure:** `/admin/config/user-interface/theme-flip` (`administer theme flip`)
- **Routes:** `theme_flip.switch` POST `/theme-flip/switch/{theme}` and `theme_flip.token` GET `/theme-flip/token` (`access content`)
- **Service:** `theme_flip.theme_negotiator` (`FlipThemeNegotiator`, priority -10, session-scoped, admin routes excluded)
- **Security:** The switch controller manually validates `X-CSRF-Token` (core's header check is a no-op for anonymous users), enforces a config-driven theme allow-list + `themeExists()`, and sanitises the return path against open-redirect/`://` injection. `access content` is acceptable because the effect is a read-only per-session preview that cannot change the saved default theme or affect other users. No security findings.

See [configure/settings.md](configure/settings.md)
