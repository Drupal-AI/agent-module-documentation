<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu tree replaces the flat "Parent link" `<select>` wherever core shows it — node add/edit forms, the Views UI menu-link display, and the menu link content form — with a browsable, filterable, drag-and-drop menu tree, so an editor placing an item in a deep menu can see the structure and position the link precisely instead of scanning a flat list of indented dashes.

---

Core renders the menu parent selector as a `<select>` whose options are the whole menu flattened, hierarchy shown by leading hyphens; on a site with a hundred links across five levels the control becomes unusable. In 3.x the module stops being a node-form-only widget: it **decorates the core `menu.parent_form_selector` service** (`MenuTreeParentFormSelector`), so every form that calls `parentSelectElement()` can get the tree. On node forms the tree is opt-in **per content type** — a `use_tree_widget` third-party setting on the node type, toggled by a "Use tree widget for parent link" checkbox the module adds to the node type form's Menu settings; on the Views UI menu display and the menu-link content form the tree is used unconditionally. When active, the decorator swaps the element to `#type => 'menu_tree'` (a `FormElement` registered by `src/Element/MenuTree.php`) whose process callback builds, for each relevant menu, a nested array from `MenuTreeItems::getLinks()` and renders the `menu_tree:menu-tree` Single Directory Component (Twig + JS + CSS under `components/menu-tree/`). The component draws a nested `<details>` tree of selectable buttons, a search/filter box, an expand/collapse-all toggle, and HTML5 drag-and-drop (with auto-scroll and hover-to-expand); the JS writes the chosen parent into a hidden `menu_parent` input and records drop position in hidden `prev_sibling`/`next_sibling` inputs. On submit, `FormSubmitHandler` (one handler each for node, Views, and menu-link forms) inserts the link at the chosen spot and rewrites the weights of the whole branch via the menu link manager. The tree is built with core's `checkAccess` and `generateIndexAndSort` manipulators, so only links the user may see are listed, and menu link storage is otherwise unchanged. 3.x also adds a per-menu **weight** (a `system.menu.*` third-party setting, set via a Weight field on the menu edit form) that orders the menus within the widget. Now **depends on `menu_ui`**; core requirement raised to `>= 11.4`; no routes, permissions, or drush of its own; uninstall removes its node-type and menu third-party settings and restores the core control.

---

- Pick a menu parent from a browsable tree.
- Drag and drop a link to reorder it within a branch.
- Place a page precisely inside a deep menu structure.
- See menu hierarchy while choosing a parent.
- Filter/search a long menu to jump to the right item.
- Collapse or expand all branches with one toggle.
- Distinguish similarly named menu siblings.
- Enable the tree widget for just some content types.
- Get the same tree on the Views UI menu display and the menu-link content form, not only node forms.
- Improve the parent selector on a large-menu site.
- Reduce mis-filed pages.
- Speed up menu placement for editors.
- Make a five-level menu manageable.
- Avoid scanning a long indented dropdown.
- Set a link's position and weight visually rather than by number.
- Order the menus shown in the widget by a per-menu weight.
- Support a council or university site's large menus.
- Reduce training on menu placement.
- Keep menu link storage unchanged.
- Show only menus available to the content type on node forms.
- List only menu links the editor is allowed to see.
- Reuse the tree-building service (`MenuTreeItems`) in custom code.
- Render the menu-tree SDC component elsewhere.
- Restore the core widget by unchecking the box (node types) or uninstalling.
- Auto-scroll and auto-expand branches while dragging in a tall tree.
