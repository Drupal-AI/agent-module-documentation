<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Settings and Labels — agent index

Site-builder-defined "settings" stored as **content** entities (`site_setting_entity`) whose
bundles are **config** entities (`site_setting_entity_type`), with a grouping config entity
(`site_setting_group_entity_type`). Configure route:
`site_settings.site_settings_config_form` → `/admin/config/site-settings/config`.

- **Config object, settings types, groups, admin routes, drush recipes** →
  [configure/settings-types.md](configure/settings-types.md)
- **Loading settings in PHP (loader plugins, services, replicator)** →
  [api/load-settings.md](api/load-settings.md)
- **Twig functions, blocks, tokens, templates and theme suggestions** →
  [theming/twig-and-blocks.md](theming/twig-and-blocks.md)
- **The `site_settings_loader` plugin type and how to write one** →
  [plugins/site-settings-loader.md](plugins/site-settings-loader.md)
- **The ten permissions** → [permissions/permissions.md](permissions/permissions.md)

Submodule (own docs): **site_settings_type_permissions** →
`../../modules/site_settings_type_permissions/2.0.x/agent/start.md`

Key facts:
- Entity types: `site_setting_entity` (content, revisionable + translatable, bundle key `type`,
  label key `name`, extra key `group`), `site_setting_entity_type` (bundle config entity with
  `id`, `label`, `group`, `multiple`), `site_setting_group_entity_type` (config entity `id`, `label`).
- Config object: `site_settings.config` — `template_key`, `loader_plugin`, `disable_auto_loading`,
  `hide_description`, `hide_advanced`, `hide_group`, `simple_summary`, `show_groups_in_menu`,
  `edit_form_on_canonical_route`.
- Plugin type: **`site_settings_loader`** (manager `plugin.manager.site_settings_loader`),
  shipping `full` (recommended) and `flattened` (legacy, auto-loads into every template).
- Six Twig functions, two blocks, two token types, ten permissions, no Drush commands.
