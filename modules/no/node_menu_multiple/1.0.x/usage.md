<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node menus multilingual allows selecting the menus that are available for nodes, and placing a node in several menus at once per language.

---

The module alters the node form (`node_menu_multiple_form_node_form_alter`) to add a repeatable "Menu Form Nodes" section under the standard menu settings, letting an editor add multiple menu links for the same node with AJAX add/delete buttons. It alters the node-type form to let an admin enable the feature per content type and pick, per language, which menus are offered — stored as third-party settings under the `node_menus` namespace. On save it creates/updates the corresponding `menu_link_content` entities, honouring the node's current translation language.

It solves the core limitation that a node's built-in menu widget only allows one menu link, and that this link is not naturally language-aware. It works entirely through form alters and hook_ENTITY hooks — there are no custom routes or permissions — so access follows core node-edit and menu-administration permissions. Typical setup: enable content translation and multiple languages, turn on "language menus" for a content type, choose available menus per language, then add multiple links when editing a node.

---
- Place a single node in more than one menu
- Add multiple menu links to a node at once
- Configure which menus are available per content type
- Offer different menus per language
- Create language-specific menu links for translated nodes
- Delete an individual node menu link via AJAX
- Add another menu link row without reloading
- Enable the feature only for translatable content types
- Keep menu links in sync with node translations
- Set parent/weight for each node menu link
- Restrict a content type to a curated menu list
- Build language-aware navigation from node links
- Manage main-menu and footer-menu links for one node
- Provide editors a clearer multi-menu UI
- Fall back to the content type's default menus when unset
