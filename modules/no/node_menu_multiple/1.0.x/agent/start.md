<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node menus multilingual (node_menu_multiple) — agent index

**Adds multiple, per-language menu links to a node and configures available menus per content type.**

- **Version:** 1.0.x (branch 1.x / release branch 1.0.x; info.yml carries no packaged version)
- **Core:** ^10 || ^11 || ^12
- **Dependencies:** content_translation, menu_ui, node, language
- **Mechanism:** `hook_form_node_form_alter` + `hook_form_node_type_form_alter`; per-content-type third-party settings under `node_menus`; creates/updates `menu_link_content` entities on submit.
- **Routes/permissions:** none of its own — relies on core node-edit and menu-admin permissions.

**Security:** No custom routes, permissions or endpoints; operates through form alters and entity saves under core access checks. Entity queries use `->accessCheck()`. No security findings.
