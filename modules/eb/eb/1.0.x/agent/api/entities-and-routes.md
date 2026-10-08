<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eb — entities, routes & permission model

## Entities
- **`eb_definition`** — config entity (`Entity\EbDefinition`, `config_prefix: definition`). The reusable definition: `label`, `description`, `uid` (owner), `project`, `dependencies_data`, the five `*_definitions` sequences, `application_status` (draft/applied/outdated; also review states), `applied_date`. `admin_permission: administer entity builder`. Access handler `EbDefinitionAccessControlHandler`. Forms: `apply` (`EbDefinitionApplyForm`), `delete`. `FORMAT_VERSION = '1.0'`.
- **`eb_log`** — content entity, session-level audit record (`Entity\EbLog`; list builder `EbLogListBuilder`; manager `eb.eb_log_manager`).
- **`eb_rollback`** + **`eb_rollback_operation`** — content entities storing undo data (list builder `EbRollbackListBuilder`; manager `eb.rollback_manager`). Stored in DB tables, not exported with config. Cascade-deleted with their definition via `EbHooks`.

## Routes (`eb.routing.yml`, all under `/admin/config/development/eb`)
| Route | Path | Access requirement |
|---|---|---|
| `eb.settings` | `/settings` | perm `administer entity builder` |
| `eb.import` | `/import` | perm `import entity architecture` |
| `eb.import.confirm` | `/import/confirm` | perm `apply entity definitions` OR `import entity architecture` |
| `eb.export` | `/export` | perm `export entity architecture` |
| `eb.discovery_info` | `/discovery` | perm `administer entity builder` |
| `entity.eb_definition.collection` | `/definitions` | perm `administer entity builder` OR `view own entity definitions` |
| `entity.eb_definition.canonical` | `/definitions/{id}` | `_entity_access: eb_definition.view` |
| `entity.eb_definition.apply_form` | `/definitions/{id}/apply` | `_entity_access: eb_definition.apply` |
| `entity.eb_definition.delete_form` | `/definitions/{id}/delete` | `_entity_access: eb_definition.delete` |
| `entity.eb_definition.export` | `/definitions/{id}/export` | `_entity_access: eb_definition.export` |
| `entity.eb_log.collection` / `.canonical`, `eb.eb_log.show` | `/log...` | perm `administer entity builder` |
| `entity.eb_rollback.collection` / `.canonical` / `.delete_form` | `/rollback...` | perm `administer entity builder` |
| `eb.rollback_execute` | `/rollback/{rollback_id}/execute` | perm `administer entity builder` (form `EbRollbackForm`, CSRF-protected form token) |

Controllers: `EbDefinitionController`, `EbDefinitionExportController`, `EbLogController`, `EbRollbackController`, `EbDiscoveryController`. Local tasks in `eb.links.task.yml`; menu link `eb.admin` → `eb.import`.

## Permission model (`eb.permissions.yml`) — three tiers
- **Tier 3 (admin, `restrict access: true`):** `administer entity builder` — full access, bypasses ownership in the access handler.
- **Tier 2 (privileged, `restrict access: true`):** `apply entity definitions`, `import entity architecture` (import **and** apply), `export entity architecture`, `rollback entity operations` — high-impact, mutate site structure.
- **Tier 1 (ownership-based, not restricted):** `create entity definitions`, `edit own entity definitions`, `view own entity definitions`, `delete own entity definitions`, `preview entity definitions`, `export entity definitions`, `request definition review`.

## Access-handler logic (`EbDefinitionAccessControlHandler`)
Admin bypass first. Otherwise per operation: `view`/`update`/`delete` require the matching *own* permission **and** ownership (`update` also blocked when status is pending_review/in_review/approved). `export` allowed by Tier 2 `export entity architecture`, or Tier 1 `export entity definitions` when owner. `apply` allowed by `apply entity definitions` or `import entity architecture` (not ownership-based). `preview` allowed by `preview entity definitions` (not ownership-based). `create` requires `administer entity builder` OR `create entity definitions`. Results carry `cachePerUser`/`cachePerPermissions` + entity cache dependency.

## Forms (`src/Form/`)
`EbSettingsForm` (settings), `EbImportForm` + `EbImportConfirmForm` (upload YAML → validate/preview → tempstore → confirm; core file validators enforce `.yml/.yaml` and max size), `EbExportForm`, `EbDefinitionApplyForm`, `EbRollbackForm`.
