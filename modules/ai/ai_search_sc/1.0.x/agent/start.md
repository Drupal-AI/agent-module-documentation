<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Search - Semantic Chunking (ai_search_sc) — agent index

Adds one Search API **EmbeddingStrategy** plugin to **AI Search**: `semantic_chunks`
("Semantic Embedding Strategy"). Chunks content at cosine-distance breakpoints between sentence
embeddings instead of fixed token windows, then embeds each chunk with title + contextual content
prepended (same output shape as AI Search's Enriched `contextual_chunks` strategy).

- Package **AI**. `type: module`. Core `^11.1`.
- Dependencies: **`ai:ai`**, **`ai_search:ai_search`** (composer: `drupal/ai ^1.3@RC`,
  `drupal/ai_search ^1.3@alpha`). Pulls `league/html-to-markdown` transitively via AI Search's
  `EmbeddingBase`.
- **No routes, no permissions, no forms of its own, no Drush, no install/update hooks.** Config is
  the per-index strategy subform inherited from AI Search. Only hook is `hook_help`
  (`Hook\AiSearchScHelpHooks`).

## What it provides

- **Plugin** `Plugin/EmbeddingStrategy/SemanticEmbeddingStrategy` (id `semantic_chunks`), extends
  `Drupal\ai_search\Plugin\EmbeddingStrategy\EmbeddingBase`. Selected per Search API index at
  `/admin/config/search/search-api`.
- **Services** (`ai_search_sc.services.yml`, all autowired):
  - `ai_search_sc.chunker` → `Service\SemanticChunker` (cosine-distance breakpoint chunker).
  - `ai_search_sc.splitter` → `Service\SentenceSplitter` (regex sentence splitter,
    abbreviation-aware).
  - `ai_search_sc.markdown_aware_splitter` → `Service\MarkdownAwareSentenceSplitter`, a **decorator**
    of `ai_search_sc.splitter` (strips Markdown noise before, merges short fragments after).
  - `logger.channel.ai_search_sc`.
- **Config schema** `ai_search_sc.strategy_configuration` (`config/schema/ai_search_sc.schema.yml`)
  — the plugin's per-index settings; no config entity or `config/install` of its own.

## Docs

- Plugin, algorithm, settings, services, fallbacks → [plugins/semantic_embedding_strategy.md](plugins/semantic_embedding_strategy.md)

## Mechanism (one line)

`SemanticEmbeddingStrategy::getChunks()` → `SemanticChunker::chunk($text, $embedder, …)`; the
`$embedder` closure calls `$this->embeddingLlm->embeddings(new EmbeddingsInput($sentence), $modelId, $tags)`
through the **drupal/ai provider abstraction** (no direct HTTP, no API keys handled here). Content is
site-indexed node text; there is no request-supplied input, no output render sink, and no SQL.
