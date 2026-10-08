<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema Markup Generator — settings & configuration

## Install
```
composer require drupal/ai_schema_markup_generator
drush en ai_schema_markup_generator
```
`hook_install()` (`.install`) creates `field_schema_json` (string_long) and `field_schema_json_checkbox` (boolean) storage + instances on every existing content type and wires them into each `node.<bundle>.default` form display (textarea + checkbox). `hook_uninstall()` removes both fields and deletes the `ai_schema_markup_generator_bulk_update_last_results` state.

## Permission
`administer ai schema markup generator` (`restrict access: TRUE`) — required for both admin routes. Grant only to trusted roles.

## Settings form
Route `ai_schema_markup_generator.admin_settings` → `/admin/ai-schema-markup-generator` (`AISchemaMarkupGeneratorConfigForm`, extends `ConfigFormBase`). Writes config object `ai_schema_markup_generator.settings`:

| Key | Type | Default | Purpose |
| --- | --- | --- | --- |
| `openai_endpoint` | string | `https://api.openai.com/v1/chat/completions` | Chat-completions endpoint (any OpenAI-compatible API) |
| `openai_token` | string | `''` | Bearer token, sent as `Authorization: Bearer <token>` |
| `openai_model` | string | `gpt-3.5-turbo` | Model name |
| `openai_max_token` | string | `256` | Stored but not sent in the request body |
| `openai_max_context_length` | string | `4096` | Stored but not sent |
| `openai_temperature` | string | `1` | Passed as `temperature` |
| `openai_prompt` | string | (long default) | Schema-generation prompt prefix |
| `openai_validation_prompt` | string | (default) | Validation prompt prefix |
| `exclude_fields` | string | newline list | Field names withheld from the AI prompt |
| `content_types` | sequence | `[]` | Bundles where the per-node checkbox defaults to on |

Config schema lives in `config/schema/ai_schema_markup_generator.schema.yml`; install defaults in `config/install/ai_schema_markup_generator.settings.yml`.

`validateForm()` requires the numeric fields to be numeric and restricts `openai_token` to `[A-Za-z0-9-_]+`.

## Bulk generation
Route `ai_schema_markup_generator.bulk_schema_markup_generator` → `/admin/ai-bulk-schema-markup-generator` (`AISchemaMarkupGeneratorBulkBatchForm`). Pick content types (required), language (multilingual sites), node limit, batch size; a core Batch API run generates + validates + stores schema on eligible published nodes that currently have no schema. Results persist in state (`ai_schema_markup_generator_bulk_update_last_results`) and render in success/error tables; a "Download CSV Report" action streams a CSV. Menu/task links: `.links.menu.yml`, `.links.task.yml`.
