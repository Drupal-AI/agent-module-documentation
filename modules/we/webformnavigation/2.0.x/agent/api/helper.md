<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `webformnavigation.helper` service

Service id **`webformnavigation.helper`** → `Drupal\webformnavigation\WebformNavigationHelper`.
Tracks page visits and per-page validation errors for a webform submission so navigation state
survives across pages and drafts. Backed by a custom `webformnavigation_log` table (columns:
`lid`, `webform_id`, `sid`, `operation`, `handler_id`, `uid`, `data`, `timestamp`), built alongside
`webform_submission_log`.

## Constants

- `TABLE = 'webformnavigation_log'`
- `ERROR_OPERATION = 'errors'`, `PAGE_VISITED_OPERATION = 'page visited'`
- `HANDLER_ID = 'webform_navigation'`, `TEMP_STORE_KEY = 'webformnavigation_errors'`

## Methods

| Method | Purpose |
|---|---|
| `getCurrentPage($submission)` | Current page id (or first page). |
| `hasVisitedPage($submission, $page)` | TRUE if a `page visited` log row exists. |
| `logPageVisit($submission, $page)` | Insert a `page visited` row (once per page). |
| `getErrors($submission, $page = NULL)` | Latest logged errors (all pages, or one page). Unserializes with `allowed_classes` limited to `TranslatableMarkup`. |
| `logPageErrors($submission, $form_state)` | Rebuild the current page's errors from `$form_state->getErrors()`, mapping each element to its page (`getElementPage`); if the submission isn't saved yet, stash in private tempstore instead. |
| `logStashedPageErrors($submission)` | Flush tempstore-stashed errors into the log after the submission exists. |
| `logErrors($submission, array $errors)` | Insert a serialized `errors` row. |
| `deleteSubmissionLogs($submission, $keep_visited = FALSE)` | Delete this submission's log rows (optionally keep visit rows). Called on submission delete. |
| `validateAllPages($submission, $form_state, $form)` | Re-run validation for every accessible page (guards re-entry with `$form_state->get('validating')`), merge + log errors. Uses `validateSubmission()` which submits a throwaway `WebformSubmissionForm` and collects its errors while preserving existing messenger errors. |
| `hasAccessToPage($page, $submission)` | Whether the page is in the submission's page list. |
| `getElementPage($webform, $element)` | The page (`#webform_parents[0]`) an element belongs to. |

## Notes for callers

- Everything no-ops until the submission has an id (draft not yet saved) — pre-save errors are held
  in the `webformnavigation` private tempstore under `TEMP_STORE_KEY`.
- Error data is stored PHP-`serialize`d and read back with a restricted `allowed_classes` allowlist.
- `getErrors()` returns only the **latest** error log row (ordered by `lid DESC`, range 0,1).
