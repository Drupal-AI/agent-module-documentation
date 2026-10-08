<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# field_role_hints — configuring hints

## Global settings — `/admin/config/content/field-role-hints`
Permission `administer site configuration`. Config `field_role_hints.settings`:
- `mode` — default `append` or `replace` when a field doesn't override it.
- `enabled_entity_types` — which entity types get hints (default `[node]`).
- `role_priority` — ordered role list; when a user matches several roles, the highest-priority role's hint is used.

## Per-field settings
On a field's *edit* form a **Field role hints** section (added by `formFieldConfigEditFormAlter`) provides:
- `enabled` — turn hints on for this field.
- `mode` — `''` (use global default), `append`, or `replace`.
- `role_hints` — a textarea per role for that role's help text.
A priority preview explains which hint a multi-role user will see. Values save as field `third_party_settings.field_role_hints` via an entity builder (exportable config).

## Runtime
`formAlter()` runs on entity forms whose type is enabled: for each `FieldConfig` field with a resolved hint (`FieldRoleHintsManager::resolveHint()`), it locates the correct widget element (`findDescriptionTargetPath()` walks the render tree, preferring the real input in compound/multi-value widgets) and writes `#description` — appending after a `<br>` or replacing.
