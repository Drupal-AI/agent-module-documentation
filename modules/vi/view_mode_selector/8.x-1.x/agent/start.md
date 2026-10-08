<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Mode Selector (view_mode_selector) — agent index

**Provides a `view_mode_selector` field type; when an entity is rendered with the `view_mode_selector` placeholder view mode, the module swaps in the view mode the editor stored on the entity.**

- **Version:** 8.x-1.x (info.yml `8.x-1.2`)
- **Core:** ^10 || ^11
- **Package:** Fields
- **Dependencies:** none declared (uses core Field, `text` formatter, `file` for icons).
- **Field type:** `view_mode_selector` (varchar 255, indexed; default widget `view_mode_selector_radios`, default formatter `view_mode_selector`).
- **Widgets:** `view_mode_selector_select` (Select list), `view_mode_selector_radios` (Radio buttons), `view_mode_selector_icons` (Icons, uses managed-file uploads + `view_mode_selector/widget_styles` library).
- **Key hooks (`.module`):** `hook_entity_view_mode_alter` (applies stored mode, else `default`), `hook_entity_view_mode_info_alter` (auto-creates per-entity-type `view_mode_selector` placeholder view mode), `hook_form_entity_view_display_edit_form_alter` (disables the placeholder display's field settings with a notice).
- **Config:** field settings store per-view-mode `enable`/`hide_title`/`icon.fids`; icons uploaded to `public://view-mode-selector/<entity_type>`.
- **Permissions:** none defined; access is governed by normal field and entity-display permissions.
- **Security:** no routes, controllers, or external calls; no `_access:TRUE`; icon uploads use core managed_file; entityQuery in the info-alter uses `accessCheck(FALSE)` only to enumerate field_config for view-mode provisioning (config metadata, not user content). No security findings.

See [configure/field.md](configure/field.md).
