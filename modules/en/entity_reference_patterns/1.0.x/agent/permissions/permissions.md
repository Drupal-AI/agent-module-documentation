<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `entity_reference_patterns.permissions.yml`. Each pattern operation has its own
permission; `administer` and `delete` are flagged `restrict access: true` (Drupal shows the "gives
elevated access" warning). `administer entity reference pattern` is also the config entity's
`admin_permission`.

| Permission | Restricted | Gates |
|---|---|---|
| `administer entity reference pattern` | yes | The patterns list / admin page (route `entity.entity_reference_pattern.collection`). |
| `add entity reference pattern` | no | Create form (`entity.entity_reference_pattern.add_form`) and `create` access. |
| `edit entity reference pattern` | no | Edit form (`entity.entity_reference_pattern.edit`) and `update` access. |
| `duplicate entity reference pattern` | no | Duplicate form (`entity.entity_reference_pattern.duplicate`) and `duplicate` access. |
| `delete entity reference pattern` | yes | Delete form (`entity.entity_reference_pattern.delete`) and `delete` access. |

Route access comes from each route's `_permission` requirement; the entity operations (`create`,
`update`, `duplicate`, `delete`) are mapped to the same permissions by
`Entity\AccessControlHandler\AccessControlHandler`, which the list builder consults to decide whether
to show the Edit / Duplicate / Delete row operations. No permission is required to *see* pattern-styled
autocomplete labels — that is applied to everyone once a pattern is enabled.
