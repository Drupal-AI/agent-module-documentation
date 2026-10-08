<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database logging ban operation (dblog_ban) — agent index

Adds a Ban/Unban link to database log (watchdog) rows so an admin can ban the IP that caused a log message, using core Ban. No external services or libraries.

## Facts
- Core deps (info.yml): `drupal:ban`, `drupal:dblog`. Test-only: `drupal:migrate_drupal`. No Composer requires.
- `core_version_requirement: ^9.4 || ^10 || ^11`; `php: 7.3`; package `User interface`.
- Config: `dblog_ban.settings` (config_object) with one key `use_ajax_links` (boolean, default `true`). Schema in `config/schema/dblog_ban.schema.yml`, install default in `config/install/dblog_ban.settings.yml`.
- Settings route/form: `dblog_ban.settings` at `/admin/config/user-interface/dblog_ban` (`Form\SettingsForm`), gated by permission `change global dblog_ban settings` (the module's only own permission).
- Ban/unban routes reuse core's `ban IP addresses` permission and a custom CSRF requirement `_dblog_ban_csrf_ajax_token`.

## Routes (dblog_ban.routing.yml)
- `dblog_ban.ban` — `/dblog_ban/{js}/ban/{ip}` → `Controller\IpBanUnbanController::ajaxBan`. `{js}` = `ajax|nojs`.
- `dblog_ban.unban` — `/dblog_ban/{js}/unban/{ip}` → `IpBanUnbanController::ajaxUnban`.
- Both require `_dblog_ban_csrf_ajax_token: 'TRUE'` and `_permission: 'ban IP addresses'`. `nojs` returns a ConfirmForm; `ajax` performs the action and returns an AjaxResponse ReplaceCommand.

## Services (dblog_ban.services.yml)
- `dblog_ban.ip_validator` (`Services\IpValidator`) — `isValidIp()` (filter_var public-IP check, <=40 chars), `isMyIp()` (compares to current request client IP), `getCurrentRequestIp()`.
- `dblog_ban.link_generator` (`Services\BanLinkGenerator`) — builds ban/unban `Link`/`Url` render arrays; adds `core/drupal.ajax` + `use-ajax` class when AJAX links enabled; sets `#cache max-age 0`.
- `dblog_ban.watchdog_views_row_parser` (`Services\WatchdogViewsRowParser`) — resolves hostname from a watchdog Views `ResultRow` (`watchdog_hostname` prop, else parameterized `wid` lookup).
- `dblog_ban.access_check.csrf_ajax` (`Services\CsrfAjaxAccessCheck`) + `dblog_ban_route_processor_csrf_ajax` (`Services\RouteProcessorCsrfAjax`) — internal CSRF token generate/validate for the ajax/nojs routes (workaround pending core node/2670798).

## Views + forms
- Views field plugin `@ViewsField("dblog_ban_ban_unban_link")` — `Plugin\views\field\DblogBanBanUnbanLink`; hook_views_data in `dblog_ban.views.inc` attaches it to `watchdog`. Not shown by default — must be added to the watchdog view.
- Confirm forms: `Form\BanUnbanConfirmFormBase` (validates IP, 404 on invalid), `Form\IpBanConfirmForm`, `Form\IpUnbanConfirmForm`.
- D7 migration: `migrations/dblog_ban_settings.yml` maps variable `dblog_ban_use_ajax_links` → `dblog_ban.settings:use_ajax_links`.

## Solution docs
- [config/settings.md](config/settings.md) — install/enable, add the Views field, settings form + config key, D7 migration.
- [api/services.md](api/services.md) — routes, controller flow, services, views field plugin, CSRF mechanism.
