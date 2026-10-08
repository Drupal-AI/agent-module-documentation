<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Menus lets you select, per content type and language, which menus are available for placing nodes.

---

Node Menus refines core's node-to-menu placement for multilingual sites. On a translatable content type you
enable "Language menus" and, for each language, pick which menus a node link may go into and a default parent
item. On the node edit form the menu parent selector then only offers links from the menus configured for the
node's language — so a site with one menu per language no longer shows one giant combined parent dropdown.

It alters the node type form (to add the per-language settings) and the node form (to swap in language-scoped
parent selectors), storing its configuration in the node type's third-party settings. When the language
selector is visible on the node form, the parent options switch live as the author changes the language, and
an alter hook (`hook_node_menus_available_menus_alter`) lets other modules adjust the available menus. It
requires core `content_translation`, `menu_ui`, `node`, and `language`; it does not add permissions, routes,
or change access — menu placement still runs through core menu_ui's own gating.

---

- Select which menus are available for placing nodes.
- Scope available menus per content type.
- Scope available menus per language.
- Set a default parent menu item per language.
- Shorten huge per-language menu parent dropdowns.
- Build a clean editing experience on multilingual sites.
- Create one menu per language and expose only the right one.
- Switch parent options live when the node language changes.
- Keep the default selector for languages without language menus.
- Reuse an existing menu link's position as the form default.
- Enable language menus on a translatable content type only.
- Require the language selector to be visible on the node form.
- Validate that the default parent is within the selected menus.
- Let other modules alter available menus via a hook.
- Go beyond core's fixed allowed-menus-per-type behavior.
- Avoid clumsy combined menu parent dropdowns.
- Configure available menus without writing code.
- Place node links into language-appropriate menus.
- Store configuration in node type third-party settings.
- Keep menu placement subject to core menu_ui access.
- Support Drupal 11.2+ and Drupal 12.
- Pair with normal menu blocks to render per-language menus.
- Help editors pick the correct menu parent per translation.
- Reduce editor error choosing menu placement.
