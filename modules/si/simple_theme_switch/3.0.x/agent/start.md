<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Theme Switch (simple_theme_switch) — agent index

**Theme negotiator that applies the admin theme to `/user/login`, `/user/password`, `/user/reset/...` and any hook-opted route.**

- **Version:** 3.0.x (3.0.0)
- **Core:** >=10
- **Service:** `simple_theme_switch.theme.negotiator` (tag `theme_negotiator`) → returns `system.theme:admin`
- **Applies to routes:** `user.login`, `user.pass`, `user.reset.form`
- **Extension hook:** `hook_simple_theme_switch_flag_for_applies_of_admin_theme(RouteMatchInterface $route_match, Request $request): bool` (see `simple_theme_switch.api.php`)
- **Config/routes/permissions:** none of its own; uses the site's configured admin theme

**Security:** no routes, forms, permissions or endpoints. Only affects which theme renders already-public account pages; no access implications.
