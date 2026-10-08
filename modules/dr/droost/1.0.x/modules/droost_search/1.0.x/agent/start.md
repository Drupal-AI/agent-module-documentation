<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Search (droost_search) — agent index

Submodule of **Droost**: semantic + lexical + code-graph search over the Drupal codebase, as read-only
MCP tools. Version 1.0.0-rc1 (dir `1.0.x`). Core `^10.3 || ^11 || ^12`, PHP `^8.3`. Depends on
`droost`; requires `nikic/php-parser ^5`. Provides config schema + a Drush command. Local dev only.

## MCP tools (`src/Plugin/Tool/`, all read-only, ungated)

- **`droost_search`** — semantic matches (when an embedding backend is configured) + lexical symbol
  matches. Run `drush droost:search:index` first.
- **`droost_symbol`** — find symbols (class/interface/trait/enum/function/method) by FQN substring;
  returns kind + file:line.
- **`droost_graph`** — code-graph edges for a fully-qualified symbol or a pseudo-symbol
  (`service:<id>`, `route:<name>`, `hook:<name>`); resolves a bare short class name or lists candidates.

## Pipeline (services in `droost_search.services.yml`)

- **Discovery**: `SourceDiscovery` (`droost_search.discovery`) — custom/contrib/theme, optionally
  core/config.
- **Chunkers**: `PhpChunker` (+ `SymbolCollector`), `TwigChunker`, `DocChunker`, via `ChunkerRegistry`.
- **Embedding**: `EmbeddingBackendManager` picks `HttpEmbeddingBackend` (Ollama or OpenAI-compatible),
  `NullEmbeddingBackend` (lexical-only), or the `droost_ai` AI-provider backend.
- **Vector store**: `VectorStoreManager` → `MariaDbVectorStore` or `PortableVectorStore`.
- **Code graph**: `GraphExtractor` (PHP) + `YamlGraphExtractor` → `CodeGraphStorage`.
- **Indexing**: `Indexer` (+ `FileManifest`, `IndexDiffer`, `IndexDelta` for incremental refresh).

## Config & CLI

- Config `droost_search.settings`: `store` (auto|mariadb|portable), `dimension` (768),
  `embedding_backend` (auto), `embedding_endpoint`, `embedding_model`, `embedding_format`
  (ollama|openai), `embedding_api_key`. Schema in `config/schema/`.
- Drush **`droost:search:index`** (`src/Drush/Commands/IndexCommands.php`).

## Solution doc

- The three tools, the index pipeline, config and CLI → [tools/search.md](tools/search.md)
