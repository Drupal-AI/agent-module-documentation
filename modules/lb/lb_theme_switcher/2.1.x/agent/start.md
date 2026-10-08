<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Theme Switcher (lb_theme_switcher) — agent index

**Theme negotiator that switches to a Layout Builder-capable theme (e.g. Open Y Carnation) when viewing Layout Builder pages; optional for 404/403 and webform routes.**

- **Version:** 2.1.x
- **Core:** ^11 (targets Open Y / YMCA; effectively needs core `layout_builder`)
- **Configure:** `/admin/openy/settings/theme-switcher` — route `lb_theme_switcher.form` (permission `administer site configuration`). Config `lb_theme_switcher.settings` (`theme_name`, `handle_http_exception_routes`, `handle_webform_routes`).
- **Service:** `theme.negotiator.lb_theme_switcher` (priority 1001). Drush: `lb_theme_switcher:reset-lb-header-footer` / `lbreset`.

**Security:** config route gated by `administer site configuration`; the negotiator only selects among installed, enabled themes and validates the AJAX theme token via CSRF. The Drush reset command uses `accessCheck(FALSE)` but is an admin CLI operation. No security findings.

See [configure/lb_theme_switcher.md](configure/lb_theme_switcher.md) and [drush/lb_theme_switcher.md](drush/lb_theme_switcher.md).
