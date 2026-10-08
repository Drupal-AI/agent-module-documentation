<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin dashboard, edit/delete & permissions

## Permissions (`dga_feedback.permissions.yml`)

- `view dga feedback dashboard` — view the dashboard and submissions list (read-only).
- `manage dga feedback submissions` — edit, delete, and bulk-delete submissions.
- `administer dga feedback settings` — Settings form and Translations form.

Each admin route enforces exactly one of these (`_permission`).

## Dashboard — `/admin/content/dga-feedback`

`DgaFeedbackAdminController::listSubmissions()` (permission `view dga feedback dashboard`).
Reads query params for pagination (`page`, 50/page), sort (`sort`, `order`), and filters
(`id`, `entity_type`, `entity_id`, `url`, `is_useful`, `feedback`, `user_id`, `ip_address`,
`date_from`, `date_to`) plus URL-grouping controls. Builds render array `#theme =>
'dga_feedback_admin'` (template `templates/feedback-admin.html.twig`, preprocessed by
`DgaFeedbackHooks::preprocessDgaFeedbackAdmin`) with `#cache: {max-age: 0}` and attaches
`dga_feedback/admin` (`js/admin.js`, `css/admin.css`). Aggregates shown: overall stats,
usefulness distribution, per-URL statistics, unique URL count, most-useful / most-feedback
page, recent activity (7/30 days), useful percentage, anonymous-vs-authenticated counts,
and a core pager. Gender values are mapped to translated labels for display.

The Twig template escapes all submission-derived output: feedback via `{{ …|e }}` (and
`|e('html_attr')` in the title attribute), each reason via `{{ reason|e }}`, and URLs via
`|e('html_attr')` / `|e`. Free-text is additionally `Xss::filter()`ed on write, so stored
values are safe on render.

## Edit — `/admin/content/dga-feedback/{id}/edit` (`id: \d+`)

`DgaFeedbackAdminController::editSubmission()` builds `DgaFeedbackEditForm`
(`src/Form/DgaFeedbackEditForm.php`, permission `manage dga feedback submissions`). Loads the
row via `getSubmissionById` (404 if missing), shows `is_useful` select, reason checkboxes
sourced from config reason lists, a feedback textarea, and a gender select. Submit calls
`DgaFeedbackService::updateSubmission()`, which re-sanitizes reasons/feedback and re-applies
length caps.

## Delete — `/admin/content/dga-feedback/{id}/delete` (`id: \d+`)

`DgaFeedbackDeleteForm` (`ConfirmFormBase`, permission `manage dga feedback submissions`).
Standard confirm form (built-in form-token CSRF protection); 404 if the id is not found; on
confirm calls `deleteSubmission()`.

## Bulk delete — `POST /admin/content/dga-feedback/bulk-delete`

`DgaFeedbackAdminController::bulkDelete()` — permission `manage dga feedback submissions`
**and** `_csrf_token: TRUE`, POST-only. Reads `submissions[]` from the request, int-filters
the ids, calls `bulkDeleteSubmissions()`, sets a status/error message, and redirects back to
the dashboard. The bulk-delete URL/token is provided to `js/admin.js` via
`drupalSettings.dgaFeedback.bulkDeleteUrl`.

## Access model note

Edit/delete/bulk-delete are gated by a single global moderator permission
(`manage dga feedback submissions`), not per-record ownership — this is a shared moderation
model, not per-user record access.
