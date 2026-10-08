<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Pardot — agent index

A Webform handler (`pardot_submission`) that queues each submission and POSTs it to a Salesforce Pardot
Form Handler URL on cron, with field mapping and a per-submission log entity. Depends on `webform`.
The Pardot URL is admin-entered on the handler form and validated with
`FILTER_VALIDATE_URL` (trusted webform-admin config).

- **Add & configure the handler (URL, mapping syntax), the queue/cron flow, the `pardot_submission`
  entity, the admin list & permission** → [configure/handler.md](configure/handler.md)
- **`PardotHandler` service (`webform_pardot.pardot_handler`) for programmatic posting** →
  [api/handler.md](api/handler.md)

Key facts:
- Handler plugin `PardotSubmission` (`src/Plugin/WebformHandler/`), id `pardot_submission`,
  single-cardinality; settings `pardot_url` (required, URL-validated), `pardot_fields_mapping` (textarea,
  `webform_key|pardot_key` per line).
- `postSave()` creates a `pardot_submission` entity (status queued) and enqueues its id in queue
  `pardot_submission_queue`.
- Queue worker `PardotSubmissionQueue` (`cron time 60`) → `PardotHandler::submitDataToPardot($id)`.
- `PardotHandler` (service `webform_pardot.pardot_handler`, args `@http_client`, `@entity_type.manager`)
  maps data and POSTs `form_params` (`x-www-form-urlencoded`, `verify: true`); parses response into
  PARDOT_PROCESSED / PARDOT_ERROR and stores a ≤500-char log.
- Entity `pardot_submission` (base_table `pardot_submission`), admin permission `administer site
  settings`; routes: collection `/admin/structure/webform/pardot_submissions`, delete
  `/admin/webform_pardot/{id}/delete` — both require `view pardot_submission`.
