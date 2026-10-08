<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform handler: config, submission mapping, defaults, validation, calculation

## Install / enable

`drush en cmrf_form_processor` (pulls `cmrf_core` + `webform`). Configure a CiviMRF connector under
CiviMRF/`cmrf_core` first, and install the **Form Processor** extension on the target CiviCRM. Then
edit a Webform → **Settings → Handlers → Add handler → "CiviCRM Form Processor with CiviMcRestFace
(CMRF)"**.

## The handler plugin

`Plugin/WebformHandler/FormProcessorWebformHandler` (`id = cmrf_form_processor`, category
"CiviCRM", `results = RESULTS_PROCESSED`, `submission = SUBMISSION_OPTIONAL`). `create()` builds a
`Factory` from `cmrf_core.core` and instantiates four sub-handlers (all extend
`FormProcessorBaseHandler`):

| Sub-handler | Role |
|-------------|------|
| `WebformSubmissionHandler` | POST submission to CiviCRM (`FormProcessor` action); CiviCRM-driven redirect |
| `DefaultDataHandler` | Retrieve `FormProcessorDefaults` to pre-fill the form |
| `CalculationHandler` | Live `FormProcessorCalculation` via AJAX trigger buttons |
| `ValidationHandler` | Server-side `FormProcessorValidation` on submit |

### Configuration form (`buildConfigurationForm`)

- **Connector** (`connection`) + **Form Processor** (`form_processor`) selects, AJAX-chained. Lists
  come from `Factory::getConnectors()` / `formProcessorList()`.
- **Send to CiviCRM** (`states`) — checkboxes over Webform states: draft created/updated, converted,
  completed (default), updated, deleted, locked.
- **Fields** — an "Update fields" toggle. When Yes, saving **synchronises** the Webform elements
  with the Form Processor input fields via `FormProcessorWebformBuilder::addFields()` /
  `deleteFields()` (checked fields are *added* as textfield/date/select; unchecked ones are
  *deleted* from the Webform — destructive, called out in the form help text).
- **Submission settings** — per-field **format** select (`buildExportRecord` item formats, plus a
  `do_not_submit` sentinel). Governs how each value is rendered before being sent to CiviCRM.
- **Default params** — enable modes: `''` (no), `enabled`, `enabled_and_page_not_found_on_no_data`,
  `enabled_and_access_denied_on_no_data`. Each Form Processor default parameter can be sourced from
  `url` (a request query arg), `current_user` (contact id), or `value` (a token-replaced string).
  "Retrieve defaults again when field X changes" registers AJAX triggers.
- **Additional** — `enable_validation`, `enable_calculation` (+ progress text / hide-form),
  `form_processor_redirect_field` (a Form Processor **output** whose value becomes a redirect),
  `form_processor_original_redirect_field` (sends the Drupal confirmation URL *to* CiviCRM, e.g. so
  a payment processor can redirect back), `form_processor_current_contact` (fill an input with the
  current user's contact id), and `metadata_cache_timeout`.

Backwards-compat in `setConfiguration()`: legacy `form_processor_require_default` is migrated to the
`form_processor_enable_default` string modes.

## Submission → CiviCRM mapping (`FormProcessorBaseHandler::webformSubmissionToApiParams`)

On the selected states, `WebformSubmissionHandler::postSave()` → `sendToCivicrm()` builds params
and calls `Factory::api($connection, 'FormProcessor', $formProcessorName, $params, [])`.

Mapping details:
- Composite elements are flattened to `parent_subkey` params; `do_not_submit` fields are skipped.
- `formatSubmissionValue()` renders each value with the configured format via Webform's
  `buildExportRecord()` (or `formatText()` for dates). `raw` sends the underlying key/value.
- **Managed-file** elements: with format `url`, the value becomes an absolute URL to the
  `cmrf_form_processor.download_file` route carrying a content hash (see
  [../api/files-and-tokens.md](../api/files-and-tokens.md)); otherwise the file is base64-encoded
  inline as `{name, mime_type, content}`.
- `form_processor_current_contact` injects `getContactId()` — read from the current user entity's
  `field_user_contact_id` field.
- `Factory::api()` swallows all throwables and returns `['is_error' => '1']` on failure; the
  submission handler then shows a generic error message to the user (details are not leaked).

`isSubmittedToCiviCRM` guards against double submission within a request.

## Defaults (`DefaultDataHandler`)

On first render (no user input) with defaults enabled, `prepareForm()` calls `FormProcessorDefaults`
with `getFormProcessorSubmissionParams()` (the configured `url`/`current_user`/`value` params) and
pre-fills the submission via `setWebformSubmissionWithCiviCRMData()` (existing non-empty values are
kept). If CiviCRM returns nothing, the `page_not_found` / `access_denied` modes throw
`NotFoundHttpException` / `AccessDeniedHttpException` — this is the intended way to gate an edit form
so users only reach records CiviCRM returns for them. Attachment defaults are downloaded locally
(see files doc). Trigger fields re-fetch defaults via an AJAX button.

## Calculation (`CalculationHandler`)

When enabled, `alterForm()` adds AJAX "Retrieve" trigger buttons (library
`webform.element.form_processor_calculation`) for the Form Processor's calculation input fields, and
`doCalculation()` calls `FormProcessorCalculation` (5-minute cache) writing outputs back into the
form elements. Calculation outputs also feed the `calculated-data:*` tokens. Validation errors
returned in a calculation reply are surfaced through `ValidationHandler`.

## Validation (`ValidationHandler`)

On submit (not rebuild, validation enabled), it clones the submission, maps it to params, calls
`FormProcessorValidation`, and turns each returned `field => message` into a form error on the
matching element (only for fields on the current page, or on the confirmation page).

## Metadata caching (`Factory`)

Field/output/option/default metadata is cached in `cache.default` keyed by
`FormProcessor*.{op}` + an md5 of the params, expiring per `metadata_cache_timeout` (default
`1 hour`). `cmrf_form_processor_cron()` / `cmrf_form_processor_cache_flush()` flush the mirrored
`OptionsSet` `WebformOptions` entities.
