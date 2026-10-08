<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Developer console (developer_console) — agent index

On-site developer tool for Drupal 9/10/11. Provides an admin console that executes ad-hoc **PHP code** and **DB queries** at `/admin/console`, keeps a small run history, tracks execution time, and ships **Kint** dump helpers for PHP and Twig. Version dir `2.x` (dev branch; `type: module`, package `Development`).

## Dependencies
- Drupal core `^9 || ^10 || ^11`.
- Composer library `kint-php/kint:>=5.0` (autoloaded; provides `\Kint`).
- No dependent Drupal modules. Front-end library `developer_console/ui` (jQuery, `js/developer_console.js`) drives the history UI.

## What it provides
- **Routes** (`developer_console.routing.yml`): `developer_console.console` → `/admin/console` (Form `DeveloperConsoleForm`); `developer_console.sandbox_form` → `/admin/console/form` (Form `DeveloperConsoleSandboxForm`). Both `_admin_route`, both require permission `access console`.
- **Permissions** (`developer_console.permissions.yml`, both `restrict access: TRUE`): `access console` (reach the console), `access debug info` (see dump output from `kdpm`).
- **Schema** (`developer_console.install`): table `developer_console_history` (`hid`, `type`, `input`) — keeps last 10 entries per input type.
- **Services** (`developer_console.services.yml`): `StackMiddleware\DevInit` (http_middleware, priority 1000) calls `TimeCounter::initialize()`; `dev_time_counter` = `TimeCounter` (per-request timing, gated by `settings.php` `dev_time_counter_enabled` + `track_time` query string); `Twig\KintExtension` (adds Twig `kdpm()` function); `EventSubscriber\EventSubscriber` (dumps route/request info when State `dev.path_info` is TRUE).
- **Global helpers** (`developer_console.module`): `kdpm()`, `debug_info()`, `var_size()`, `time_monit()`, and internal `_developer_console_kint_output()`. `hook_form_alter` dumps form id/class when State `dev.forms` is TRUE.
- No config entities, no config schema, no Drush commands, no plugin types.

## Solution docs
- [Console: run PHP & SQL](console/console.md) — the console form, execution model, history, routes/permissions.
- [Kint dump helpers](api/dump-helpers.md) — `kdpm()` flags, `debug_info()`, `var_size()`, `time_monit()`, Twig `kdpm()`.
- [Request timing & debug toggles](api/timing-and-toggles.md) — `TimeCounter`/middleware, State `dev.forms`/`dev.path_info`.
