<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Search — tools, index pipeline, config & CLI

Three read-only MCP tools (extend `DroostToolBase`, ungated — introspection is always available) over
a code index you build with Drush.

## Tools (`src/Plugin/Tool/`)

- **`droost_search`** (`Search.php`) — searches the indexed codebase: semantic matches when an
  embedding backend is configured, plus lexical symbol matches. Requires the index; run
  `drush droost:search:index` first.
- **`droost_symbol`** (`Symbol.php`) — finds symbols (class/interface/trait/enum/function/method) by a
  substring of the fully-qualified name; returns kind and file:line.
- **`droost_graph`** (`Graph.php`) — returns code-graph edges for a fully-qualified symbol or a
  pseudo-symbol (`service:<id>`, `route:<name>`, `hook:<name>`); a bare short class name (e.g.
  `PathGuard`) is resolved to its FQN, or the ambiguous candidates are returned (a wrong name form is
  never mistaken for "no edges"). Supports a `direction` argument.

## Index pipeline (`src/`)

`Indexer` orchestrates: `SourceDiscovery` finds files (custom/contrib/theme, optionally core/config),
`ChunkerRegistry` dispatches to `PhpChunker` (AST via `nikic/php-parser`, with `SymbolCollector`),
`TwigChunker`, `DocChunker`. Chunks are embedded through the backend chosen by
`EmbeddingBackendManager` and stored via `VectorStoreManager`. `FileManifest` + `IndexDiffer` /
`IndexDelta` make refreshes incremental (only changed files re-chunked). The **config scope** runs
values through `SecretRedactor::redact()` before chunking, so credentials in config are never embedded
or returned. The code graph is extracted by `GraphExtractor` (PHP) and `YamlGraphExtractor` (services,
routes, hooks) into `CodeGraphStorage`.

## Embedding backends (`src/Embedding/`)

`EmbeddingBackendManager` selects, per `droost_search.settings.embedding_backend`:

- **`HttpEmbeddingBackend`** — POSTs to a configurable model server: `ollama` format
  (`/api/embeddings`, one request per text) or `openai` format (`/v1/embeddings`, batched;
  llama.cpp / LM Studio locally, or cloud OpenAI/Mistral with a key). The endpoint is
  **operator-configured** (`embedding_endpoint`), Bearer key in a header (`embedding_api_key`, not the
  URL), Guzzle default TLS, 5s/60s timeouts; chunks are UTF-8-scrubbed and capped at 6000 chars.
- **`NullEmbeddingBackend`** — lexical-only fallback.
- The `droost_ai` submodule adds an AI-module-default provider backend.

## Vector stores (`src/VectorStore/`)

`VectorStoreManager` picks `MariaDbVectorStore` (native vectors) or `PortableVectorStore`, per
`droost_search.settings.store` (`auto|mariadb|portable`).

## Config `droost_search.settings` (`config/install`, schema `config/schema`)

`store: auto`, `dimension: 768`, `embedding_backend: auto`, `embedding_endpoint: ''`,
`embedding_model: ''`, `embedding_format: ollama`, `embedding_api_key: ''`. The API key is
plain-config (operator's own; masked by name on any `droost_config_get` read).

## CLI

`drush droost:search:index` (`src/Drush/Commands/IndexCommands.php`) builds and incrementally refreshes
the index.
