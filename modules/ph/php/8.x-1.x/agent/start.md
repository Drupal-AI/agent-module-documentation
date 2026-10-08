<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PHP Filter (php) — agent index

**Adds a text-format filter that evaluates embedded PHP via `php_eval()` (a wrapper around `eval()`). Dangerous by design — this is why core removed it.**

- **Version:** 8.x-1.x (info.yml `8.x-1.2`)
- **Core:** ^9 || ^10 (Drupal 10 contrib; no D11 release)
- **Dependencies:** `filter` (core).
- **Configure:** `filter.admin_overview` (`/admin/config/content/formats`).
- **Permission:** `use PHP for settings` (`restrict access: true`) — grants arbitrary PHP/code execution to whoever holds it and can author in a PHP-enabled format.
- **Code:** `php_eval()` in `php.module` runs `eval('?>' . $code)` with output buffering (documented, intended behaviour).

**Security:** intentional arbitrary-code-execution feature, gated by the restricted `use PHP for settings` permission and by which text formats enable the filter. **Not a vulnerability** — it is the module's purpose — but the highest-risk capability on a site: grant to fully trusted users only, never enable on formats reachable by untrusted roles, prefer custom modules instead.

See [configure/filter.md](configure/filter.md).
