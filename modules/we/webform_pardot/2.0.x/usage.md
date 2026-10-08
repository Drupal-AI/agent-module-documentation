<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Pardot provides a Webform handler that queues each webform submission and posts it (via cron) to a Salesforce Pardot Form Handler endpoint, with optional field-name mapping and a per-submission log entity.

---

Adding the "Submit data to Pardot" handler (`pardot_submission`) to a webform lets you configure a
Pardot post URL and a mapping of `webform_key|pardot_key` lines (one per line, supporting dotted/bracket
paths into complex element values). On submission the handler's `postSave()` creates a `pardot_submission`
content entity in status "queued" and enqueues its id in the `pardot_submission_queue` cron queue.
When cron runs, the queue worker calls `PardotHandler::submitDataToPardot()`, which loads the webform
submission, resolves the handler's URL and mapping, remaps the data keys, and POSTs them as
`application/x-www-form-urlencoded` (`verify: true`) to Pardot using the core HTTP client. The response
is inspected — a body containing "field is required" or a non-2xx/5xx status is recorded as an error —
and the outcome (status code + up-to-500-char log) is stored back on the `pardot_submission` entity.
Admins can review submissions at `/admin/structure/webform/pardot_submissions` (permission
`view pardot_submission`) and delete them. Queueing rather than posting inline keeps form submission fast
and lets Pardot errors be logged. The Pardot URL is admin-entered on the handler form and validated with
`FILTER_VALIDATE_URL`.

---

- Post Webform submissions to a Salesforce Pardot Form Handler endpoint.
- Capture marketing leads from Drupal webforms into Pardot.
- Queue submissions and send them on cron to keep form submission fast.
- Map Drupal webform field keys to differently-named Pardot fields.
- Extract values from complex/composite webform elements via dotted paths (e.g. `person.name|name`).
- Log the Pardot response and status per submission for troubleshooting.
- Detect Pardot "field is required" validation errors and mark the submission as errored.
- Review all Pardot submissions in an admin list at `/admin/structure/webform/pardot_submissions`.
- Delete stored Pardot submission log entities.
- Retry/track failed posts by inspecting the queued/processed/error status.
- Use a more performant, logged alternative to Webform's generic remote_post for Pardot.
- Attach the handler to multiple webforms, each with its own Pardot endpoint.
- Keep a persistent audit trail of what was sent to Pardot and when.
- Send only mapped fields while leaving unmapped keys as-is.
- Integrate lead-gen landing-page forms with a Pardot marketing pipeline.
- Centralize Pardot posting logic in one reusable handler instead of per-form code.
