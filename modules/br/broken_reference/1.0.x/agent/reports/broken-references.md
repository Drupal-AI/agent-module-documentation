<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Broken reference — the scan report (source-grounded)

## Install / enable

`drush en broken_reference` (or via UI). Core only — nothing else to install. Grant the
permission **`search broken entity references`** to the roles allowed to run the scan, then visit
**`/admin/config/development/broken_reference`** (also under **Reports → Broken entity references**).

## Route & permission

- Route `broken_entity.form` (`broken_reference.routing.yml`): `path`
  `/admin/config/development/broken_reference`, `_form:
  \Drupal\broken_reference\Form\BrokenReferenceForm`, `_title` "Broken entity references",
  `options._admin_route: TRUE`, `requirements._permission: 'search broken entity references'`.
- Permission `search broken entity references` (`broken_reference.permissions.yml`) has
  `restrict access: true` (marked as a security-sensitive permission in the UI).
- Menu link `broken_entity.form` parents on `system.admin_reports`.
- All interaction is through this one POST form (no GET state-changing routes, no separate
  repair/delete action).

## What the page shows (`Form\BrokenReferenceForm`)

`buildForm()`:
1. `getRows()` reads any previously stored results from the tempstore via
   `store_controller->getBroken()` and builds a `#type => table` grouped by entity type / bundle /
   field. Columns: `#`, Entity type, Bundle, Field, **Source amount** (count of source entities
   with a broken reference in that field), **Target amount** (count of missing target references).
   Header prefix reports `Total @amount of broken references between @types different types`
   (`$totalBroken` / `$totalBrokenTypes`, accumulated in `getRows()`).
2. If there are no stored rows it calls `finder->getBrokenReferenceTypes()` for a **fast estimate**:
   if that is non-zero it shows "At least N different types of broken references found. Build report
   to get full details."; otherwise "No broken entity references were found, good work!".
3. Always renders a **"Build report"** submit button.

All rendered cells are machine names (entity type / bundle / field ids) and integer counts — no
entity labels or user-authored content are placed in the table.

## Building the report (`submitForm` → Batch API)

`submitForm()` clears prior results (`store_controller->clearBroken()`), then for every entity
type returned by `finder->getReferenceFields()` queues one batch operation
`\Drupal\broken_reference\Batch\BrokenReferenceBatch::batchRun` with `[$entityType, $config]`.
`batch_set()` runs them; `batchFinished()` prints success/error messages.

`BrokenReferenceBatch::batchRun()`:
- First pass: `finder->getQueryResults($entityType, $config)` returns the candidate entity IDs
  (references that exist but whose target row is absent), stored in `$context['sandbox']`.
- Each step splices **30** ids (`$limit = 30`), `loadMultiple()`s them, and for each field in the
  bundle iterates `$entity->get($field)` items: if `$field->target_id && !$field->entity`
  (target id set but the referenced entity fails to load) it records the broken item into
  `store_controller->addBroken()` as `[$entityType][$bundle][$field][$sourceId][] = $targetId`.
- `$context['finished']` advances by progress/max until done.

## Field discovery (`Utility\BrokenReferenceFinder`)

- `FIELD_TYPES = ['entity_reference', 'entity_reference_revisions']`.
- `getReferenceFieldsWithType($fieldType)` walks `entityFieldManager->getFieldMapByFieldType()`.
  For each field it skips: the bundle key field; the `comment`/`entity_id` field and
  `paragraphs_library_item`/`paragraphs` (noted core/contrib edge cases); computed fields; and, for
  `entity_reference_revisions`, `BaseFieldDefinition`s (workaround for ERR issue 3439339). It keeps
  only fields whose `target_type` entity implements `FieldableEntityInterface`, recording the
  target type's **uuid** key.
- `getReferenceFields()` merges both field-type maps into one per-entity-type structure
  (`bundle_key` + `bundles[bundle][field] = targetUuidKey`).
- `getQueryResults($entityType, $config, $limit=FALSE)` builds an **entity query** per bundle/field:
  `->accessCheck(FALSE)`, optional `condition(bundleKey, bundle)`, `condition($field, 0, '>')` and
  `notExists("{$field}.entity.{$targetIdKey}")`; with `$limit` it takes `range(0,1)` (the quick
  estimate). Uses the entity query builder — no raw/hand-built SQL.
- `getBrokenReferenceTypes()` sums a limited query per entity type for the cheap "at least N types"
  banner.

## Results storage (`Controller\BrokenReferenceStoreController`)

Backed by the **private tempstore** factory (`@tempstore.private`), collection `broken_reference`,
single key `broken`. `getBroken()` reads (or `[]`), `addBroken()` merges new results, `clearBroken()`
deletes the key. Because it is a *private* tempstore, results are per-user and transient; a
different admin will not see another admin's last report until they build their own.

## Operating notes

- The initial page estimate is deliberately shallow (`range(0,1)` per field) and may under-report;
  the module itself advises running "Build report" for full detail.
- The scan is **read-only** — it never modifies or deletes content. Remediation (adding delete
  hooks, cleaning data) is left to the operator.
- Large sites: `getReferenceFields()` and the batch load every referencing entity in chunks of 30;
  scan time scales with content volume. Runs as a Batch so it will not time out a single request.
- `accessCheck(FALSE)` on the finder queries is intentional so the audit sees all data regardless
  of the viewer; the route itself is gated by the restricted admin permission.
