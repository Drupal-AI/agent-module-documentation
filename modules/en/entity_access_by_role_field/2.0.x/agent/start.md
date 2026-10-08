<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Access by Role Field — agent index

Adds a field type, **`entity_access_by_role_field`** ("Entity Access by Role"), that grants or
denies access to each individual fielded entity for selected roles, enforced by
`hook_entity_access()`. No admin settings page (`configure: null`) — you configure it by adding
the field to a bundle and setting per-instance options, plus one bypass permission.

- **Add the field, its per-instance settings (`operations`, `empty_roles_access_fallback`),
  widget/formatter, and how the access decision is computed** →
  [configure/field.md](configure/field.md)
- **The `bypass entity_access_by_role_field permissions` permission** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: field type id `entity_access_by_role_field`; each value = `role_id` + `access`
(`allowed`|`forbidden`); instance settings `operations` (subset of `view`/`update`/`delete`) and
`empty_roles_access_fallback` (`neutral`|`allowed`|`forbidden`); default widget
`default_entity_access_by_role_field_widget`, formatters
`default_entity_access_by_role_field_formatter` and `debug_entity_access_by_role_field_formatter`.
IMPORTANT: it does NOT alter Views/listing queries (no `hook_query_TAG_alter`), so listings are
not filtered.
