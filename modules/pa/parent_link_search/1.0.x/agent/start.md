<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Parent Link Search (parent_link_search) — agent index

**Injects a search + Highlight control into the menu-link "Parent link" select so large menus are searchable.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Mechanism:** `hook_form_alter` adds a textfield + button to `$form['menu']['link']['menu_parent']['#description']` and attaches library `parent_link_search/parent_link_search`
- **No routes, no permissions, no config, no schema.**

**Security:** purely a client-side admin-UX enhancement on menu forms; no routes, endpoints, storage or server-side input handling. No security findings.
