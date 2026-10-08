<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins & Drush commands

## Queue worker — `ContributionRecordImportQueueWorker`

`src/Plugin/QueueWorker/ContributionRecordImportQueueWorker.php`, id
**`contribution_records_import_queue_worker`**. Run with
`drush queue:run contribution_records_import_queue_worker`.

`processItem($data)` validates the item (`validateItem()`: a re-sync needs only `url`+`sync`;
a fresh import needs `url`, `title`, `credits`), resolves a `SourceLink` via `class_resolver`, and:
- `sync` + existing record → `SourceLink::syncContribRecord($entity, TRUE, $hard_reset)`.
- not `sync`, no existing record → `SourceLink::createContribRecordFromRawData($data)`.
- otherwise logs "already imported" / "not in the system yet".

Items are enqueued from the import controller, the Drush sync command, and
`hook_entity_delete` (when a user is deleted, affected records are queued for a `sync` re-fetch
so the deleted user's orphan paragraph is cleaned up).

## Entity-reference selection — `NodeUserOrganizationSelection`

`src/Plugin/EntityReferenceSelection/NodeUserOrganizationSelection.php`, id
**`default:node_user_organization`** (extends core `NodeSelection`). When a `filter.user` setting
is passed, `buildEntityQuery()` restricts organization `node` results to the organizations
referenced by that user's `field_user_organizations`. Applied in `hook_form_alter` /
`_contribution_records_filter_user_organizations_autocomplete()` so a contributor can only
attribute to organizations they belong to (and the field is hidden when they belong to none).

## Drush commands — `DrushCommands`

`src/Drush/Commands/DrushCommands.php` (autowired: `entity_type.manager`, `entity.memory_cache`,
`queue`):
- **`contribution_records:sync-contribution-records`** — options `--nids` (comma-separated D7
  issue node IDs), `--hard-reset` (0/1), `--base-url` (default `https://www.drupal.org`). Queues
  a `sync` item per node ID for the import queue worker.
- **`contribution_records:check-import-status`** — options `--types` (default
  `DrupalOrgIssue::ALLOWED_NODE_TYPES` = `project_issue`, `sa`), `--base-url`. Reads the legacy
  D7 site through the `migrate` database connection (`Database::getConnection('default','migrate')`)
  in batches of 50 and reports which D7 issue IDs have no matching `contribution_record`
  (matched by `field_source_link`).

## Node/Paragraph render & theme (`.module`)

`hook_theme` registers `node__contribution_record__full` and `paragraph__contributor__full`
(templates in `templates/`). `hook_preprocess_node` embeds the `QuickCreditsForm`, the current
user's own contributor paragraph edit form, source metadata, and (for non-maintainers) the
`contribution_records/issue_activity` JS library. `hook_preprocess_field` rewrites the
`field_source_link` display to `Issue #N` / `MR #N`. `hook_views_pre_build` makes the
`contribution_records` view include NULL `field_is_sa` values when that filter is false.
