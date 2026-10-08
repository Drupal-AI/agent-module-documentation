<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Forms example Liberty Create integration (localgov_forms_example_liberty_create_integration) — agent index

An **example** LocalGov Drupal submodule showing how to POST Webform submissions to a REST API on
Netcall's **Liberty Create** low-code platform (the **Caselink 360** CRM `caselink_360_create_update_case`
method). The HTTP POST itself is done by **Webform core's `RemotePostWebformHandler`**; this module only
ships an example Webform and token/glue helpers. Package `LocalGov Drupal`. Core `^10 || ^11`.
GPL-2.0-or-later. Part of `localgov_forms`. **Treat as a template, not a finished integration.**

- **What it provides, the tokens, the example Webform config, and how to wire it up** →
  [integrations/liberty-create.md](integrations/liberty-create.md)

## Dependencies

- `localgov_forms:localgov_forms` and `token_environment:token_environment` (both required).
- Uses Webform core's Remote post handler; the README also mentions the optional contrib
  `webform_queued_post_handler` ("Async remote post") and `queue_ui`.

## What it actually is (from source)

- **No** routes, permissions, services, entities, plugins, or Drush commands. No `config/schema`.
- Ships one Webform **config entity** at `config/optional/webform.webform.caselink_api_integration_example.yml`
  (id `caselink_api_integration_example`) — a demo intake form with a preconfigured `remote_post` handler.
- `localgov_forms_example_liberty_create_integration.module` (hooks):
  - `hook_modules_installed()` — appends `DRUPAL_LIBERTY_CREATE_API_AUTH_KEY` to
    `token_environment.settings:allowed_env_variables` (so it becomes an `[env:…]` token).
  - `hook_tokens_alter()` — resolves `…:extracted_firstname` / `…:extracted_lastname` by
    `explode(' ', …)` on a `webform_submission` name value (single word → both).
  - `hook_token_info_alter()` — declares the `values:?:file_details_for_liberty_create_api` pseudo-token.
  - `hook_webform_handler_invoke_post_save_alter()` / `…_post_load_alter()` — for handler ids
    `remote_post` / `async_remote_post`, on a **completed** submission, rewrites
    `settings.completed_custom_data` by expanding the file pseudo-token before the POST body is built.
- `src/PrepareFileTokens.php` — static helpers: `determineAllFileElementId()` (regex-scans custom data),
  `countUploadedFiles()`, `prepareInlineTokens()` (builds per-file inline-YAML blocks with
  `filename` / `is_base64: true` / base64 `content` tokens), `expandPseudoToken()` / `expandAllPseudoTokens()`.

## Auth & endpoint model

- API endpoint = the handler's `completed_url` (example: `https://example-build.oncreate.app/api/REST/caselink360/1.0`).
- API key = supplied as a **header** via the handler's `custom_options`:
  `headers: { API-Authentication: "[env:DRUPAL_LIBERTY_CREATE_API_AUTH_KEY]" }` — resolved from an
  environment variable through `token_environment`, not stored in this module's code.
- Operators must supply the real endpoint URL and set the env var themselves; the shipped values are placeholders.
