<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema Markup Generator — service & bulk API

## Service `ai_schema_markup_generator.schema_generator`
`Service\AISchemaMarkupGenerator` (deps: `http_client`, `logger.factory`, `config.factory`, `entity_type.manager`, `file_url_generator`, `request_stack`).

- `callApi(string $prompt, bool $exclude_system_message = FALSE): string|false` — reads endpoint/token/model/temperature from `ai_schema_markup_generator.settings`, POSTs `{model, messages, temperature}` to the endpoint via Guzzle (`Authorization: Bearer <token>`, `timeout: 60`), returns `choices[0].message.content`. Aborts with a logged error if endpoint or token is missing; exceptions are caught and logged.
- `generateSchema(NodeInterface $node): ?array` — builds a prompt (`buildPrompt`), calls the API, `json_decode`s the response; returns the decoded array or NULL (logging on empty prompt / no response / invalid JSON).
- `validateSchema(array $schema): string|false` — sends the validation prompt plus the JSON-encoded schema (system message excluded); returns the raw model reply (expected `valid` or corrected JSON-LD). Logs the result at notice level.
- `buildPrompt(NodeInterface $node): string` — iterates `$node->getFields()`, skips empty and `exclude_fields`, and formats by type: `image` → absolute file URLs, `datetime`/`daterange` → formatted dates, `link` → resolved URLs, `entity_reference` → labels or media URLs, default → scalar/JSON. The assembled field text is run through `strip_tags` + `html_entity_decode`, and the current scheme+host is appended as `Website Domain:`.

## Bulk batch (`AISchemaMarkupGeneratorBulkBatchForm`)
`submitForm()` runs an entity query for published nodes of the selected bundles (optionally by language) that have no schema yet (`accessCheck(TRUE)`), chunks the nids by batch size, and queues `processBatchItem()` operations.

`processBatchItem()` (static): for each node, `generateSchema()` then `validateSchema()`; if valid (or the validation reply decodes as JSON) it sets the checkbox on and stores `json_encode(..., JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)` into `field_schema_json`, then `$node->save()`. Results (title/type/schema/validation or error) are written to state `ai_schema_markup_generator_bulk_update_last_results`. `downloadCsv()` streams those results as CSV via a `StreamedResponse`.

## Notes
- OpenAI-compatible: any chat-completions endpoint works; the token is a plain config value (store it in an env-backed Key/secret where possible).
- TLS: Guzzle default verification applies (no verification is disabled).
- The generator has no Drush commands; automation goes through the bulk form's Batch API.
