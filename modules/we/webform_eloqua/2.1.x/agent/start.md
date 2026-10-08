<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Eloqua (webform_eloqua) — agent index

A single Webform handler plugin that posts completed Webform submissions to an Oracle Eloqua form.
Version 2.1.0. Core `^9 || ^10 || ^11`. Package `Eloqua`.

## Dependencies
- `webform:webform` (`drupal/webform ^6.3@beta`) — handler base, submission lifecycle, mapping UI.
- `eloqua_api_redux:eloqua_api_redux` (`drupal/eloqua_api_redux ^2.1`) — owns the Eloqua
  credential, connection and REST transport; consumed via the `eloqua_api_redux.forms` service.

## What it provides
- Plugin: `WebformEloquaHandler` — `@WebformHandler(id = "webform_eloqua", label = "Eloqua",
  cardinality = UNLIMITED, results = RESULTS_PROCESSED)`.
  File: `src/Plugin/WebformHandler/WebformEloquaHandler.php`.
- No routes, no permissions, no services, no config schema, no hooks, no submodules, no Drush.
- Config lives inside the host webform's handler settings: `eloqua_form_id` (string) and
  `eloqua_field_mapping` (array: webform element key => Eloqua field id).

## Flow (one direction, event-driven)
- `create()` injects `eloqua_api_redux.forms`, `renderer`, `entity_type.manager`.
- Config form (`buildConfigurationForm`) → select an Eloqua form (options from
  `Forms::getForms`), then AJAX-load its fields (`Forms::getFieldsRaw`) into a `webform_mapping`
  widget, split into default submission fields and user elements.
- `validateConfigurationForm` → rejects unknown Eloqua field ids and any unmapped required field.
- `postSave` → `remotePost`: returns unless state is `STATE_COMPLETED`; builds `fieldValues`
  payload and calls `Forms::createFormData($form_id, $form_data)`; empty result is logged, the
  submission still saves. No queue — the post is synchronous.

## Solution docs
- [plugins/webform-handler.md](plugins/webform-handler.md) — the handler: config, validation,
  the submit/post path, and how to operate it.
