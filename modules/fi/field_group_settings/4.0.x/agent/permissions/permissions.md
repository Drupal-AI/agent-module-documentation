<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Settings — permissions

One permission, defined in `field_group_settings.permissions.yml`:

| Permission | `restrict access` | Effect |
|---|---|---|
| `bypass field_group_settings field visibility` | (not set → FALSE) | A holder always sees every **Settings** field group on any form, ignoring each group's `visible_for_roles` list. In each group's formatter settings form, roles with this permission are shown pre-checked and disabled ("managed by permissions"). |

## How it is enforced

- `Settings::isVisible()` (`src/Plugin/field_group/FieldGroupFormatter/Settings.php`) returns TRUE
  immediately if the current user has this permission; otherwise it checks the group's
  `visible_for_roles` list against the user's roles.
- The boolean becomes the field group's render `#access`, so without visibility the grouped fields
  are simply not rendered in the form.

## Trust / scope note (not a security finding)

This permission is not marked `restrict access: true`, but its power is limited to **form-display
convenience**: it only reveals a settings panel of fields on edit forms. It is not an entity/field
**access-control** mechanism — the visibility gate hides fields on the form, but does not by itself
protect field *data* (a role that can otherwise edit those fields through another form mode, the
API, or REST is unaffected). Treat "Roles that can view" as UI decluttering / soft-hiding, not as a
security boundary; enforce real field-level access with core field access or a dedicated module.
