<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attaching and rendering MILE references

## Editing (form alter)
For users with `administer mile references`, `mile_form_menu_link_content_form_alter()` adds a **MILE references** fieldset to the menu-link edit form (`/admin/structure/menu/.../edit`):
- `mile_content_type` — none / block / block_content / node
- `block_target` / `block_content_target` (+ `block_content_target_view_mode`) / `node_target` (+ `node_target_view_mode`)

The selection is saved into the menu link's link `options['mile_references']` via the `mile_menu_link_content_form_entity_builder` entity builder. Using `<nolink>` as the link value is recommended.

## Rendering
- `mile_preprocess_menu()` and `MileMenuLinkTreeDecorator::build()` (decorating `menu.link_tree`) call `_mile_render_menu_items()`, which reloads the referenced entity, builds it with the stored view mode, and replaces `$item['title']` with the rendered markup. The decorator ensures references also render when a menu is built via `\Drupal::menuTree()`.
- block_content lacks a default theme wrapper, so `hook_theme()` registers `block_content_mile` with a template and per-type / per-view-mode suggestions (`block-content-mile--type-<type>[--<view_mode>].html.twig`).

## Security consideration
`_mile_render_menu_items()` renders the referenced entity **without calling `->access('view')`** first. Since menus render for all users (including anonymous), a referenced entity that is unpublished/access-restricted later, or a low-visibility block_content, can appear in the menu to users who couldn't otherwise view it. Mitigations: keep `administer mile references` restricted to trusted editors, reference only intentionally-public content, and prefer published, world-viewable entities.
