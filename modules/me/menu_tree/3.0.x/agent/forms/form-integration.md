<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form integration & hooks

All hooks live on the attribute-based OOP hook object `Drupal\menu_tree\Hook\MenuTreeHooks`
(a `ContainerInjectionInterface` service). There is **no `.module` file** and no legacy hook
wrappers. Nothing here is meant to be called by other modules; this documents what the module
does to core forms, in addition to the service decorator that actually swaps in the widget
(see [../api/services.md](../api/services.md)).

| Hook | Method | Effect |
| --- | --- | --- |
| `help` | `help()` | Help text on `help.page.menu_tree`. |
| `form_node_type_form_alter` | `nodeTypeFormAlter()` | Adds the **Use tree widget for parent link** checkbox to the node type form's `menu` section; `nodeTypeFormBuilder` saves it as the `use_tree_widget` third-party setting. |
| `form_node_form_alter` | `nodeFormAlter()` | When `use_tree_widget` is on, appends `FormSubmitHandler::handleNodeFormSubmit` to every non-preview submit button. |
| `form_views_ui_edit_display_form_alter` | `viewsUiEditDisplayFormAlter()` | Removes a `#states` visibility entry on the menu parent and appends `handleViewsFormSubmit`. |
| `form_menu_link_content_form_alter` | `menuLinkContentFormAlter()` | Sets `drupalSettings.menu_tree.titleElementName = 'title[0][value]'` and appends `handleMenuLinkFormSubmit`. |
| `form_menu_form_alter` | `menuFormAlter()` | Adds a **Weight** element to the menu edit form (ordering menus in the widget); `menuFormBuilder` saves it as the `menu_tree:weight` third-party setting. |
| `preprocess_form_element_label` | `preprocessFormElementLabel()` | Drops the `for` attribute on the tree's label (`#id` starting `menu-tree`) — no single input to point at. |

The three handlers that add a submit callback (`form_node_form_alter`,
`form_views_ui_edit_display_form_alter`, `form_menu_link_content_form_alter`) all declare
`order: new OrderAfter(['menu_ui'])`, so they run after core `menu_ui` has built its menu
elements. `form_menu_form_alter` and `form_node_type_form_alter` carry no ordering constraint
(the latter does, `OrderAfter(['menu_ui'])`).

## How the widget actually appears

Unlike 2.x, the swap-in is **not** done in `form_node_form_alter`. It happens in the decorated
`menu.parent_form_selector` service (`MenuTreeParentFormSelector::parentSelectElement()`), which
changes the returned element to `#type => 'menu_tree'`:

- **Node forms** — tree used only when the node type has `use_tree_widget` enabled. The
  form-alter's sole job is to attach the submit handler; the element itself is produced by
  menu_ui calling the parent-form selector.
- **Views UI menu display** and **menu-link content form** — tree always used (not a node
  route), with the matching submit handler attached by the alter above.

The `menu_tree` element's process callback (see [../api/services.md](../api/services.md)) hides
core's weight element and builds the component from access-checked menu links, so links the user
cannot see are never listed. Access is otherwise inherited entirely from the host form and
menu_ui — the widget only appears where core already shows the menu parent control.

## On submit

The attached `FormSubmitHandler` method reads the chosen `menu_parent` and the hidden
`prev_sibling` / `next_sibling` values the JS populated, then repositions the link and rewrites
the weights of the whole target branch (`-50`, incrementing) via the menu link manager. See
[../api/services.md](../api/services.md) for the per-form details.
