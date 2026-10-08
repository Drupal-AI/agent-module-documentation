<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Role Hints (field_role_hints) — agent index

**Role-specific field help text on entity forms, resolved by the editor's roles with configurable priority + append/replace.**

- **Version:** 1.0.1 (dir 1.0.x)  •  **Core:** ^10.3 || ^11 || ^12  •  **Requires:** node, user  •  **Configure:** `field_role_hints.settings` (`/admin/config/content/field-role-hints`)
- **Hooks:** `hook_form_alter` applies resolved hint to the field's `#description`; `hook_form_field_config_edit_form_alter` adds the per-field "Field role hints" UI (`src/Hook/FieldRoleHintsHooks.php`). Service `FieldRoleHintsManager` (resolve + priority).
- **Config:** `mode` (append|replace), `enabled_entity_types` (default `[node]`), `role_priority`. Per-field third-party settings: `enabled`, `mode`, `role_hints[]`.
- **Route:** settings form gated by `administer site configuration`.
- **Security:** Editorial help-text only — no access, validation, or data behaviour change; hints render as form descriptions. No custom permissions or public endpoints.

See [configure/hints.md](configure/hints.md)
