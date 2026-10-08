<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node-form integration & menu-link updater

All runtime behaviour lives in `dynamic_menu_item.module` (no services/plugins).

## `dynamic_menu_item_form_node_form_alter(&$form, FormStateInterface $form_state)`
`hook_form_BASE_FORM_ID_alter()` for `node_form`. Reads `dynamic_menu_item.settings`, gets the node from `$form_state->getFormObject()->getEntity()`, and only acts when `in_array($node->getType(), $config->get('enabled_content_types'))`. When enabled it:
- Adds `$form['promote']['dynamic_menu_item']` — a `checkboxes` element with a single option `['dynamic_menu_item' => $config->get('node_edit_option_title')]` (label from config).
- Iterates `$form['actions']` and appends `dynamic_menu_item_form_node_form_submit` to every submit button except `preview`.

## `dynamic_menu_item_form_node_form_submit($form, FormStateInterface $form_state)`
Runs on node save. If `dynamic_menu_item` is not empty and its `['dynamic_menu_item']` value `!== 0` (i.e. the box was ticked), it takes the node id from the form entity and calls `dynamic_menu_item_update_dynamic_menu_item($node->id())`.

## `dynamic_menu_item_update_dynamic_menu_item($nid)`
Creates or updates the single managed `menu_link_content` link:
1. `loadByProperties(['title' => menu_item_title, 'weight' => menu_item_weight])` on `menu_link_content` storage — if a match exists, reloads it via `MenuLinkContent::load()` (defensive against manual deletion); otherwise `MenuLinkContent::create()`.
2. Splits `menu_item_parent` on `:` (limit 2) into `$menu_name` and `$parent` (`$parent = null` if absent).
3. Sets `title`, `description`, `link` = `['uri' => 'internal:/node/' . $nid]`, `menu_name`, `parent`, `weight` from config and `$nid`, then `save()`.

Net effect: because the lookup key is `menu_item_title` + `menu_item_weight` (both from config), the same link is reused every time, so ticking the box on a different node **repoints the one existing link** to that node. The link target is always `internal:/node/<nid>` — a node id, never a free-form URL.

## Access & permissions
- The settings/administration route is gated by `administer dynamic menu item`.
- The module also declares an `edit dynamic menu item` permission, intended (per the README) to identify who may assign a node to the dynamic menu link.
- The node-form checkbox is added on the edit forms of the content types listed in `enabled_content_types`. Exposing a content type to this feature lets its editors retarget the managed menu link when they save a node, so scope enabled content types and node-edit roles accordingly.
