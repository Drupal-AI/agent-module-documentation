<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Delete submissions

## Where
Per-webform tab, not a global settings page. There is NO site-wide config form and the module's
`.info.yml` declares no `configure` route.

- Route: `entity.webform_submissions_delete.results_bulk_delete`
- Path: `/admin/structure/webform/manage/{webform}/results/bulk-delete`
- Local task: "Bulk Delete", parented under `entity.webform.results` (the Results tab), weight 21.
- Form: `WebformResultsBulkDeleteForm` (extends Webform's `WebformResultsClearForm`).

## Access
Route requirements (both must pass):
- `_entity_access: webform.submission_purge_any` — the user must be allowed to purge that webform's
  submissions.
- `_custom_access: WebformEntityAccess::checkResultsAccess` — Webform's own results-access check.

The module defines no permissions of its own; access is entirely Webform's. Entity queries in the
form run with `accessCheck(TRUE)`.

## Form fields
- Start Date (`delete_start_date`) — HTML date input.
- End Date (`delete_end_date`) — HTML date input.
- "Delete submissions" submit button.

If the webform has zero submissions, the form shows an error message instead of the fields.

## Validation
- Both dates required (empty start or end raises an error).
- Start date must not be later than end date.

## What gets deleted
Submissions of THIS webform whose `created` timestamp is `>= start` and `<= end`. An end date at
exactly midnight is bumped by 86399 seconds so the whole end day is included.

## Execution / batch behavior
- The form counts matching submissions, then compares to the webform's batch limit (`getBatchLimit()`).
- Count below the batch limit: deletes inline in one pass and shows the finished-message.
- Count at/above the batch limit: runs via Drupal's Batch API (`batch_set`), deleting `batchLimit`
  submissions per batch operation until done, so large deletions do not time out.
- Deletion is a hard delete via the submission storage handler (`delete()`); it is permanent — export
  needed data first.

## Not provided
No cron hook, no scheduled/automatic purge, no retention policy, no config schema, no Drush commands.
For automatic site-wide retention, that is a different module (e.g. Webform Global Purge).
