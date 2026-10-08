<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings — entity_notify.settings

Install/enable: `drush en entity_notify -y` (pulls in `telegram_api`). Configure at
`/admin/config/system/entity_notify` (route `entity_notify.settings`, form
`\Drupal\entity_notify\Form\EntityNotifySettingsForm`, `getFormId()` = `entity_notify_settings_form`).

## Route & permission

- Route `entity_notify.settings` → path `/admin/config/system/entity_notify`, requires permission
  `administer entity_notify configuration` (`entity_notify.permissions.yml`, the module's only
  permission). Menu link `entity_notify.settings` under `system.admin_config_system`.

## Config object `entity_notify.settings`

Editable config (`getEditableConfigNames()`). Install defaults (`config/install/…`): `enable: true`,
`ignore_paths: ''`. Schema `config/schema/entity_notify.schema.yml` (`type: config_object`).

Global fields (mostly the same channel keys reused per bundle — see per-bundle.md):

- `enable` (bool) — master on/off. Description notes you can disable it locally when using
  Config Split. When false, `_entity_notify_event()` returns immediately.
- `ignore_paths` (string) — newline-delimited request URIs; if the current request URI
  (`request_stack`→`getRequestUri()`) exactly matches a line, no notification is sent
  (e.g. `/node/1/edit`).
- `enabled_target_entity_types` (sequence of strings) — machine names of **content entity types**
  to watch, **excluding node and comment** (which are per-bundle). `buildForm()` lists all
  `ContentEntityTypeInterface` definitions and unsets `file`, `user`, `menu_link_content`,
  `path_alias`, `shortcut`, `node`, `comment`. Stored as `array_values(array_filter(...))`.
- `entity_notify_admin` (bool) — email uid=1.
- `entity_notify_roles` (sequence) — role IDs whose active users are emailed.
- `entity_notify_maillist` (string) — comma-separated extra addresses.
- `entity_notify_telegram` (bool) + `entity_notify_telegram_bottoken`,
  `entity_notify_telegram_chatids` (comma-separated), `entity_notify_telegram_queue` (bool),
  `entity_notify_telegram_endpoint` (custom Bot API URL).
- Proxy: `entity_notify_telegram_proxy` (bool), `_proxy_server` (e.g. `127.0.0.1:1234`),
  `_proxy_login`, `_proxy_password` — SOCKS5, passed to `telegram_api`.

The channel portion of the form is built by the shared helper
`_entity_notify_get_email_form(&$form, $is_third_party = FALSE)` in `entity_notify.module`; the
settings form calls it with `FALSE` so defaults come from `entity_notify.settings`.
`submitForm()` writes every key back to `entity_notify.settings`.

## Notes

- The global channel settings apply to entity types listed in `enabled_target_entity_types`.
  Node and comment types ignore these globals and read their own per-bundle third-party settings
  instead (see per-bundle.md).
