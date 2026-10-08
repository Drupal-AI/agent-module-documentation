<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Processor, queue worker, service & Drush batch

## Install / enable

`composer require drupal/ai_semantic_expansion` → `drush en ai_semantic_expansion` → `drush updb`
(creates `{ai_semantic_cache}`). Needs `ai` (≥1 chat provider configured), `search_api` (an active
index), and a configured **private files** directory for the batch export.

## Search API processor `ai_intent_expander`

`src/Plugin/search_api/processor/AiIntentExpander.php`, `@SearchApiProcessor(id="ai_intent_expander")`,
extends `ProcessorPluginBase implements PluginFormInterface`, stage `add_properties`.

- `getPropertyDefinitions()` returns one **index-level** virtual property `ai_semantic_synonyms`
  (type `string`, label "AI Semantic Synonyms"). Add it under the index **Fields**, set type
  **Fulltext**, apply a boost (e.g. ×2).
- `addFieldValues(ItemInterface $item)` runs only for `node` items; it calls
  `getAiService()->getCachedText('node', $entityId, $langcode)` — **cache read only, no AI call at
  index time** — and adds the stored text to the field. Empty cache → no value.
- `defaultConfiguration()`: `source_fields => ['title','body']`, `body_char_limit => 600`,
  `llm_prompt => ''`, `ai_provider => 'nvidia_nim'`.
- `buildConfigurationForm()` fields: **Source fields** (checkboxes: title, body, field_summary,
  field_tags), **Body character limit** (100-5000), **LLM system prompt** (textarea; blank = default),
  **AI provider and model** (from `getSimpleProviderModelOptions('chat')`; blank = site default), and a
  **"Flush AI cache now"** danger submit (`flushCacheSubmit` → `invalidateCache()`).
- `submitConfigurationForm()`: on an `llm_prompt` change it calls `invalidateCache()` then
  `requeueAllNodes()` (entity query `accessCheck(FALSE)`, chunked by 500 — used only to enumerate ids to
  queue for regeneration, not to display anything). This form is part of the Search API index config UI
  (operator gated by Search API's own admin permission).

## Service `AiSemanticExpansionService`

`src/Service/AiSemanticExpansionService.php` (`ai_semantic_expansion.ai_service`). Table constant
`CACHE_TABLE = 'ai_semantic_cache'`.

- `getOrGenerateExpansion($type,$id,$langcode,$sourceText)`: `md5($sourceText)`; if the cached
  `content_hash` matches, return cached `ai_text` (no API call), else `callAiProvider()` + `upsertCache()`.
- `getCachedText(...)`: read-only fetch for the processor.
- `callAiProvider($sourceText)`: reads `ai_semantic_expansion.settings` (`ai_provider`, `llm_prompt`),
  `aiProviderManager->getSetProvider('chat', …)`, builds `new ChatInput([new ChatMessage('user',
  $sourceText)])` with the system prompt, `$provider->chat($input, $modelId, ['ai_semantic_expansion'])`,
  returns trimmed text. Any `\Throwable` → logs a warning and returns `''` (indexing never blocks).
  **All provider I/O goes through the drupal/ai abstraction — the module makes no direct HTTP calls and
  handles no credentials of its own.**
- `buildSourceText($values,$charLimit=600)`: space-join + `mb_substr` cap.
- `invalidateCache($type=NULL,$id=NULL)`: truncate the whole table, or delete one row.
- All DB access uses the parameterized query builder (`select()/merge()/delete()/truncate()` with
  `->condition()`), keyed on the `entity_lookup` unique index.

## Queue worker `ai_semantic_expansion_queue`

`src/Plugin/QueueWorker/AiSemanticExpansionWorker.php`, `#[QueueWorker(id:'ai_semantic_expansion_queue',
cron:['time'=>30])]`. `processItem($data)`: validate keys → load entity → `getProcessorConfig()` (from
the first index with the processor) → `buildSourceText()` (`strip_tags` each configured field,
length-capped) → `getOrGenerateExpansion()` → `markForReindex()` (re-tracks the item in every active
index that has the processor). Empty source text is skipped.

## Hooks (queue triggers)

`src/Hook/AiSemanticExpansionHooks.php` — `entity_insert`/`entity_update` call `queueEntity()`, which
bails for non-`node` entities and when no index has the processor (`processorIsActive()`), else creates
a queue item `{entity_type, entity_id, langcode}`. `.module` wires the classic-hook shims with
`#[LegacyHook]`.

## Drush `ai-expand:batch` (alias `aieb`)

`src/Commands/AiSemanticExpansionCommands.php`. Options `--type` (default `node`), `--bundle`,
`--chunk-size` (default 500). Three phases:
1. **Export** (`exportToJsonl`): `queryEntityIds()` selects ids straight from the entity **base table**
   (`$definition->getBaseTable()` / id key / optional bundle key — all from the entity definition, not
   user input) for memory-flat scale; writes `{entity_type,entity_id,langcode,source_text}` lines to
   `private://ai_semantic_batch_<time>.jsonl`.
2. **Process** (`processFromJsonl`): read each line, `getOrGenerateExpansion()`; malformed lines and
   exceptions counted as failed (logged), loop always completes.
3. **Report**: processed / skipped / failed totals.

## Cache lifecycle

`{ai_semantic_cache}` (from `hook_schema` in `.install`): serial id, entity_type, entity_id, langcode,
`ai_text` (big text), `content_hash` (MD5), created, updated. Unique key `(entity_type,entity_id,
langcode)`; index on `updated`. Uninstall drops the table and deletes `ai_semantic_expansion.settings`.
Regeneration flow after a flush: `drush ai-expand:batch` then `drush search-api-index`.
