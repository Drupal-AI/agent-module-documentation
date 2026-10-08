AI Semantic Expansion enriches Search API indexes with AI-generated synonyms and search-intent phrases so semantically related content ranks on ordinary keyword search backends, with no vector database required.

---

The module adds a Search API processor (AI Semantic Expansion, `ai_intent_expander`) that populates a virtual `ai_semantic_synonyms` fulltext field you can map and boost. AI generation is fully decoupled from indexing: the processor only reads a local cache table, while a cron queue worker (and an optional Drush batch command) does the actual LLM calls through the drupal/ai provider abstraction and stores the result. Each node's expansion is regenerated only when an MD5 hash of its source text changes, so unchanged content never re-hits the provider, and any provider failure returns empty text instead of blocking indexing. This lets sites on the Database, Solr, or Elasticsearch backends get semantic-style recall (matching related terms and paraphrased queries) without embeddings infrastructure, by boosting one extra fulltext field.

---

- Add semantic-style recall to a Database/Solr/Elasticsearch Search API index without a vector database or embeddings pipeline.
- Populate a boostable `ai_semantic_synonyms` fulltext field with LLM-generated synonyms and likely user queries.
- Keep indexing fast by never making live AI calls during a Search API index run (cache reads only).
- Generate expansions asynchronously via the `ai_semantic_expansion_queue` cron queue worker.
- Pre-warm the cache for existing content with `drush ai-expand:batch` before the first full index.
- Limit a batch run to a bundle (`--bundle=article`) or entity type (`--type=node`), or shrink memory use (`--chunk-size=100`).
- Choose which fields feed the prompt (Title, Body, Summary/Teaser, Tags) per index in the processor settings.
- Cap tokens/cost per node with the Body character limit setting (100-5000 chars, default 600).
- Swap LLM providers/models (OpenAI, Claude, NVIDIA NIM, Ollama, and others) without code changes via the drupal/ai abstraction.
- Fall back to the site-wide default chat provider when no explicit provider is chosen.
- Customize the system prompt used for expansion, or leave it blank to use the built-in default.
- Automatically clear and re-queue all nodes when the LLM prompt changes so results stay consistent.
- Flush the entire cache on demand with the "Flush AI cache now" button on the processor form.
- Skip redundant API calls with MD5 content-hash deduplication — only changed content is re-processed.
- Keep expansions per-language: cache rows are keyed by entity type, id, and langcode.
- Handle large corpora (tens of thousands of nodes) with a memory-flat JSONL export/process pipeline.
- Automatically re-track affected items for re-indexing after the queue worker generates fresh expansions.
- Continue operating cleanly through provider outages or rate limits (empty text is stored/returned, warnings logged).
- Remove all generated data and configuration cleanly on uninstall (the cache table is dropped).
- Regenerate everything after a flush by running `drush ai-expand:batch` then `drush search-api-index`.
