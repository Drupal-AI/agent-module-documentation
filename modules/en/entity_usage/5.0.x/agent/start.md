<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage (entity_usage) — agent index

Tracks which entities reference which (source → target) and surfaces "where used"
info. Records live in the `entity_usage` DB table (`hook_schema()` in
`entity_usage.install`). **No hard module deps.** Core requirement `^11.4 || ^12`.
License GPL-2.0-or-later. Version 5.0.0. Package `Other`. Config UI: **Admin →
Config → Content Authoring → Entity Usage Settings**
(`/admin/config/entity-usage/settings`, route `entity_usage.settings.form`).

## What it provides
- **Config** (`entity_usage.settings`): tracked source/target types, active plugins,
  Usage tab types, edit/delete warnings, site domains, items-per-page →
  [configure/settings.md](configure/settings.md)
- **Rebuild the usage table** (batch UI form + `entity-usage:recreate` drush) →
  [configure/batch-update.md](configure/batch-update.md) and
  [drush/entity_usage.md](drush/entity_usage.md)
- **Tracking methods** (`EntityUsageTrack` plugin type) & writing one →
  [plugins/track.md](plugins/track.md)
- **Read/write usage data** (`entity_usage.usage` service) & resolve URLs to
  entities (`UrlToEntity`) → [api/entity-usage.md](api/entity-usage.md)
- **Block a tracking record** via `hook_entity_usage_block_tracking()` →
  [hooks/entity_usage.md](hooks/entity_usage.md)
- **Permissions** (3, two restricted) → [permissions/entity_usage.md](permissions/entity_usage.md)

## Routes
- `entity_usage.usage_list` — `/admin/content/entity-usage/{entity_type}/{entity_id}`
  (report; perm `access entity usage statistics` + view access on the target,
  `ListUsageController`).
- `entity_usage.settings.form` — `/admin/config/entity-usage/settings`
  (`EntityUsageSettingsForm`, perm `administer entity usage`).
- `entity_usage.batch_update` — `/admin/config/entity-usage/batch-update`
  (`BatchUpdateForm`, perm `perform batch updates entity usage`).
- Per-entity-type `entity.{type}.entity_usage` at `{canonical|edit-form}/usage` —
  added dynamically by `Routing\RouteSubscriber` for each type in
  `local_task_enabled_entity_types` (`LocalTaskUsageController`).

## Key services (`entity_usage.services.yml`)
- `entity_usage.usage` (`EntityUsage`, iface `EntityUsageInterface`) — the record store.
- `plugin.manager.entity_usage.track` (`EntityUsageTrackManager`) — track plugin manager.
- `entity_usage.entity_update_manager` (`EntityUpdateManager`) — drives tracking on
  entity create/update/delete.
- `entity_usage.batch_manager` (`EntityUsageBatchManager`) — recreate/batch rebuild.
- `Drupal\entity_usage\UrlToEntity` (iface `UrlToEntityInterface`) + `SiteDomains` —
  resolve URL strings to entities via the `URL_TO_ENTITY` event.

## Notable in 5.0.x (major bump from 2.x)
- Core `^11.4 || ^12` (was `^10.3 || ^11`).
- OOP hooks via `#[Hook]` attribute classes in `src/Hook/` (no `.module` procedural
  hooks); plugins use the `#[EntityUsageTrack]` attribute.
- New URL-to-entity event system (`Events::URL_TO_ENTITY`, `UrlToEntity`,
  `UrlToEntityIntegrations/*`: EntityRouting, Language, PublicFile, Redirect).
- Drush command is now a Symfony `Command` — `entity-usage:recreate`
  (aliases `eu-r`, `entity-usage-recreate`) with `--keep-existing-records` and
  `--entity-types` (`src/Drush/Commands/RecreateEntityUsageCommand.php`).
- Separate `entity_reference_revision_field` plugin (paragraphs) plus the
  `EntityUsageInlineTrackingInterface` for inline entities (always-on tracking).
- Optional integration with the **Trash** module in the usage report.
