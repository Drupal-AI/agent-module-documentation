# Permissions

Generated dynamically by `Drupal\paragraphs_type_permissions\ParagraphsTypePermissions`
(registered as `permission_callbacks` in `paragraphs_type_permissions.permissions.yml`).
Assign them on **People → Permissions** — no config form or schema.

## Global
| Permission | Gates |
|---|---|
| `bypass paragraphs type content access` | Administer content for **all** paragraph types (skips the per-type checks below). |

## Per paragraph type (one set per type `<type_id>`)
Produced by `buildPermissions(ParagraphsType $type)` for every type:

| Permission | Gates |
|---|---|
| `view paragraph content <type_id>` | View content of that paragraph type. |
| `create paragraph content <type_id>` | Create content of that paragraph type. |
| `update paragraph content <type_id>` | Edit content of that paragraph type. |
| `delete paragraph content <type_id>` | Delete content of that paragraph type. |

New permissions appear automatically whenever a Paragraphs type is added. Enforcement hooks
into the paragraph access system (`hook_entity_access`/`hook_entity_create_access` in
`paragraphs_type_permissions.module`), replacing the main module's coarser check when this
submodule is enabled.
