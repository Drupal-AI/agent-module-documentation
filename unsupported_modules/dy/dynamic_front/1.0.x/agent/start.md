<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic front [deprecated] (dynamic_front) — agent index
**Redirects the front page to the first admin-listed URL the current user can access. Obsolete — use `dynamic_links`.**

- **Version:** 1.0.x — `lifecycle: obsolete` (successor: dynamic_links). Requires PHP 8.0.
- **Core:** ^9 || ^10.
- **Routes:** `dynamic_front.settings` `/admin/config/system/dynamic-front` (`administer site configuration`); dynamic `dynamic_front.redirect` at the site front path (`access dynamic_front`, `no_cache`) via `DynamicFrontRoutes::routes()`.
- **Permission:** `access dynamic_front`.
- **Controller:** `DynamicFrontController::redirect()` returns the first configured URL passing `Url::fromUserInput($url)->access()`, else `AccessDeniedHttpException`.
- **Security:** redirect targets are admin-configured internal paths; each candidate is access-checked before redirect, so no open-redirect or access bypass. No security findings.
