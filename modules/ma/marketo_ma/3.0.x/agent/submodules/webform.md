<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# marketo_ma_webform

Sends Webform submissions to Marketo. Requires `drupal/webform ^6`.

## Handler (src/Plugin/WebformHandler/MarketoMaWebformHandler.php)
`@WebformHandler(id = "marketo_ma")`, category "External", unlimited cardinality. Added per-form on the
Webform's Emails/Handlers UI.

### Settings (`buildConfigurationForm`)
- `formid` — a Marketo Forms 2.0 form id (present → submit via `postForm`/`submitFormUsingPOST`).
- `program_name` — used instead of a form id (visible only when `formid` empty).
- `cookie` — submit the visitor's `_mkto_trk` cookie with the lead (default on).
- `marketo_ma_list` — optional Marketo static list id to add the lead to.
- `marketo_ma_mapping` — `webform_mapping` element mapping submission fields → Marketo lead fields
  (options from `marketo_ma` service `getAvailableFields()`).

### Submission (`postSave`, on STATE_COMPLETED)
- Builds mapped data (`getMappedData()`); `webform_term_select` values are resolved to the term name.
- If `formid` set → `formSubmit()` (Forms 2.0, catches `ProcessingException` and logs).
- Else → `updateLead()`: `marketo_ma` `updateLead()`, then `addLeadToListByEmail()` for the list.
- Logs the resulting Marketo lead id.

## Failure event
`Event\SubmissionFailure` is dispatched by the core API client's `submitFormGiveUp()` when a retry can't
recover, so site code can subscribe and handle unrecoverable submissions.

## D7 migration helper
`hook_migrate_..._d7_webform_prepare_row` maps legacy D7 `marketo_ma_webform` SOAP field keys to REST
field keys and injects a `marketo_ma` handler into the migrated webform (only relevant with
`webform_migrate`).
