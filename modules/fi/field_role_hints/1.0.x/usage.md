<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Role Hints lets you attach per-role help text to individual fields, so different editor roles see guidance tailored to them on entity edit forms.
---
Configuration lives in two places. Globally at `/admin/config/content/field-role-hints` (permission `administer site configuration`) you choose which entity types are enabled (default: node), the default mode (`append` or `replace`), and a role priority order. Per field, the field's edit form gains a "Field role hints" section where you enable hints, pick append/replace, and enter help text for each role. At render time a `hook_form_alter` finds the field widget element, resolves the hint for the current user (the highest-priority matching role wins), and either appends it to the existing `#description` (with a `<br>`) or replaces it.

The resolution/priority logic lives in `FieldRoleHintsManager`, and the form integration walks the widget tree to place the description on the right input (handling multi-value and compound widgets). It is an editorial-guidance feature only: hints are stored as field third-party settings and shown as form descriptions; nothing about access or validation changes.
---
- Show different field help text to Authors vs Editors
- Add a role-specific hint to a field on the node form
- Append role guidance to a field's existing description
- Replace a field description entirely for a given role
- Set a global default append/replace mode
- Define which role's hint wins via a priority order
- Enable role hints only for the node entity type
- Enable hints for additional entity types
- Guide junior editors with extra field instructions
- Give admins terse hints and novices detailed ones
- Preview the role priority when configuring a field
- Store hints as field third-party settings (config-exportable)
- Target compound/multi-value widgets correctly
- Provide compliance notes per role on sensitive fields
- Reduce training overhead with inline role guidance
- Configure global defaults at the settings page
- Show the highest-priority matching role's hint to multi-role users
