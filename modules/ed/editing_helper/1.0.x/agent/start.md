<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editing Helper (editing_helper) — agent index

**Injects configurable, toggleable help text onto fields, blocks and views to guide editors during content entry.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Config route:** `/admin/config/content/editing_helper/config` (`HelpDescriptionConfigForm`, `_permission: 'administer editing helper permissions'`)
- **Permissions:** `administer editing helper permissions` (configure), `access to editing helper` (see help)
- **Config:** `editing_helper.help_config` (block_title, block_inline_text, block_reusable_text, view_field_text, view_node_text, view_taxonomy_text)
- **Per-field help:** third-party setting `editing_helper_description` via `hook_form_field_config_edit_form_alter`
- **Views:** `EditingHelperDisplayExtender` display extender; render via `hook_preprocess_block()` + theme `help_content`

**Security:** Config route permission-gated; no anonymous or mutating endpoints. Help text is admin-authored (trusted input) and shown only to users with `access to editing helper`. HTML in help text is an admin-role responsibility. No findings. See [configure/help.md](configure/help.md).
