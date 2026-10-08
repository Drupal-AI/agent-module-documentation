<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Search provides semantic, lexical, and code-graph search over the Drupal codebase, exposed to AI agents as read-only MCP tools.

---

Droost Search indexes the Drupal codebase — custom, contrib and theme code, optionally core and active configuration — and lets an AI agent search it three ways over MCP. It discovers source (`SourceDiscovery`), chunks it per language (`PhpChunker` via `nikic/php-parser` with symbol collection, `TwigChunker`, `DocChunker`), embeds chunks through a pluggable backend (a local or OpenAI-compatible HTTP embedding server via `HttpEmbeddingBackend`, or the site's AI default provider when the `droost_ai` submodule is enabled, or none for lexical-only), and stores vectors in a pluggable vector store (`auto`, MariaDB native vectors, or a portable store). Separately it extracts a code graph (`GraphExtractor` for PHP, `YamlGraphExtractor` for YAML) into `CodeGraphStorage`. The three read-only tools are `droost_search` (semantic + lexical symbol matches), `droost_symbol` (find symbols by fully-qualified-name substring), and `droost_graph` (edges for a real symbol or a pseudo-symbol such as `service:<id>`, `route:<name>`, `hook:<name>`). The index is built and incrementally refreshed with `drush droost:search:index`. It depends on the Droost base module and is for local/trusted development only.

---

- Semantic-search the codebase for "where is caching invalidated" and get relevant code chunks.
- Lexically find a class/interface/trait/enum/function/method by a substring of its FQN.
- Find who calls a method or who depends on a class via the code graph.
- Query graph edges for a service id, a route name, or a hook name (pseudo-symbols).
- Resolve a bare short class name to its fully-qualified match (or get the candidate list).
- Index custom + contrib + theme code, and optionally core and active config.
- Build the index against a local embedding server (Ollama or OpenAI-compatible /v1/embeddings).
- Reuse the site's AI-module embeddings provider instead (with the droost_ai submodule).
- Fall back to lexical-only search when no embedding backend is configured.
- Store vectors in MariaDB native vectors or a portable store (auto-selected).
- Build and incrementally refresh the index with `drush droost:search:index`.
- Redact secret-looking config values before they are ever embedded or returned.
- Give an AI agent grounded, version-correct code context instead of guessing.
- Cap embedded chunk size to fit a local model's context window.
- Point an agent at the right file:line before it edits.
