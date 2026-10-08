<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blank Node Title (blank_node_title) — agent index

**Makes the node title optional and auto-generates a `"<type> - <long date>"` fallback title on presave for selected content types.**

- **Version:** 8.x-1.x (dev checkout; branch 8.x-1.x) · **Core:** ^8 || ^9 || ^10 || ^11 · **Configure:** `blank_node_title.config`
- **Route:** `blank_node_title.config` → `/admin/config/content/blank-node-title` (perm: *administer site configuration*).
- **Hooks:** `blank_node_title_form_node_form_alter` / `_node_edit_form_alter` → `Hook\FormNodeFormAlter` (relax required title); `blank_node_title_node_presave` → `Hook\NodePresave` (fill empty/`-` title).
- **Config:** `blank_node_title.settings` (selected content types).
- **Security:** single admin config route, permission-gated; no anonymous or mutating endpoints. Note: settings form still injects the deprecated `entity.manager` service (may warn on newer core).
