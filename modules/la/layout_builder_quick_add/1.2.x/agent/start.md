<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Quick Add (layout_builder_quick_add) — agent index

Replaces Layout Builder's "Add block" flow: instead of the core "Add block" link opening the
off-canvas sidebar, it swaps that link's URL (via a `#pre_render` on the `layout_builder` render
element) to an AJAX route that renders a compact inline listing of `inline_block:*` block types
directly in the region, plus a "See more blocks" link back to the core off-canvas chooser and a
"Cancel" link. Which block types appear, their order, icons, screenshots, descriptions and a CSS
theme are set on a settings form.

- Depends on core `layout_builder` only. Core requirement `^10 || ^11`.
- Config route (settings form): `/admin/config/content/layout_builder_quick_add`
  (route `layout_builder_quick_add.quick_add_config_form`).
- Defines 1 permission. No Drush commands. No plugin types. No config schema shipped.

What you'd do → doc:
- **Configure which blocks show, order, icons, screenshots, theme** → [configure/settings.md](configure/settings.md)
- **The permission that gates the settings form** → [permissions/permissions.md](permissions/permissions.md)
- **How the add-block link is rewritten; routes & controller** → [hooks/hooks.md](hooks/hooks.md)
- **The helper service and its public methods** → [api/helper.md](api/helper.md)
- **Theme hooks, Twig templates, CSS libraries, block-type icon setting** → [theme/theme.md](theme/theme.md)

Key facts:
- Service: `layout_builder_quick_add.helper` → `Drupal\layout_builder_quick_add\LayoutBuilderQuickAddHelper`.
- Config object: `layout_builder_quick_add.settings`. Keys: `theme`, `display_description`,
  `multiple_view_mode`, `multiple_view_mode_message`, `inline_blocks`, `blocks_order`, and dynamic
  `screenshot:<block_content_type_id>` keys.
- Routes: `layout_builder_quick_add.add_blocks`, `layout_builder_quick_add.cancel_add_blocks`
  (both require `_layout_builder_access: 'view'` + `layout_builder_tempstore` param — the same
  requirement core Layout Builder uses), `layout_builder_quick_add.quick_add_config_form`.
- Controller: `Drupal\layout_builder_quick_add\Controller\LayoutBuilderQuickAddController`
  (`addBlocks`, `cancelAddBlocks`). The actual block insertion is delegated to core
  `layout_builder.add_block` with `plugin_id = inline_block:<block_content_type_id>`.
- Permission: `administer layout_builder_quick_add configuration` (`restrict access: true`).
- Third-party setting on `block_content_type` entities: namespace `layout_builder_quick_add`,
  key `icon` (a file id).
- Theme hooks: `quick_add_blocks_listing`, `quick_add_blocks_listing_item`.
- CSS libraries: `layout_builder_quick_add/default`, `/claro`, `/gin`.
- Hooks implemented: `hook_element_info_alter`, `hook_form_alter`, `hook_page_attachments_alter`,
  `hook_theme`, `hook_install`, `hook_update_8001`.
