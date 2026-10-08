Document Loader is a plugin framework that ingests documents from many sources (files, URLs, APIs, SaaS) and normalizes them into one uniform content-plus-metadata result.

---

Document Loader gives Drupal a single, consistent way to turn "a document from somewhere" into usable text/markdown/HTML/JSON. Source handling is split into two plugin types — DocumentLoaderType (which describes an input category and its typed Input class) and DocumentLoader (which does the actual extraction) — so third-party modules add new sources or new extraction backends without touching consumers. A high-level `DocumentLoaderManager` service performs the whole pipeline: score-based automatic type detection from a flat data array, input validation, per-input access checks, loader selection (with configurable per-type/per-output defaults), the load itself, optional truncation, and pre/post-load alter hooks. The base module ships the framework, the type/input/output classes, a settings form to pick default loaders, an explorer form to test loads, and Drush commands — but it contains no concrete loader plugins, so you install at least one loader module (PDF Parser, Webpage, AI File To Text, etc.) to extract anything. Optional submodules surface the pipeline through the AI Automators, Field Widget Actions, the MDXEditor toolbar, the media library, and AI agent tools.

---

- Build a document-ingestion layer for a RAG / embeddings pipeline that accepts PDFs, Office docs, web pages, and APIs behind one API.
- Normalize heterogeneous documents into a single `DocumentLoaderResult` (content, format, metadata, source, byte count) for downstream indexing.
- Extract text from an uploaded PDF/Word/spreadsheet file and store it in a `text_long` field automatically on entity save (via the AI Automator submodule).
- Add a "Load Document" button beside a file/URL widget that pulls extracted content into another field (via the Field Widget Actions submodule).
- Give AI agents a `document_loader:load_file` / `load_website` / `load_api` tool so an LLM can read documents (via the Tool submodule).
- Insert content from a document into the AI module's MDXEditor with one toolbar click (via the MDXEditor submodule).
- Scrape a web page to markdown/text through a pluggable website loader.
- Call a REST API endpoint (custom method, headers, body) and convert the JSON/XML response to a chosen output format.
- Convert between structured formats (JSON, YAML, TOML, XML, CSV, Markdown, HTML, Toon) using the built-in Output types.
- Load a document by Drupal file entity ID, stream-wrapper URI (`public://`, `private://`), or a remote download URL — all through one `file_input` field.
- Configure, per document type and per output format, which loader plugin is the default (settings form / `DocumentLoaderManager::setDefaultLoader()`).
- Let site builders declare per-loader tunable options (e.g. an "Unstructured" loader's strategy) via `getLoaderOptionsSchema()` and have them rendered automatically in forms.
- Load documents from the CLI for scripting or migration with `drush document-loader:load --input file_input=public://report.pdf`.
- Inspect available loaders, their supported types, input fields, and output formats with `drush document-loader:list` and `document-loader:inputs`.
- Alter output format, max length, or the chosen loader per request with `hook_document_loader_pre_load_alter()`.
- Log, annotate, or enrich loaded content and metadata with `hook_document_loader_post_load_alter()`.
- Add support for a brand-new source (e.g. Confluence) by registering a `DocumentLoaderType` + Input class and a matching `DocumentLoader` plugin — the factory, tool deriver, and forms pick it up automatically.
- Route media-library selections into a document load without needing an entity-reference field (via the media submodule opener).
- Cap returned content length for LLM context windows using the `max_length` parameter / `Maximum length` input.
- Resolve a media entity, file entity, link field, or plain-text URL/URI to the correct loader input using the shared `InputResolverTrait`.
- Present a category-aware form (only the output formats a category's loaders actually support) using `DocumentLoaderManager::discoverSourceCategories()` and `buildSchemaFormElements()`.
