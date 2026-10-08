<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migration (ai_migration) — agent index

Turns web pages into structured Drupal entities: a Migrate Plus `ai` data parser fetches a URL, cleans the HTML, derives a JSON schema from the destination content type (Schemata), and asks an AI chat provider to return schema-matching JSON:API data that ordinary Migrate process plugins map onto fields. Version **1.0.x** (1.0.0-rc1). Core `^10 || ^11`. Package: Migration.

## Dependencies
core `ai`, `jsonapi`, `migrate`, `migrate_plus`, `serialization`, `schemata`, `schemata_json_schema`, `document_loader_html_processor`. Composer also pulls `migrate_tools` and `league/commonmark` (README-on-help-page rendering). AI operations run through the configured provider at `/admin/config/ai` (cost per call).

## What it provides
- **Migrate Plus data parser** `ai` — `Plugin/migrate_plus/data_parser/Ai.php`. Drop-in for `data_parser_plugin: ai` on a `url` source. Per URL: fetches via the http data fetcher, optionally runs the html_processor, calls `AiMigrator::convert()`, applies an optional `item_selector`.
- **Service** `ai_migration.ai_migrator` — `AiMigrator` (`src/AiMigrator.php`). Core logic: build schema (`createSchema()` via Schemata `schema_json:api_json`), fetch HTML if not supplied (Guzzle, 30s timeout, TLS on by default), build chat messages, call the provider, `decodeResponse()` (extracts the first `{…}`, returns `data` array). Uses a caching layer keyed by prompt+provider+model.
- **Prompt plugin type** `ai_migration_prompt` — manager `plugin.manager.ai_migration_prompt` (`PromptPluginManager`), attribute `#[AiPrompt]`, interface `AiPromptInterface`, default plugin `PromptString` (id `ai_migration_prompt:string`). Wrapped by service `ai_migration.prompt_manager` (`AiMigrationPromptManager`) which layers migration-config prompt overrides (roles user/system; operations prepend/append/replace; enums in `src/Enum/`) over the built-in defaults (`PromptDefault`).
- **Cache** service `ai_migration.cache_provider` (`AiMigrationCacheBinProvider`) over a dedicated `ai_migration` cache bin (xxh32 hash of prompt+provider+model).
- **JSON:API normalizers** (`src/Normalizer/jsonapi/`) that shape the Schemata output into the schema sent to the model.
- `hook_help` (`ai_migration.module`) renders README.md through CommonMark with `html_input: strip` and `allow_unsafe_links: FALSE`.

## No routes / permissions / config
No `*.routing.yml`, `*.permissions.yml`, no `config/` in the parent module, no config schema, no drush commands of its own. It is operated entirely through Migrate (drush `migrate_tools` or the Migrate Plus UI) — administer-migrations / shell access only, not anonymous. Source URLs come from migration YAML authored by that operator.

## Submodule
`ai_migration_example` (own info.yml, deps `media`, `media_library`, `migrate_file`). Ships three sample migrations and the content types/fields/vocabulary they target. No separate doc dir exists for it; see [example submodule](submodule/ai-migration-example.md).

## Solution docs
- [Data parser & migration YAML](plugins/data-parser.md) — the `ai` parser, source config keys (`urls`, `types`, `ai.model`, `prompt`, `html_processor`, `item_selector`), and the migrate pipeline.
- [AiMigrator service & schema](api/ai-migrator.md) — fetch, schema generation, provider call, response decoding, caching.
- [Prompt system](plugins/prompts.md) — the `ai_migration_prompt` plugin type, default prompts, and per-migration prompt overrides.
- [Example submodule](submodule/ai-migration-example.md) — the sample migrations, content types and install behavior.
