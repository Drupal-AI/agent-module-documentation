<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring submission sanitation

## 1. Add the handler
On the webform: **Settings → Emails / Handlers → Add handler → Sanitize submission** (`sanitize_submission`). It is single-cardinality (one per webform). Category *Advanced*.

If you flag elements (below) but haven't added this handler, the element configuration form shows a warning with a link to the handlers page.

## 2. Flag elements to sanitize
Edit any element; on its configuration form a **Sanitation** section (advanced tab) has **Sanitize element value**:
> "If checked, the element value will be deleted from the database after submission. You can still use the value in webform handlers before the 'Sanitize submission' handler."

This sets the element's `#sanitize` property (default `FALSE`).

## 3. What happens on submit
`SanitizeSubmissionWebformHandler::postSave()`:
- Returns early if the webform has results disabled.
- For each element where `!empty($element['#sanitize'])` (`getElementsToSanitize()` over `getElementsDecodedAndFlattened()`):
  - `DELETE FROM webform_submission_data WHERE sid = <submission id> AND name = <element>` (parameterized).
  - `submission->setElementData(name, NULL)` and `submissionStorage->resetCache([sid])`.
- The raw delete deliberately avoids triggering entity hooks, so handlers ordered **before** this one still receive the value (e.g. send an email, then sanitize).

## Ordering matters
Because sanitation runs in `postSave`, ensure any handler that must consume the sensitive value (email, remote post, etc.) runs earlier. The handler summary reports how many elements are flagged for sanitation.
