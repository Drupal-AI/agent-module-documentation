<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Form Overrides (node_form_overrides) — agent index

**Overrides node add/edit/delete form page titles and submit-button labels, globally or per content type, with optional token support.**

- **Version:** 1.1.x (release 1.1.0) · Core: ^8 || ^9 || ^10 || ^11 · Dependency: node (Token optional)
- **Routes:** `node_form_overrides.settings` → `/admin/config/content/node-form-overrides`, `node_form_overrides.per_type` → `.../per-type` (both permission `administer content types`)
- **Config:** `node_form_overrides.settings` (insert/update button + title, delete_form_title/description); per-type values stored as node_type third-party settings under `node_form_overrides`
- **Hooks:** `hook_form_node_type_form_alter` (Label Overrides tab), `hook_form_node_form_alter` (button/title swap), `hook_form_node_confirm_form_alter` (delete form), entity builder whitelists saved keys
- **Helper:** `_node_form_overrides_get_setting()` (per-type value, else global)

See [configure/overrides.md](configure/overrides.md)

**Security:** All config gated by `administer content types` (trusted admin). Token replacement uses node/group context; the only markup output (delete-form description) is admin-entered config. No anonymous or untrusted-input paths, no mutating endpoints. No security findings.
