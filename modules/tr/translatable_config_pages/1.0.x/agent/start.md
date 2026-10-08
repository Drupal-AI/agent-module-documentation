<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translatable config pages (translatable_config_pages) — agent index

Site-settings-as-a-fielded-**content**-entity, with per-language values via core
`content_translation`. A site builder defines a "config pages type" (a bundle), adds any
core/contrib fields to it through Field UI, and edits exactly one values entity per type; those
values are read back in code/Twig via a manager service. Because the values are a content entity
(not configuration), each language gets its own translation through the normal translation UI.

- Dependencies: core `content_translation`, `language`. Core `^8.8 || ^9 || ^10 || ^11`.
- No `configure:` route in info.yml. Types are managed at `/admin/structure/translatable_config_pages_types`; values at `/admin/config/system/translatable-config-pages`.
- Defines: 3 permissions, 1 Drush command, config schema. No custom plugin type (only a menu deriver). No `.module`/hooks.

Solution docs:
- **Define a config-pages type, add fields, enable translation, storage** → [configure/config-pages.md](configure/config-pages.md)
- **Read values in PHP/Twig (manager service)** → [api/manager.md](api/manager.md)
- **Fetch a field value from the CLI** → [drush/commands.md](drush/commands.md)
- **Who can define/edit/view pages** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Content entity: `translatable_config_pages` (base_table `translatable_config_pages`, data_table `translatable_config_pages_field_data`, `translatable = TRUE`).
- Bundle config entity: `translatable_config_pages_type` (config_prefix `translatable_config_pages_type`; each type stores `id`, `label`, `uuid`, `menu`).
- One values entity per type — the add page hides a type once its single page exists.
- Service: `translatable_config_pages.manager` → `loadConfig($bundle, $language = NULL)`, `loadConfigFieldValue($bundle, $field, $language = NULL)`.
- Drush: `translatable_config_pages:getConfigFieldValue` (alias `tcp-gc-fv`).
- Permissions: `administer translatable config pages types`, `manage translatable config pages`, `view translatable config pages`.
- Config schema: `translatable_config_pages.translatable_config_pages_type.*` (`menu.description`, `menu.menu_parent`).
- Menu link deriver: `translatable_config_pages.menus` (`Plugin\Derivative\BuilderMenuItems`) — one admin menu link per type.
- Values are content, so they do **not** move with `drush cex`/`cim` — enter per environment.
