<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AT-LS configuration, routes & permissions

## Install / enable
`drush en at_ls -y`. Pulls in `advancedqueue`, `basic_auth`, `content_translation`, `views`, `entity`, `element_multiple`, `json_field`, `key`, `state_machine` (composer requires them; `yaml_editor` is suggested for editing the mappings YAML). On install it also creates the Advanced Queue `translation_requests` (`config/install/advancedqueue.advancedqueue_queue.translation_requests.yml`) and an optional `translation_requests` View. There is **no** `configure` route in `at_ls.info.yml`.

Setup order (README): map languages → create Key entities for the API key(s) → fill settings → set field mappings.

## Config objects (config/schema/at_ls.schema.yml)

### `at_ls.settings` — form `Form\AtlsSettingsForm` at `/admin/config/services/at-ls/settings`
- `api_keys`: sequence of `{source_language, api_key}`. `api_key` is a **Key** entity id of key type `at_ls` (form uses `#type: key_select`). One key per source language.
- `notification_email`: string; address AT-LS notifies when an async callback fails (defaults to `system.site` mail).
- `language_settings`: sequence of `{source_language, target_language}` — the allowed source→target pairs offered when creating requests. Validation forbids source==target, duplicates, and a source without a matching API key.
- `automatic_enable`: 0/1 toggle for automatic request creation.
- `automatic_settings`: `entity_type → bundle → {operations:{insert,update}, source_language, target_languages[], translation_type}`. Only translatable content-entity bundles with `content_translation` enabled are offered (`getConfigurableEntities()`).

Install defaults (`config/install/at_ls.settings.yml`): everything empty, `automatic_enable: 0`.

### `at_ls.languages` — form `Form\AtlsLanguagesForm` at `/admin/config/services/at-ls/languages`
- `langcodes`: sequence of `{drupal_langcode, atls_langcode}` (AT-LS uses ISO 639-2). `AtlsTrait::langCodes()` reads this to translate codes both ways; `getTranslationLanguages()` returns only Drupal languages that have a mapping.

### `at_ls.mappings` — form `Form\AtlsMappingsForm` at `/admin/config/services/at-ls/mappings`
- `entity_mappings`: `entity_type → bundle → field_name → [field_property, …]`. Declares which field properties are sent for translation. Entity-reference / entity-reference-revisions fields are recursed into (see entities/workflow.md).

## Routes (at_ls.routing.yml)
| Route | Path | Access |
|---|---|---|
| `at_ls.languages_form` | `/admin/config/services/at-ls/languages` | `_permission: at-ls configuration form` |
| `at_ls.settings_form` | `/admin/config/services/at-ls/settings` | `_permission: at-ls configuration form` |
| `at_ls.mappings_form` | `/admin/config/services/at-ls/mappings` | `_permission: at-ls configuration form` |
| `at_ls.translation_request` | `/at-ls-translation-request/create/{entity_type}/{entity_id}` | `_permission: access create at-ls translation request form` (`Form\CreateAtlsTranslationRequestForm`, confirm form) |
| `at_ls.asynchronous_callback` | `/atls/asynchronous` | `_permission: access content` (`Controller\AtlsAsyncCallbackResponse::ping`) — AT-LS delivery callback keyed by `?code=<atls_token>` |
| `at_ls.test_*` (6) | `/atls/test/…` | `_permission: at-ls configuration form` (`Controller\TestResponse`) |

The 6 `at_ls.test_*` routes hit `Controller\TestResponse`, whose own docblock says it is "only for testing purposes on the development phase" and should be removed for production; they invoke API-manager methods with hard-coded `es`/`en` and are gated by the admin `at-ls configuration form` permission.

Entity routes come from `Routing\AtlsTranslationRequestRouteProvider` + core providers; `Access\AtlsTranslationRequestAccessCheck::checkProcess` guards the request "process" form (allowed only if the request `isProcessable()` and the user has `administer at_ls_translation_request`).

## Permissions (at_ls.permissions.yml)
- `access create at-ls translation request form` — open the create-request confirm form.
- `at-ls configuration form` (restrict access) — the three config forms + test endpoints.
- `administer at_ls_string` (restrict access) — admin permission of the `at_ls_string` entity.
- `administer at_ls_translation_request` (restrict access) — admin permission of the `at_ls_translation_request` entity; also required to process a request.

## Keys
API keys are never stored in module config directly — only the Key entity **id** is stored in `at_ls.settings.api_keys`. `Service\AtlsApiManager::getApiKey()` resolves the id via `KeyRepositoryInterface::getKey()->getKeyValue()` at request time and sends it in the `X-ATRTS-API-Key` header (see api/api-manager.md).
