<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Semantic Expansion (ai_semantic_expansion) — agent index

Enriches Search API indexes with AI-generated synonyms + search-intent phrases so ordinary keyword
backends (Database/Solr/Elasticsearch) get semantic-style recall — **no vector DB**. AI generation is
decoupled from indexing: a cron queue worker (or a Drush batch) calls the LLM and writes a local cache;
the Search API processor only **reads** that cache at index time.

- Package **Artificial Intelligence**. Core `^10.4 || ^11`. PHP `>=8.1`.
- Dependencies: **`ai:ai`**, **`search_api:search_api`**. No routing, **no permissions.yml**, no
  config/schema of its own, no config entity. Uninstall deletes `ai_semantic_expansion.settings`.
- Provides **Drush** commands.

## What it provides

- **Search API processor** `Plugin/search_api/processor/AiIntentExpander` (id `ai_intent_expander`,
  stage `add_properties`). Exposes virtual property **`ai_semantic_synonyms`** (map as Fulltext + boost).
  `addFieldValues()` reads cache only (`getCachedText()`), never calls the AI at index time. Its
  `buildConfigurationForm()` is the settings UI (source_fields, body_char_limit, llm_prompt, ai_provider,
  "Flush AI cache now").
- **Queue worker** `Plugin/QueueWorker/AiSemanticExpansionWorker` (id `ai_semantic_expansion_queue`,
  `cron: {time: 30}`). Loads the node, builds source text (`strip_tags`, length-capped), calls
  `AiSemanticExpansionService::getOrGenerateExpansion()`, re-tracks the item for reindex.
- **Service** `Service/AiSemanticExpansionService` (`ai_semantic_expansion.ai_service`): cache CRUD on
  `{ai_semantic_cache}` + LLM call via the **drupal/ai** abstraction. Hash-dedup on MD5 of source text.
- **Hooks** `Hook/AiSemanticExpansionHooks` (`entity_insert`/`entity_update`, via `#[LegacyHook]` shims
  in `.module`): queue a node **only when** some index has the processor active.
- **Drush** `Commands/AiSemanticExpansionCommands`: `ai-expand:batch` (alias `aieb`), options
  `--type` / `--bundle` / `--chunk-size`. Exports to `private://…jsonl`, processes, reports.
- **Schema** (`.install`): table `ai_semantic_cache` (entity_type, entity_id, langcode, ai_text,
  content_hash MD5, created, updated; unique key entity_type+entity_id+langcode).

## Docs

- Processor, virtual field, settings, queue worker, service, Drush batch → [plugins/processor.md](plugins/processor.md)

## Mechanism (one line)

node save → `AiSemanticExpansionHooks` queues → cron `AiSemanticExpansionWorker` → `AiSemanticExpansionService::callAiProvider()`
(`$provider->chat(new ChatInput([...]), $modelId)` through `@ai.provider`) → upsert `{ai_semantic_cache}` →
Search API index run → `AiIntentExpander::addFieldValues()` reads cache → `ai_semantic_synonyms` fulltext field.
All DB access is via the parameterized query builder; no direct HTTP, no route, no anonymous surface.
