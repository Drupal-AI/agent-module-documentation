<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper — agent index

Developer toolkit: services, static utilities, form elements, blocks, Twig helpers, Drush commands
and opt-in behavior tweaks. **No configure route** (`configure: null`), no permissions, no plugin
manager. Depends on core `file`. State that exists on a site: the `helper.settings` config object.

- **Optional behavior "helpers" (`helper.settings` toggles) and how to enable/disable them** →
  [configure/helpers.md](configure/helpers.md)
- **Injectable services + static helpers (Config, EntityType, CurrentEntity, Menu, File, Theme,
  TextFormat, ArrayHelper, Utility)** → [api/services.md](api/services.md)
- **Drush commands (module schema versions, post-update reset, install-profile switch)** →
  [drush/commands.md](drush/commands.md)
- **Form element, blocks, Twig helpers, service tag, route requirement, theme regions, constraints**
  → [extend/toolkit.md](extend/toolkit.md)

Key facts:
- `helper.settings:enabled` is a map of toggles read by `_helper_is_enabled($key, $default)`
  (e.g. `core_form_novalidate`, `core_text_textarea_widgets`, `redirect_entity_4xx_to_edit`,
  `core_hide_layout_providers`, `media_oembed_iframe_title`, `tmgmt_hide_if_not_multilingual`,
  `layout_builder_*`, `menu_links_prefer_deepest`).
- Services use `autowire`; the class FQCN is aliased to the `helper.*` service id, so you can
  type-hint e.g. `Drupal\helper\EntityType` or `Drupal\helper\Config`.
- Drush command ids: `install-profile:switch`, `module:schema-version:get|set|delete|cleanup`,
  `module:post-update:reset`.
- Adds `helper_entity_select` element, blocks `helper_node_field`/`helper_context_entity`, Twig
  `format_bytes`/`file_data_uri`, service tag `module_dependency`, route requirement `_is_multilingual`.
