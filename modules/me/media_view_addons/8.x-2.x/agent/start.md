<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media View Add-ons - agent index

Views field for the media admin View: lists edit links to the top-level nodes referencing each media
item (through paragraphs). No routes/perms/config.

Key files:
- `src/Plugin/views/field/MediaViewAddonsNodesField.php` - `@ViewsField("media_view_addons_nodes_field")`,
  reads row `mid`, renders node edit links, invokes `hook_media_view_addons_links()`.
- `src/EntityRelationshipManager.php` (service `media_view_addons.relationship_manager`) - `topLevelNids()`
  walks `{entity}__{field}` tables by `<field>_target_id`, resolving paragraph->node up to nesting limit 5.

SQL uses config-derived field/table names (not user input). Version dir `8.x-2.x`.
