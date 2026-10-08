<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Liberty Create / Caselink 360 Webform integration

## What this submodule contributes vs. what Webform core does

The **HTTP POST** to the Liberty Create endpoint is performed entirely by Webform core's
`Drupal\webform\Plugin\WebformHandler\RemotePostWebformHandler` (or the contributed "Async remote post"
handler, id `async_remote_post`). This submodule adds only:

1. an example Webform config with a preconfigured `remote_post` handler;
2. three token helpers that make Liberty Create's payload shape expressible in the handler's YAML;
3. an install-time whitelist of the API-key environment variable.

There are **no routes, permissions, services, config schema, or Drush commands** in this module.

## Install / enable

- `drush en localgov_forms_example_liberty_create_integration`. Requires `localgov_forms` and
  `token_environment` (declared in the `.info.yml`).
- On install, `hook_modules_installed()` appends `DRUPAL_LIBERTY_CREATE_API_AUTH_KEY` to
  `token_environment.settings:allowed_env_variables` (only when `token_environment` is being installed
  and not during a config sync). Confirm/add it at `/admin/config/system/token-environment`.
- The example Webform `caselink_api_integration_example` is shipped under `config/optional/`, so it is
  imported if Webform is present. You still must set a **real** endpoint URL and the env var value.

## The example Webform (`caselink_api_integration_example`)

`config/optional/webform.webform.caselink_api_integration_example.yml`. Demo intake form; elements:
`name` (webform_name, first/last), `date_of_birth`, `email` (email confirm), `phone` (GB tel format),
`details_of_enquiry`, `case_address` + `residential_address` (`localgov_webform_uk_address`, OS Places /
Photon geocoders), `files` + `more_files` (`managed_file`, multiple), plus three `value` elements
(`api_response`, `api_result`, `case_ref`) that capture the CRM reply. `access.create` = anonymous +
authenticated.

Its single handler `remote_post` (Webform core Remote post) is configured with:

- `method: POST`, `type: json`.
- `completed_url: https://example-build.oncreate.app/api/REST/caselink360/1.0` — **placeholder**, replace it.
- `custom_options` (request options passed to the Guzzle client):
  ```yaml
  headers:
    API-Authentication: "[env:DRUPAL_LIBERTY_CREATE_API_AUTH_KEY]"
  ```
- `completed_custom_data` — the YAML payload template mapping form values to Caselink 360 fields
  (`payload.client_unique_identifier`, `function`, `data[0].{source_system, source_ref, first_name,
  last_name, phone_number, email_address, date_of_birth, resident_uprn, case_uprn, case_url, details,
  documents}`). `documents` uses the file pseudo-token (below).

## The three token helpers

### Full-name splitting (`hook_tokens_alter`)
For `webform_submission` tokens ending in `:extracted_firstname` / `:extracted_lastname`, the value is
`explode(' ', …)` and reduced to `current()` / `end()`. So `[…:name:extracted_firstname]` → "Foo" and
`[…:name:extracted_lastname]` → "Bar" for a name of "Foo Bar"; a single word is used for both. This runs
by *altering* the already-resolved base name token's replacement, so the base token (e.g. `…:name:clear`)
must itself resolve.

### File pseudo-token (`PrepareFileTokens`, declared in `hook_token_info_alter`)
`[webform_submission:values:ELEMENT:file_details_for_liberty_create_api]` is a *pseudo*-token: Liberty
Create wants one `documents` array entry per uploaded file, but the file count is not known at config
time. Before the POST body is built, `_localgov_forms_example_liberty_create_integration_manage_remote_post_custom_data()`
(fired from `hook_webform_handler_invoke_post_save_alter` / `…_post_load_alter`, only for handler ids
`remote_post`/`async_remote_post`, only on a `STATE_COMPLETED` submission) calls
`PrepareFileTokens::expandAllPseudoTokens($completed_custom_data, $submission)`:

- `determineAllFileElementId()` regex-scans the custom data for the pseudo-token and returns the file
  element machine ids.
- For each, `countUploadedFiles()` (`$submission->getElementData($id)` count) drives
  `prepareInlineTokens()`, which emits one inline-YAML block per file:
  `{file: {filename: "[…:ELEMENT:i:name]", is_base64: true, content: "[…:ELEMENT:i:data]"}, filename: "[…:ELEMENT:i:name]", description: '<escaped element #title>'}`.
- `expandPseudoToken()` `str_replace()`s the quoted pseudo-token with the comma-joined blocks. The result
  is written back to `settings.completed_custom_data` via `$handler->setConfiguration(...)`; **actual token
  values (filenames, base64 file contents) are inserted later by Webform core** when it builds the request.

The blocks are intentionally emitted *without* wrapping `[]`, so several file elements can be listed inside
one parent YAML array, e.g. `documents: ["[…:files:file_details_for_liberty_create_api]", "[…:more_files:…]"]`.

### API-key env var (`hook_modules_installed`)
Whitelists `DRUPAL_LIBERTY_CREATE_API_AUTH_KEY` for `token_environment` so `[env:DRUPAL_LIBERTY_CREATE_API_AUTH_KEY]`
resolves inside the handler's `custom_options` header. Set the variable's value in your environment; do not
hard-code the key.

## Operating notes

- **Sync vs async**: swap the handler for `webform_queued_post_handler`'s "Async remote post" (id
  `async_remote_post`) to POST via Drupal's queue (processed on cron) for reliability; the same alter hooks
  fire on `post_load` during queue processing. `queue_ui` helps monitor the queue.
- **Capturing responses**: the `api_response` / `api_result` / `case_ref` value elements use
  `[webform:handler:remote_post:completed:…]` tokens; everything after `:completed:` mirrors the API JSON.
  Adjust the `remote_post` handler-id segment if you rename the handler.
- **Adapt, don't ship as-is**: Liberty Create APIs differ per organisation; the README states this is an
  example to build on rather than a production integration.
