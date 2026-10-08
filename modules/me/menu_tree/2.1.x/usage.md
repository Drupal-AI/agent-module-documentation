<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu tree replaces the flat "Parent link" dropdown on node add/edit forms with a browsable, drag-and-drop menu tree, so an editor placing a page in a deep menu can see the structure and position the link precisely instead of scanning a flat list of indented dashes.

---

Core renders the menu parent selector as a `<select>` whose options are the whole menu flattened, hierarchy shown by leading hyphens; on a site with a hundred links across five levels the control becomes unusable. This module lets you enable, per content type, a tree widget: on the node type form's Menu settings tab a "Use tree widget for parent link" checkbox stores a `use_tree_widget` third-party setting on the node type. When on, `Hooks::nodeFormAlter()` (ordered after `menu_ui`, module weight 1) hides core's `menu_parent` and `weight` fields and injects the `menu_tree:menu-tree` Single Directory Component, built from `MenuTreeItems::getLinks()` for each available menu. The component (Twig + JS + CSS under `components/menu-tree/`) draws a nested `<details>` tree of selectable buttons and supports HTML5 drag-and-drop; the JS writes the chosen parent into the hidden `menu[menu_parent]` input and records drop position in hidden `prev_sibling`/`next_sibling` inputs. On submit, `NodeFormSubmitHandler::handleFormSubmit()` inserts the node's link at the chosen spot and rewrites the weights of the whole branch via the menu link manager. The tree is built with core's `checkAccess` and `generateIndexAndSort` manipulators, so only links the user may see are listed, and menu link storage is otherwise unchanged — uninstalling removes the per-type setting and restores the core control. No dependencies beyond core; no routes, permissions, or drush of its own; core requirement `^10.3 || ^11`.

---

- Pick a menu parent from a browsable tree.
- Drag and drop a node's menu link to reorder it within a branch.
- Place a page precisely inside a deep menu structure.
- See menu hierarchy while choosing a parent.
- Collapse or expand irrelevant menu branches with one toggle.
- Distinguish similarly named menu siblings.
- Enable the tree widget for just some content types.
- Improve the node form on a large-menu site.
- Reduce mis-filed pages.
- Speed up menu placement for editors.
- Make a five-level menu manageable.
- Avoid scanning a long indented dropdown.
- Set a menu link's position and weight visually rather than by number.
- Support a council or university site's large menus.
- Reduce training on menu placement.
- Keep menu link storage unchanged.
- Show only menus that are available to the content type.
- List only menu links the editor is allowed to see.
- Reuse the tree-building service (`menu_tree.items`) in custom code.
- Render the menu-tree SDC component elsewhere.
- Restore the core widget by unchecking the box or uninstalling.
- Integrate with the menu_ui async widget when present.
