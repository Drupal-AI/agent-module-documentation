# How it works (mechanism)

No services to call and no plugins — the module is form alters plus helper `.inc` files. This
doc is the map so you do not have to read the source.

## Entry points

- `menu_link_weight_form_node_form_alter()` (`menu_link_weight.node.inc`) — on the **node edit
  form**:
  - hides core's menu weight select: `$form['menu']['link']['weight']['#access'] = FALSE;`
  - injects a `menu_link_weight` fieldset containing a `#type => 'table'` with
    `#tabledrag` (id `menu-link-weight-reorder`, group `menu-link-weight-item-weight`),
  - adds a `#process` callback `menu_link_weight_node_element_process` and validate/submit
    handlers (`menu_link_weight_node_form_validate` / `..._submit`).
- `menu_link_weight_form_menu_form_alter()` (`.module`) — on the **menu overview form**, adds
  anchor ids so a menu item can be linked to directly from the node form.
- `menu_link_weight.menu_ui.inc` — the equivalent handling for the menu-link add/edit UI.
- `menu_link_weight.reorder.inc` — shared reorder helpers used by other modules.

## The reorder model

- `_menu_link_weight_get_options($menu, $parent, $current_mlid, $new_title)` builds the ordered
  sibling list for a given parent, each entry carrying `title`, a computed `weight`, and the
  current `db_weight`. Weights are re-spread across `MENU_LINK_WEIGHT_MIN_DELTA` (−50) …
  `MENU_LINK_WEIGHT_MAX_DELTA` (50) for fine control, and a placeholder row (`link_current`) is
  added for a not-yet-saved link.
- `_menu_link_weight_get_tree()` loads the sibling tree via `menu.link_tree` with the standard
  access/sort manipulators, so access and node-access are respected and disabled links are
  labelled.
- Hidden `db_weights` fields hold the pre-drag weights; on submit the drag order is converted
  back into real menu-link weights and saved.
- The `#process` callback re-queries siblings via AJAX whenever the **parent** menu link
  changes, so the drag list always reflects the selected parent. A no-JS fallback button
  ("Change parent (update list of weights)") reloads the list without JavaScript.

## Parent selector

Independently, the configured `menu_parent_form_selector` (`default`/`cshs`) decides which
parent picker widget is used — see [../configure/settings.md](../configure/settings.md). With
`cshs` (and the cshs module) the `menu.parent_form_selector` service is swapped for
`CshsMenuParentFormSelector`, which renders the parent options as a client-side hierarchical
select (`getParentSelectOptionsCshs()` / `parentSelectElement()`).
