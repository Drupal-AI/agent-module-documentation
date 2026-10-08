<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pax — agent index

Reduces git conflicts in config exports by sharding large config entities into multiple YAML
files. Developer/deployment tool; no UI, no permissions. Provides a Drush command.

Quick facts:
- `ShardingFileStorage` = a copy of core `FileStorage`, `class_alias()`'d early to fully replace config file storage; shards nested sections on export, recombines on import.
- `hook_entity_type_build()` sets the `PAX_SHARDS` (`pax_shards`) key: `entity_view_display` → `content`; `entity_form_display` → `content`, `third_party_settings.field_group`; `field_config` → `settings.handler_settings.target_bundles_drag_drop`.
- Drush: `PaxCommands` (`drush.services.yml`).
