<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OPcache Control (opcachectl) — agent index

Inspect **PHP OPcache** status/configuration and **reset** the opcode cache from Drupal — via an
admin confirm form, a JSON control route for deploy tooling, and richer status-report pages that
replace core's OPcache requirement line. Version **3.x** (installed `3.0.0-beta5`). Package
*Performance and scalability*. Core `^10 || ^11`. License GPL-2.0-or-later. **No module
dependencies**; needs the PHP **Zend OPcache** extension. No config entities, no config schema, no
Drush commands.

- **Routes, the two permissions, the settings.php-driven control access check, and how to operate
  reset from CI/CD** → [config/routes-and-access.md](config/routes-and-access.md)
- **The report pages, theme hooks, preprocessors, `opcachectl_reset()`, and the Twig extensions** →
  [api/status-and-reset.md](api/status-and-reset.md)

## What it provides (from source)

- **Routes** (`opcachectl.routing.yml`):
  - `opcachectl.report.stats` → `/admin/reports/opcache` (perm `access opcache statistics`).
  - `opcachectl.report.config` → `/admin/reports/opcache/config` (perm `access opcache statistics`).
  - `opcachectl.reset.form` → `/admin/config/system/opcache/reset` (perm `reset opcache`), a
    `ConfirmFormBase`.
  - `opcachectl.control.get` → GET `/system/opcachectl`, `_format: json`, custom access
    `_opcachectl_access` — returns `opcache_get_status(FALSE)`.
  - `opcachectl.control.purge` → PURGE `/system/opcachectl` and `opcachectl.control.post` → POST
    `/system/opcachectl/reset` — both call `OpcacheCtlController::controlPurge()` → reset.
- **Permissions** (`opcachectl.permissions.yml`): `reset opcache`, `access opcache statistics`.
- **Controllers** (`src/Controller/`): `OpcacheReportController` (`viewStatistics`, `viewConfig`);
  `OpcacheCtlController` (`controlGet`, `controlPurge`) returning `JsonResponse`.
- **Access check** (`src/Access/OpcacheCtlAccess.php`, service `opcachectl.access_check`, applies to
  `_opcachectl_access`): allows same-machine requests, IP-allowlisted clients
  (`$settings['opcachectl_reset_remote_addresses']`), or a matching `?token=`
  (`$settings['opcachectl_reset_token']`); otherwise forbidden.
- **Form**: `src/Form/ConfirmResetOpcacheForm.php` → `opcachectl_reset()`, redirects to the stats page.
- **Procedural** (`opcachectl.module`): `opcachectl_reset()` (wraps `opcache_reset()` with status
  guards + logging), theme hooks `opcache_stats` / `opcache_config`, and their preprocessors.
- **Install** (`opcachectl.install`): `hook_requirements` (runtime) reporting extension/enabled
  state and remote-reset config; `hook_runtime_requirements_alter` removes core's `php_opcache` line.
- **Twig extensions** (`src/Twig/Extension/`): `FormatSize` (filter `format_size`), `TypeTest`
  (test `of_type`, filter `get_type`), registered in `opcachectl.services.yml`.
- **Templates**: `templates/opcache-stats.html.twig`, `templates/opcache-config.html.twig`.

## Notes

- No `opcachectl.settings` route exists, yet `opcachectl.links.menu.yml` declares a menu link
  pointing at it (parent of the `Reset` link) — those two Configuration-menu links reference a
  missing route. The working entry points are the Reports pages, the reset confirm form path, and
  the control route. `data.json` `configure` is therefore `null`.
- Remote reset is **off** unless you set `opcachectl_reset_remote_addresses` and/or
  `opcachectl_reset_token` in `settings.php` — see [config/routes-and-access.md](config/routes-and-access.md).
