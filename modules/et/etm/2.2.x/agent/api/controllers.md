<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Controllers, shared base API, and the snapshot/undo model

## Controller services

All five controllers extend `EtmControllerBase` and take the same nine args (see
`enhanced_taxonomy_manager.services.yml`): `entity_type.manager`, `cache_tags.invalidator`,
`csrf_token`, `logger.factory`, `database`, `datetime.time`, `current_user`, `date.formatter`,
`entity_field.manager`.

- `DashboardController` (`dashboard`) — the ETM dashboard page.
- `TreeController` — `vocabularyOverview` (renders `#theme: taxonomy_tree_view`, attaches the
  `enhanced_taxonomy_manager/taxonomy_manager` library and `drupalSettings.taxonomy_manager`
  including the `token` = `csrfToken->get('taxonomy_manager')`), plus lazy tree loading
  (`getTermChildren`, `loadMoreTerms`, `loadTermTreePaginated`), `searchTerms`, `filterTerms`,
  `vocabStats`, `findDuplicates`, `healthCheck`, `recentlyModified`, `fixOrphans`.
- `TermController` — CRUD/position: `updateTermPosition`, `saveOrderBatch` (batched drag-and-drop
  commit), `renameTerm`, `createTermJson`, `updateTermJson`, `cloneTerm`/`cloneChildTerms`,
  `findAndReplacePreview`/`findAndReplaceExecute`, `getTermData`, `getTermUsage`/`getUsageCounts`
  (counts entity-reference usage across all `entity_reference` fields whose `target_type` is
  `taxonomy_term`), `getTermDescription`.
- `SnapshotController` — `saveSnapshot`, `getSnapshots`, `deleteSnapshot`, `deleteAllSnapshots`,
  `undoRevision`, `getRevisions`, `getUndoCount`, `buildRevisionDescription`.
- `ExportImportController` — `exportCsv`, `exportList`, `bulkImport`, `bulkOperation`,
  `neutralizeCsvFormula`.

## `EtmControllerBase` shared API (the reusable logic)

- `validateCsrfToken(Request)` — reads the `X-CSRF-Token` header and validates it against the
  `taxonomy_manager` token; throws `AccessDeniedHttpException` on mismatch. Called by every
  state-changing AJAX handler.
- `defaultTranslation(TermInterface)` — returns `getUntranslated()`; the tree always shows
  default-language names, so rename/edit write the default translation, not the request-language one.
- `fallbackFormatId()` — reads `filter.settings:fallback_format`; term descriptions written through
  this module are always stored with the fallback (plain_text) format.
- `loadParentMap($vid)` / `buildAncestorPaths($vid, $tids)` — batch ancestor lookups (two queries
  for a whole result set) used by search, filter and recently-modified.
- `moveCreatesCycle($vid, $tid, $newParent, $pending)` — refuses reparents that would make a term
  its own ancestor (a batch is validated as the whole hierarchy it will become).
- `captureTreeState($vid)` — full tree snapshot array (name, weight, status, description,
  multi-parent list, depth), including terms `loadTree()` cannot reach (orphans/cycles).
- `captureAutoSnapshot($vid)` — inserts an `is_auto = 1` snapshot; keeps at most 15 per vocabulary.
- `restoreFromSnapshot($vid, $data)` — two-pass restore (create/update, then set parents via a
  TID map for recreated terms), then deletes terms not present in the snapshot; used by undo and
  the batch `RestoreSnapshotForm`.
- `recordRevision(...)` — writes an `enhanced_taxonomy_revisions` row; prunes to
  `max_undo_history` (default 200). Failures are logged, not fatal.
- `adjustSiblingWeights`, `ensureParentTermsPublished`, `unpublishChildTerms` (cascading
  publish/unpublish), `clearUndoHistory`, `getUndoableCount`.

## Snapshot / undo / revisions model

Two tables (`hook_schema` in `enhanced_taxonomy_manager.install`):

- `enhanced_taxonomy_snapshots` — `id, vocabulary_id, snapshot_name, snapshot_data` (JSON, big
  text, encoded via `SnapshotCodec`), `created, created_by, is_auto`. `is_auto = 0` = manual
  (shown in the snapshot list); `is_auto = 1` = the undo stack (captured before each mutation).
- `enhanced_taxonomy_revisions` — `id, vocabulary_id, operation` (move/edit/add/delete/clone/
  rename/merge), `term_id, term_name, old_data, new_data` (JSON), `undone, created, uid,
  snapshot_id` (FK to the auto-snapshot capturing pre-op state).

Undo pops the newest auto-snapshot, restores from it, and deletes it. A **save** (`saveOrderBatch`)
is the commit point: it clears the undo stack and writes a `Post-save` manual snapshot. Both tables
are purged for a vocabulary on `hook_taxonomy_vocabulary_delete`.

## Merge (`Form\MergeTermsForm`)

Two-step confirm form (select target → preview impact → confirm). `executeMerge` runs in a DB
transaction: reparents the source's children under the target, reassigns every
`taxonomy_term`-referencing entity-reference field from source→target across all translations and
pending (non-default) revisions (`reassignTermReferences` / `rewriteReferenceField` /
`rewritePendingRevisions`, chunked to avoid OOM, de-duplicating collapsed references), records a
`merge` revision, deletes the source term, then retires the vocabulary's undo history (a merge
rewrites cross-site references that the tree-only undo cannot reconstruct). Validation blocks
merging a term into itself or into one of its own descendants.

## Notes for agents

- Every AJAX mutation returns `{status: 'success'|'error', …}` JSON; the client stages drag-and-drop
  locally and commits via `save_order`.
- Term-name and description length are capped (255 / 10000 chars) in the create/update/rename paths.
- All DB access uses the query builder with placeholders / `escapeLike`; entity queries use
  `accessCheck(FALSE)` because route-level `_etm_access` already gates the vocabulary.
