<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migrate — process & source plugins

All classes under `src/Plugin/migrate/`. Enable: `drush en ai_migrate` (pulls `ai`, `migrate_plus`; also enable `ai_content_suggestions`).

## Provider/prompt resolution — `AiProcessBase`
`process/AiProcessBase.php` (abstract, extends `ProcessPluginBase`, implements `ContainerFactoryPluginInterface`). Constructor injects `ai.provider` (`AiProviderPluginManager`) and `config.factory`; caches two immutable configs: `ai_content_suggestions.settings` and `ai_content_suggestions.prompts`. Key methods:
- `getSetProvider(string $operation_type, ?string $preferred_model)` — if a preferred model string is given, resolves provider+model via `loadProviderFromSimpleOption()` / `getModelNameFromSimpleOption()`; otherwise uses `getDefaultProviderForOperationType($operation_type)`.
- `getGeneratedResponse(string $process, string $input, string $prompt = '')` — looks up the per-task provider from `settings.get('plugins')[$process]`, builds a `ChatInput` with a single user `ChatMessage`, sets a fixed system role ("You are helpful assistant."), calls `$ai_provider->chat($messages, $model_id, ['ai_content_suggestions'])->getNormalized()`, and trims the text. Empty prompt → the task's stored prompt (`prompts_config->get($process)`) is prepended to `$input`. Empty response or any exception → `MigrateSkipRowException` (row is skipped, not failed). Uses the drupal/ai abstraction throughout — no direct HTTP call, no API key handling here (the provider/Key config lives in the `ai` module).

## `ai_summarize_content` — `AiSummarizeContent`
`transform($value, …)` returns `NULL` on empty input, else `getGeneratedResponse('summarise', $value)`. Map onto a text field's `/value`; the sample sets `/format` separately (e.g. a `content_format` constant). Task key `summarise` must be configured in AI Content Suggestions.

## `ai_suggest_title` — `AiSuggestTitle`
`transform()` → `getGeneratedResponse('title_suggest', $value)`. Map onto the node `title`. Task key `title_suggest`.

## `ai_assign_tags` — `AiAssignTags`
`multiple()` returns TRUE (produces an array of term IDs). Configuration keys: `vid` (source vocabulary, default `tags`), `use_existing_only` (0/1).
- `getAllTerms($vid)` loads every term in the vocabulary via an entity query (`accessCheck(FALSE)` — a read used to build the allowed-term list) keyed name→tid.
- With `use_existing_only`: builds a prompt from `prompts_config->get('taxonomy_suggest_from_voc')` plus the JSON list of existing term names, instructing the model to return only comma-separated names from that list; matches returned names back to existing tids and logs+skips any name not in the vocabulary.
- Without it: `prompts_config->get('taxonomy_suggest_open')`, then `getOrCreateTermsByNames()` — existing terms matched case-insensitively, missing ones created with `Term::create(['name'=>…, 'vid'=>…])->save()`. Task key for the chat call is `taxonomy_suggest`.

## Source plugin — `drupal10_node_fields` (`Drupal10Node`)
`source/Drupal10Node.php` extends `SqlBase`. `query()` selects base fields from `node_field_data` (default-language rows only) LEFT JOINed to `node__body` for `body_value`/`body_summary`/`body_format`, ordered by nid. `getIds()` = nid (integer). `prepareRow()` overwrites `changed` with `time()`. The source database is a separate connection (`key: migrate_source`) defined in `settings.php` `$databases`; no network fetch — data comes from SQL.

## Notes
- These plugins are only invoked by a running migration (CLI drush or Migrate Plus UI); there is no route or form of their own.
- Source content is sent to the configured AI provider as chat input; confirm that egress is acceptable for the content being migrated. Provider selection, model and the API key/TLS are governed by the `ai` module and AI Content Suggestions, not by this module.
