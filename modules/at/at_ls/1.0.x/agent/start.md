<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AT-LS (at_ls) — agent index

Integrates Drupal content translation with the **AT-LS** translation service (`https://rts.at-ls.com/atrts/restapi/`). Maps Drupal langcodes → AT-LS ISO 639-2, sends mapped entity fields for **synchronous ("Automatic")** or **asynchronous ("Professional")** translation, and writes results back as new entity translations. Version 1.0.0. Core `^9 || ^10 || ^11`. Not security-advisory covered.

## Dependencies
`advancedqueue`, `basic_auth`, `content_translation`, `views`, `entity`, `element_multiple`, `json_field`, `key`, `state_machine`. Suggests `yaml_editor`.

## What it provides
- **Content entities** (`src/Entity/`): `at_ls_translation_request` (one entity → one target language request; workflow `translation_request_default`) and `at_ls_string` (a single source string, deduped by SHA-256 hash; workflow `string_default`). Both revisionable.
- **Config objects**: `at_ls.settings` (API keys per source language, language settings, notification email, automatic-translation rules), `at_ls.languages` (langcode ↔ AT-LS code map), `at_ls.mappings` (entity_type → bundle → field → properties to translate). Schema in `config/schema/at_ls.schema.yml`.
- **Services** (`at_ls.services.yml`): `at_ls.api_manager` (`Service\AtlsApiManager`), `at_ls.http_client` (`Http\GuzzleHttpClient`), `at_ls.translation_request.manager` (`Service\AtlsTranslationRequestManager`), two event subscribers, `at_ls.translation_request.processed_guard` (state_machine guard), `logger.channel.at_ls`, `at_ls.route_subscriber`.
- **AdvancedQueue job type** `translation_request_job` (`Plugin\AdvancedQueue\JobType\AtlsTranslationRequestJob`) on the `translation_requests` queue.
- **Routes** (`at_ls.routing.yml`): three admin config forms, a create-request confirm form, the async callback `/atls/asynchronous`, and 6 dev "test" endpoints. See config doc.
- **Permissions** (`at_ls.permissions.yml`): `access create at-ls translation request form`, `at-ls configuration form`, `administer at_ls_string`, `administer at_ls_translation_request`.
- **Hooks** (`at_ls.module`): `hook_entity_insert/update` dispatch translatable-entity events; `hook_entity_operation`, `hook_entity_type_alter`, `hook_menu_local_tasks_alter` add the "AT-LS Translate" action/tab; `hook_theme` for the request template.

## Solution docs
- [config/settings.md](config/settings.md) — install/enable, the three config objects + schema keys, routes, permissions, keys.
- [api/api-manager.md](api/api-manager.md) — the AT-LS REST client: endpoints, auth header, methods.
- [entities/workflow.md](entities/workflow.md) — entities, workflow, queue job, event flow, write-back.
