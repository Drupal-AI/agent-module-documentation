<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dblog_ban — install, configure, and expose the Ban/Unban link

## Install / enable
- Requires core `ban` and `dblog` (info.yml `dependencies`). No Composer requirements.
- `drush en dblog_ban -y`. `dblog_ban.install` ships only `dblog_ban_update_8000()` (a no-op to register a schema version); there is no install-time data beyond the config default.

## Make the link appear (required manual step)
Enabling the module does NOT show the link automatically. Edit the watchdog view at
`/admin/structure/views/view/watchdog`, add the field named **Ban/Unban link** (machine name
`dblog_ban_ban_unban_link`), and save. The links then render at `/admin/reports/dblog`.
The field is provided via `hook_views_data()` in `dblog_ban.views.inc`, which registers
`watchdog.dblog_ban_ban_unban_link` bound to the `DblogBanBanUnbanLink` field plugin. The field
is separate from core's Operations column (unlike the Drupal 7 version). A ban/unban link on the
single-event page `/admin/reports/dblog/event/{event_id}` is not provided.

## Settings form
- Route `dblog_ban.settings` → `/admin/config/user-interface/dblog_ban` (`Form\SettingsForm`,
  a `ConfigFormBase`). Menu link under `system.admin_config_ui` (User interface group).
- Permission to reach it: `change global dblog_ban settings` (defined in
  `dblog_ban.permissions.yml`; this is the module's only own permission).
- One checkbox: **Use AJAX ban/unban links** → config key `use_ajax_links`.

## Config object
- Name: `dblog_ban.settings` (schema `config/schema/dblog_ban.schema.yml`, type `config_object`).
- Keys:
  - `use_ajax_links` (boolean, default `true` from `config/install/dblog_ban.settings.yml`).
- When `true`: `BanLinkGenerator` attaches `core/drupal.ajax` and the `use-ajax` class, so a click
  bans/unbans immediately and swaps the link in place (no confirmation page).
- When `false`: the link points at the `nojs` route, which returns a confirmation form
  ("Are you sure you want to ban %ip?") before acting.

## Permissions summary
- `change global dblog_ban settings` (own) — access the settings form only.
- `ban IP addresses` (core `ban` module) — required by the `dblog_ban.ban` / `dblog_ban.unban`
  routes; this is what actually authorizes banning/unbanning.

## Drupal 7 migration
`migrations/dblog_ban_settings.yml` (`id: dblog_ban_settings`, tags Drupal 7 / Configuration)
reads the D7 `variable` `dblog_ban_use_ajax_links` and writes it to `dblog_ban.settings`
`use_ajax_links`. Migration state registered in `migrations/state/dblog_ban.migrate_drupal.yml`.

## Notes / caveats
- The module never renders a ban link for your current request IP (`IpValidator::isMyIp()`), and
  never for hostnames that are not valid public IPs (private/reserved ranges excluded). On hosts
  with multiple public-facing IPs it is still theoretically possible to ban yourself; recover via
  Drush or direct DB access to core's ban list.
