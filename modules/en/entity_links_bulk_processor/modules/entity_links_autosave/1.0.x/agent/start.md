<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Links Auto-Save (entity_links_autosave) — agent index

Submodule of **Entity Links Bulk Processor**. Runs the parent's link/HTML conversion pipeline
automatically on **entity presave** for configured entity types/bundles/fields. Package `Content`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha9.

- Depends on **`entity_links_bulk_processor:entity_links_bulk_processor`** (uses its
  `entity_links_bulk_processor_process_attributes()` and its `entity_links_bulk_processor.settings`
  rules; injects the parent `EntityTypeDiscovery` service in the settings form).
- Provides **1 permission**, **config schema**, a **settings route** (`configure`). No plugins, no
  Drush, no entity types.

## Mechanism (`entity_links_autosave.module`)

- `entity_links_autosave_entity_presave(EntityInterface $entity)`:
  1. returns early if state `entity_links_bulk_processor.processing` is set (bulk/Drush run active);
  2. returns if own config `enabled` is false;
  3. checks the parent's multilingual filters (`process_all_translations`, `process_languages`);
  4. reads own `entity_types.<type>` config (`enabled`, `bundles`, `fields`); processes matching
     `text`/`text_long`/`text_with_summary` fields with the parent function (passing the entity
     langcode), preserving `format`/`summary`;
  5. optionally logs (`enable_debug_logging`) and surfaces validation warnings to the user
     (`enable_user_feedback`).

## Route / permission / config

- Route `entity_links_autosave.settings` → `/admin/config/content/entity-links-autosave/settings`
  (`Form/AutoSaveSettingsForm`, `ConfigFormBase`), `_permission: 'administer entity links autosave'`
  (`restrict access: true`). Menu link under `system.admin_config_content`.
- Config object `entity_links_autosave.settings`: `enabled` (false), `enable_debug_logging` (false),
  `enable_user_feedback` (true), and `entity_types` (map of `{enabled, bundles[], fields[]}` for
  `node`, `paragraph`, `media`, `taxonomy_term`, `block_content`). Schema in `config/schema/`.

## Solution docs

- **Settings, config keys, route & the presave hook** → [config/settings.md](config/settings.md)

Parent project index: [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md)
