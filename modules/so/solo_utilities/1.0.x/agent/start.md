# Solo Utilities — agent index

Companion module for the **Solo** theme. Three independent features, all inert unless Solo (or a
sub-theme of Solo) is the active default front-end theme. No global `configure` route; feature
toggles live in the Solo theme settings form (`enable_custom_node_width`, `enable_block_title_visibility`).
Depends on core `node`. Provides a config schema and permissions; no Drush, no plugin types.

- **Color Schemes Rules (config entity, conditions, negotiator), block title visibility/tag, custom node widths** → [configure/features.md](configure/features.md)
- **Permissions and the theme-gated access check** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Everything is gated by `solo_utilities__is_solo_or_sub_in_hierarchy_active()` (checks `system.theme` default).
- Color scheme rules: config entity `color_schemes_rule`, schema `solo_utilities.color_schemes_rules.*`, admin at `/admin/config/solo_utilities/color-schemes-rules`; evaluated by service `solo_utilities.color_schemes_negotiator`.
- Block title settings stored in `block.settings.solo_block_title_visibility` (`visible|visually_hidden|none`) and `solo_block_title_tag` (`h1`–`h6`/`div`).
- Node widths stored in content entity `node_width` (DB table `solo_theme_node_width`), NOT config.
