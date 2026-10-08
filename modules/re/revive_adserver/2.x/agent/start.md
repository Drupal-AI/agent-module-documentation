<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revive Adserver (revive_adserver) — agent index

Renders **Revive Adserver** (self-hosted, formerly OpenX) ad-zone invocation tags in Drupal,
as a **block** or as a **field** on any fieldable entity. Version **2.x** (installed 2.0.0).
Core `^10 || ^11`. License GPL-2.0-or-later. Depends on core **`block`** and **`field`**.
Composer requires **`szeidler/revive-xmlrpc ^2.5`** (XML-RPC client for zone sync).

## What it provides

- **Config form + object** — `revive_adserver.settings` (route `revive_adserver.settings`,
  path `/admin/config/services/revive-adserver`, permission `administer revive_adserver`).
  Holds `delivery_url`, `delivery_url_ssl`, `publisher_id`, and a `zones` sequence. →
  [config/settings.md](config/settings.md)
- **A plugin type** — `InvocationMethodService` (annotation
  `src/Annotation/InvocationMethodService.php`, manager
  `InvocationMethodServiceManager`, base `InvocationMethodServiceBase`, discovery dir
  `src/Plugin/ReviveAdserver/InvocationMethod/`). Three plugins build the actual ad markup:
  `async_javascript`, `iframe`, `javascript`. → [plugins/invocation-methods.md](plugins/invocation-methods.md)
- **Block** — `revive_adserver_zone_block` (`ReviveAdserverZoneBlock`): pick zone + method per
  block. → [blocks/zone-block.md](blocks/zone-block.md)
- **Field** — field type/widget/formatter all id `revive_adserver_zone` (`ReviveItem`,
  `ReviveWidget`, `ReviveFormatter`): attach a zone to an entity; optional per-entity method.
  → [fields/field.md](fields/field.md)

## Permissions (`revive_adserver.permissions.yml`)

- `administer revive_adserver` — reach the settings form / sync zones.
- `use revive_adserver field` — gates the `zone_id`/`invocation_method` inputs in the field widget.

## Service

- `plugin.manager.revive_adserver.invocation_method_service` — the plugin manager
  (`InvocationMethodServiceManager`, extends `DefaultPluginManager`, takes `@config.factory`).

## Notes

- No content/config entity of its own; zones live inside the `revive_adserver.settings` config
  object. No Drush commands, no routes other than the settings form.
- `hook_requirements()` (in `.install`) raises a runtime warning until `delivery_url`,
  `delivery_url_ssl`, `publisher_id` and `zones` are all set.
