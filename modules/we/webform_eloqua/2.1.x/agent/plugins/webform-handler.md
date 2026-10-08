<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebformEloquaHandler — Eloqua post handler

Class: `Drupal\webform_eloqua\Plugin\WebformHandler\WebformEloquaHandler`
File: `src/Plugin/WebformHandler/WebformEloquaHandler.php`
Base: `Drupal\webform\Plugin\WebformHandlerBase`.

Plugin annotation:
```
@WebformHandler(
  id = "webform_eloqua",
  label = "Eloqua",
  category = "Webform",
  description = "Post Webform data to Eloqua.",
  cardinality = CARDINALITY_UNLIMITED,
  results = RESULTS_PROCESSED,
)
```
Unlimited cardinality → several Eloqua handlers may run on one webform. `RESULTS_PROCESSED` →
the handler acts after the submission is processed/saved.

## Install / enable
`drush en webform_eloqua`. Requires `webform` and `eloqua_api_redux` enabled, and a working
Eloqua connection configured in Eloqua API Redux (this module has no settings page of its own —
`configure` is null). Then, on a webform: Handlers → Add handler → "Eloqua".

## Injected services (`create()`)
- `eloqua_api_redux.forms` → `$eloquaFormsService` (`\Drupal\eloqua_api_redux\Service\Forms`).
- `renderer` → `$renderer` (used only to render the "required fields missing" list).
- `entity_type.manager` → `$entityTypeManager` (loads `webform_submission` field definitions).

## Configuration (`defaultConfiguration`)
Stored in the host webform's handler settings, no separate config entity:
- `eloqua_form_id` (string, default `''`) — target Eloqua form id.
- `eloqua_field_mapping` (array, default `[]`) — `webform_element_key => eloqua_field_id`.

### Config form — `buildConfigurationForm`
- `eloqua[eloqua_form_id]`: required `select`; options from `getEloquaForms()` (calls
  `Forms::getForms(['orderBy' => 'name'])`, caches on `$eloquaForms`). Has an `#ajax` callback
  (`ajaxCallback`) that re-renders `settings][field_mapping` into wrapper `field-mapping-wrapper`.
- Two `webform_mapping` widgets inside `field_mapping`:
  - `default` — source = default submission fields from `getDefaultWebformSubmissionFields()`
    (`webform_submission` storage field definitions, access-filtered via
    `checkFieldDefinitionAccess`); `#parents = ['settings','default_eloqua_field_mapping']`.
  - `user` — source = `$this->webform->getElementsInitializedFlattenedAndHasValue()` (the form's
    own elements); `#parents = ['settings','user_eloqua_field_mapping']`.
- Destination options for both = the selected Eloqua form's fields from `getEloquaFields()`,
  labelled with ` (*)` when required, `asort`-ed by label. Both details panels are hidden until
  an Eloqua form is selected (`#states` on `eloqua[eloqua_form_id]`).

### Eloqua field loading — `getEloquaFields($form_id)`
Calls `Forms::getFieldsRaw($form_id)`, keys results by field id, and marks
`$field['isRequired'] = TRUE` when any `validations[].condition.type == 'IsRequiredCondition'`.
Cached on `$eloquaFields`/`$eloquaFormId` to limit API calls.

### Validation — `validateConfigurationForm`
- Reads `default_eloqua_field_mapping` and `user_eloqua_field_mapping` from form state.
- Error if a mapped Eloqua field id is not in the loaded fields ("Could not find field in
  Eloqua with the specified ID %id").
- Error (form-level) listing any required Eloqua field that was not mapped in either group.
- On success, merges default+user maps and writes the combined array to the `eloqua_field_mapping`
  form value; `submitConfigurationForm` → `applyFormStateToConfiguration`.

## Runtime post path
- `postSave($webform_submission, $update)`: computes `$state`
  (`STATE_COMPLETED` when the webform has `results_disabled`, else the submission's own state),
  then `remotePost($state, $webform_submission)`.
- `remotePost`: **returns immediately unless `$state == STATE_COMPLETED`** — drafts/partials are
  never sent. Builds `$form_data['fieldValues'][]` entries of shape
  `['type' => 'FormField', 'id' => <eloqua_field_id>, 'value' => $data[<webform_element_key>]]`
  from the stored mapping, then calls `Forms::createFormData($form_id, $form_data)`.
- On an empty API result it logs (handler logger): `'"@form" webform remote post to Eloqua
  failed. @message'`. The submission still saves locally; the visitor sees no error. There is no
  retry and no queue — the call is synchronous inside submission save.
- `getRequestData`: `$webform_submission->toArray(TRUE)`, flattens `data` over the top-level
  properties (element values win), then `tokenManager->replaceNoRenderContext(...)`. Only keys
  present in the mapping are actually posted.

## Operating notes
- No output/markup is rendered from remote Eloqua data into the page — labels come from the
  Eloqua field `name` and are shown only in the admin mapping widget.
- All Eloqua authentication and HTTP transport live in `eloqua_api_redux`; this handler holds no
  credentials and issues no HTTP itself.
- Because the post is synchronous and only logs on failure, an Eloqua outage silently drops the
  forwarding while local submissions keep saving — monitor the webform handler log if delivery
  matters.
