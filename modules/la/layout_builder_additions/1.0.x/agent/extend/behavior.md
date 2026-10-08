# What Layout Builder Additions changes

Three behaviours, all applied automatically when the module is enabled. Nothing is configurable.

## 1. Meaningful block-form titles

`src/Routing/RouteSubscriber.php` (`alterRoutes`) replaces the static `_title` on:
- `layout_builder.add_block` → `_title_callback` `LayoutBuilderBlockFormTitle::addBlock`
- `layout_builder.update_block` → `_title_callback` `LayoutBuilderBlockFormTitle::updateBlock`

`src/LayoutBuilderBlockFormTitle.php`:
- `addBlock($section_storage, $delta, $region, $plugin_id)` — resolves a label from the plugin id via
  `getLabelFromPluginId()`; returns "Configure block: %label" (block plugin `admin_label`, or the
  `block_content_type` label for `inline_block:<bundle>`), falling back to "Configure block".
- `updateBlock(..., $uuid)` — loads the component being edited from the section, reads its
  `configuration['id']`, and resolves the same label.

## 2. Block add/update form tidy-ups

`layout_builder_additions_form_alter()` acts on form ids `layout_builder_add_block` and
`layout_builder_update_block`:
- Sets `$form['settings']['admin_label']['#access'] = FALSE` (hides the redundant admin-label field).
- If the inline block's bundle is `media`: moves `settings.label` (`#weight -10`) and
  `settings.view_mode` (`#weight -9`) to the top, and renames the view-mode title to "Image size".

## 3. "Layout" entity operation on nodes

`layout_builder_additions_entity_operation()` — for `node` entities — builds a URL to
`layout_builder.overrides.node.view` and adds a `layout` operation (title "Layout", weight 50) **only
if** `$route_url->access($currentUser)` passes. This means the link appears solely for users who already
have Layout Builder override access to that node; it does not grant any new capability.

## Other notes

- `hook_help()` renders `README.md` (via the Markdown filter if `markdown` is enabled, else escaped
  `<pre>`).
- No services beyond `layout_builder_additions.route_subscriber`. No config, permissions, or schema.
