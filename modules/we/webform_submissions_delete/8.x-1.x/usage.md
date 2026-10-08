<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Submissions Delete adds a per-webform tab to bulk-delete submissions inside a chosen date range.

---

Webform Submissions Delete **adds a manual "Bulk Delete" tab under each webform's Results tab** that
deletes submissions whose creation date falls within an admin-chosen start/end date range. It is a
**manual, on-demand admin action** — not scheduled, not cron-driven, and not a retention policy: an
administrator opens the form, picks a start and end date, and clicks "Delete submissions". Deletion runs
inline when the matched count is under the webform's batch limit, or via Drupal's Batch API for larger
sets so it does not time out. It depends on the Webform module and lives in the Webform package.

The delete tab is gated by Webform's own access: the route requires the `webform.submission_purge_any`
entity access and Webform's results-access check, so only users who may purge that webform's results see
it. Deletion is **destructive** — matched submissions are permanently removed (export first if you need
the data). The form validates that both dates are present and that the start date is not after the end
date; an end date entered at midnight is extended to cover the whole day. It defines no permissions,
config schema, cron hooks, or Drush commands of its own — the only surface is the per-webform form tab.

---

- Bulk-delete a webform's submissions by date range.
- Open the "Bulk Delete" tab under a webform's Results tab.
- Pick a start date and end date for deletion.
- Delete every submission created within that range.
- Run deletion on-demand (manual admin action, not scheduled).
- Purge old submissions to reduce stored form data.
- Clean up test or spam submissions from a period.
- Trim a webform's results before an export or archive.
- Remove submissions from a specific campaign window.
- Delete a single day's submissions (midnight end date covers the full day).
- Handle large deletions via Drupal's Batch API without timing out.
- Delete inline when the matched count is below the batch limit.
- Restrict the action to users who may purge that webform's results.
- Reuse Webform's own results-access checks on the route.
- Validate that both start and end dates are supplied.
- Reject a start date later than the end date.
- Support meeting data-minimization goals by removing old submissions.
- Reduce retained submission PII for a chosen period.
- Free database space held by obsolete submissions.
- Delete submissions per webform (scope is one webform at a time).
- Complement Webform's built-in "Clear" (all) with a range-limited delete.
- Confirm the deletion count after the operation completes.
- KNOW deletion is permanent (export needed data first).
- Depend on the Webform module.
