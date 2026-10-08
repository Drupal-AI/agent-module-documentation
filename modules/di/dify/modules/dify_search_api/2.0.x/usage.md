<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dify Search API provides a Search API **backend plugin** (id `dify`) that indexes Drupal content into a **Dify knowledge base** instead of a local search server, with per-field priorities, three chunking strategies, and optional Dify-Workflow file text extraction.

---

Enabling the module lets you create a Search API server whose backend is **Dify**; its `SearchApiDifyBackend` plugin builds a `DifyClient` from credentials you enter on the server form (base URL, dataset API key, dataset ID, and an optional file-extraction Workflow API key), all stored in **Drupal State** keyed by server id (`dify_search_api.{server}.{name}`) and cleaned up on server delete. On the index *Fields* page the module's `hook_form_search_api_index_fields_alter` replaces Search API's **Boost** column with a **Priority** number input (default 50), saved as the index third-party setting `field_priorities`. During `indexItems()` each item's fields are gathered (fields typed **Dify File Extraction** are sent to a Dify Workflow via `DifyFileExtractorService` and replaced by the extracted text) and assembled into a Dify document by `buildStructuredDocument()`: priority ≥100 fields form a parent/identity block, priority 1–99 fields become child paragraphs, priority 0 is excluded. The chunking mode (`parent_child`/automatic) and parent mode (`full-doc`, `paragraph`, `contextual_field`) map to Dify's `process_rule` via `DifyClient::getTextIndexingOptions()`. In **Contextual Field** mode, `DifyKnowledgePipelineService` manages one Dify **segment per field** with differential sync (content hashes tracked in the `dify_field_segment_map` table), prefixing each with a plain-text identity card (`IdentityCardTrait`). Optionally each document gets a **content URL** metadata field (default name `content_url`) so chatbot answers can cite the source page. Because Dify indexes one document per request, the module's help text advises setting the index **cron batch size to 1**. Install with `composer require drupal/search_api:^1.40 league/html-to-markdown:^5.1` and `drush en dify_search_api`.

---

- Index Drupal nodes (or any Search API datasource) into a Dify knowledge base for retrieval-augmented chatbot answers.
- Reuse Dify's built-in vectorization/embeddings instead of running a local vector store.
- Control per-field relevance with a Priority value per field on the Search API index fields form.
- Promote key fields (title, type, URL) into a parent/identity block that Dify always returns as context.
- Push lower-priority fields as separate child paragraphs so Dify can chunk them independently.
- Exclude a field from indexing entirely by setting its priority to 0.
- Choose parent-child (hierarchical) chunking for long structured documents.
- Use automatic chunking when you want Dify to decide segmentation.
- Use Contextual Field mode to index one Dify segment per Drupal field, each carrying the entity's identity card.
- Keep the Dify knowledge base in sync incrementally — only changed field segments are re-sent (content-hash tracking).
- Extract text from PDF/DOCX/image file fields via a Dify Workflow (OCR) and index the result, not the file URI.
- Attach a source-URL metadata field to every document so a chatbot can link answers back to the originating page.
- Convert HTML field content to Markdown before indexing for cleaner knowledge-base text.
- Strip inline base64 image data out of indexed text (InlineImageSanitizer) to avoid bloating segments.
- Tune child chunk size, overlap, separators, and pre-processing (remove extra spaces / URLs / emails).
- Store all Dify credentials in Drupal State so they never leave the database or land in exported config/Git.
- Automatically clean up per-server credentials from State when the Search API server is deleted.
- Verify connectivity and document count from the Search API server view (Connection status / Documents in dataset).
- Deploy credentials in CI via `drush state:set` on the documented `dify_search_api.{server}.{name}` keys.
