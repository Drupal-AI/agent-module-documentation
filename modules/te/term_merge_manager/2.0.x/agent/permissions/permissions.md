# Permissions

Defined in `term_merge_manager.permissions.yml`. Two parallel sets (one per rule entity)
plus a message toggle. The `administer …` permissions are `restrict access: true`.

## term_merge_into entity (target-term rules)

| Permission | Gates |
|---|---|
| `add term merge into entities` | create a `term_merge_into` rule |
| `administer term merge into entities` | admin form / entity admin (restricted) |
| `delete term merge into entities` | delete a target rule |
| `edit term merge into entities` | edit a target rule |
| `view published term merge into entities` | view published target rules |
| `view unpublished term merge into entities` | view unpublished target rules |

## term_merge_from entity (source-name rules)

| Permission | Gates |
|---|---|
| `add term merge from entities` | create a `term_merge_from` rule |
| `administer term merge from entities` | admin form / entity admin (restricted) |
| `delete term merge from entities` | delete a source rule |
| `edit term merge from entities` | edit a source rule |
| `view published term merge from entities` | view published source rules |
| `view unpublished term merge from entities` | view unpublished source rules |

## Messaging

| Permission | Gates |
|---|---|
| `view term merged manager messages` | whether the user sees the "we merged X into Y" / cleanup status messages that the presave hook adds when a term is auto-merged |

`administer term merge into entities` / `administer term merge from entities` are the
`admin_permission` of their respective entity types (used as the Field UI base-route gate).
