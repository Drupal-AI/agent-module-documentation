<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and field access

Defined in `user_created_by_field.permissions.yml`:

- `view user created by field` — "View User Created By field": allows viewing the field.
- `edit user created by field` — "Edit User Created By field": allows changing the field value.

Grant them at *People → Permissions* (`/admin/people/permissions`).

## How they gate the field

`hook_entity_field_access($operation, $field_definition, $account, $items)` in
`user_created_by_field.module` acts only when the field name is `field_user_created_by_field`:

- `view` operation → `AccessResult::allowed()` if the account has `view user created by field`,
  otherwise `AccessResult::forbidden()`.
- `edit` operation → `AccessResult::allowed()` if the account has `edit user created by field`,
  otherwise `AccessResult::forbidden()`.
- Any other operation / other fields → `AccessResult::neutral()`.

Because the hook returns **forbidden** (not neutral) when the permission is missing, a user without
the view permission does not see the field on the profile or in listings, and one without the edit
permission cannot change it on the user edit form. uid 1 and any role with the permission pass, since
`hasPermission()` returns TRUE for them. There is no separate "administer" permission; access is
purely per-operation via these two.
