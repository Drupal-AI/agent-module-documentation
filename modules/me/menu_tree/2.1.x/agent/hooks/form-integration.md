# Form integration & hooks

All hooks live on the autowired OOP hook object `Drupal\menu_tree\Hook\Hooks` (with thin
`#[LegacyHook]` wrappers in `menu_tree.module` for BC). Nothing here is meant to be called by other
modules; this documents what the module does to core forms and its load order.

| Hook | Method | Effect |
| --- | --- | --- |
| `help` | `Hooks::help()` | Help text on `help.page.menu_tree`. |
| `form_node_type_form_alter` | `Hooks::nodeTypeFormAlter()` | Adds the **Use tree widget for parent link** checkbox to the node type form's menu section; entity builder saves it as the `use_tree_widget` third-party setting. |
| `form_node_form_alter` | `Hooks::nodeFormAlter()` | When the setting is on, swaps in the tree widget on node add/edit forms. |
| `preprocess_form_element_label` | `Hooks::preprocessFormElementLabel()` | Drops the `for` attribute on the tree's label (no single input to point at). |
| `module_implements_alter` | (in `.module`) | Re-orders `menu_tree` last for the two form-alter hooks. |

Both form alters declare `order: new OrderAfter(['menu_ui'])`, and `hook_install()` sets the module
weight to `1`, so the alters run after core `menu_ui` has built its menu elements.

## What `nodeFormAlter()` does when enabled

1. Reads `use_tree_widget` off the node's content type; returns early if off.
2. Reads menu_ui's `available_menus` for the bundle; returns early if none.
3. Optional `menu_ui_async_widget` support: if that module is installed and its async widget is on
   for the bundle, it targets `$form['menu']['container']` and defers until the async element is
   present.
4. Hides core's `menu[link][menu_parent]` and `menu[link][weight]` (`#type => 'hidden'`).
5. Injects the `menu_tree:menu-tree` component (see [../theme/component.md](../theme/component.md))
   built from `MenuTreeItems::getLinks()` for each available menu, excluding the node's own link,
   with `#cache => ['max-age' => 0]`.
6. Adds hidden `prev_sibling` / `next_sibling` inputs (populated by the JS).
7. Appends `NodeFormSubmitHandler::handleFormSubmit` to every non-preview submit button.

Access is entirely inherited from the node form and menu_ui: the widget only appears where core
already shows the menu section, and the tree is built with core's access-checking manipulators
(see [../api/services.md](../api/services.md)), so links the user cannot see are not listed.
