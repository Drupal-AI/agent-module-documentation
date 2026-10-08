<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Pardot webform handler

No global settings page. Configuration is per webform, on the handler.

## Add the handler

Webform → *Settings → Emails / Handlers* (`admin/structure/webform/manage/{webform}/handlers`) →
**Add handler → "Submit data to Pardot"** (plugin `pardot_submission`, cardinality single). Form
`PardotSubmission::buildConfigurationForm()`:

| Setting | Type | Notes |
|---|---|---|
| `pardot_url` | textfield (required) | The Pardot Form Handler endpoint. Validated with `FILTER_VALIDATE_URL`. |
| `pardot_fields_mapping` | textarea (optional) | One `webform_key|pardot_key` per line. Unmapped keys pass through unchanged. |

Mapping supports drilling into complex element values with dot/bracket paths, e.g.
`person.name|name` or `person[name]|name` (see `PardotHandler::mapData()` / `combinedKeyAdd()`).

## Submission flow

1. `PardotSubmission::postSave()` — on every webform submission, creates a `pardot_submission` entity
   (status `PARDOT_QUEUED`) and adds its id to the `pardot_submission_queue`.
2. Cron → `PardotSubmissionQueue::processItem()` (queue worker, `cron time = 60`) →
   `PardotHandler::submitDataToPardot($id)`.
3. `PardotHandler` loads the webform submission, reads `pardot_url` + mapping from the handler config,
   remaps the data, and POSTs it (`form_params`, `Content-type: application/x-www-form-urlencoded`,
   `verify: true`) via `@http_client`.
4. `processResponse()` sets status `PARDOT_PROCESSED` or `PARDOT_ERROR` (a body containing
   "field is required" → error advising to make the field required on the webform; 5xx → "Internal
   Server Error at Pardot"; other non-2xx → generic error) and stores `statusCode: log` (≤500 chars) on
   the entity.

## The `pardot_submission` log entity

Content entity `pardot_submission` (`src/Entity/PardotSubmission.php`), base table `pardot_submission`,
data table `pardot_submission_data`, `admin_permission = "administer site settings"`. Fields include
`webform_submission` (ref), `status`, and appended `log` items (`addLog()`).

- List builder: `/admin/structure/webform/pardot_submissions` (route
  `entity.pardot_submission.collection`).
- Delete: `/admin/webform_pardot/{pardot_submission}/delete`.
- Both routes require permission **`view pardot_submission`** (`webform_pardot.permissions.yml`).
  Note: the delete route is also gated only by `view pardot_submission` (not a separate delete perm).
