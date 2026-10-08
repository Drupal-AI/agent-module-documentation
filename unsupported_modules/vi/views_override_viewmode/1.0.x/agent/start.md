<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# views_override_viewmode — agent index

**Lets each Views block instance override the entity view mode set on the underlying view display.**

- **Version:** 1.0.x (dev-1.0.x / branch 1.0.x; no packaged version in info.yml)
- **Core:** ^10 || ^11
- **Dependencies:** drupal:block, drupal:views, ctools:ctools_views
- **Display plugin:** `Drupal\views_override_viewmode\Plugin\Display\Block` (extends `ctools_views` Block)
- **Hooks:** `hook_views_plugins_display_alter` (swaps block display class), `hook_config_schema_info_alter` (adds `entity_view_mode`)
- **Config keys:** `views_block.entity_view_mode`, `views.display.block.allow.entity_view_mode`

**Security:** No routes, permissions, or public endpoints — a Views/block display enhancement configured by site builders. Only affects presentation (row `view_mode`). No security findings.
