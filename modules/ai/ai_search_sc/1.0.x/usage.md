AI Search - Semantic Chunking adds a "Semantic Embedding Strategy" to the AI Search module that splits content into chunks at embedding-similarity breakpoints instead of fixed token windows.

---

The module registers a single Search API `EmbeddingStrategy` plugin (`semantic_chunks`) provided by AI Search. It mirrors AI Search's Enriched strategy (one embedding per chunk, title + contextual content prepended) but replaces the token-window chunker with a cosine-distance breakpoint chunker: it cleans Markdown noise, splits main content into sentences, embeds each distinct sentence once through whichever provider AI Search uses, measures cosine distance between consecutive sentences, and starts a new chunk wherever that distance exceeds the configured percentile threshold (subject to a minimum-sentences-per-chunk floor and a maximum-characters cap). This tends to keep topically related sentences together, which improves retrieval coherence for long-form prose at the cost of extra embedding calls during indexing. It degrades gracefully: on embedder failure, an unusable vector shape, or documents above a sentence ceiling it falls back to plain character-based chunking, and on empty or unusable results it defers to AI Search's token-based path so indexing never drops content. All AI calls go through the drupal/ai provider abstraction; the module makes no HTTP requests of its own.

---

- Improve retrieval quality on a Retrieval-Augmented Generation (RAG) index by chunking at topic shifts rather than arbitrary token counts.
- Index long-form documentation, articles, guides, or knowledge-base pages where a fixed token window splits mid-topic.
- Select the Semantic Embedding Strategy per Search API index while keeping the token strategy on other indexes.
- Keep headings and their following body text in the same chunk so retrieval returns coherent passages.
- Reduce the number of chunks that return partial or context-less passages to an LLM answer step.
- Tune `breakpoint_percentile` (default 0.95, range 0.5-0.99) to control how aggressively content is split — lower for more, smaller chunks.
- Enforce a minimum chunk size with `min_sentences_per_chunk` (default 2, capped at 20 in the form) to avoid tiny fragments.
- Cap assembled chunk size with `max_chunk_chars` (default 4000 Unicode characters) as a hard safety limit.
- Contain embedding cost on very large documents with `max_sentences_for_semantic` (default 500) — above it, the character-based fallback runs with no per-sentence embedding pass.
- Pre-clean Markdown structural noise (setext underlines, ATX `#` markers, horizontal rules, emphasis markers, numbered-list dots) automatically before splitting via the `MarkdownAwareSentenceSplitter` decorator.
- Preserve snake_case identifiers by disabling the Markdown decorator through a custom ServiceProvider when source content is already plain text.
- Keep indexing resilient when the embedding provider is down — the strategy falls back to character-based chunking for that document and continues.
- Deduplicate identical sentences (headings, boilerplate) so the provider is only billed once per distinct string per document.
- Handle non-Latin scripts and CJK terminators in sentence splitting without mangling the text.
- Run semantic chunking on any provider AI Search supports (OpenAI, Anthropic, Ollama, and others) without provider-specific code.
- Troubleshoot single-chunk documents by lowering `breakpoint_percentile` or `min_sentences_per_chunk`.
- Speed up or cheapen indexing of large corpora by lowering `max_sentences_for_semantic` to trigger the fallback sooner.
- Use the fallback token-chunker knobs (`chunk_size`, `chunk_min_overlap`) only for the fallback path while relying on semantic breakpoints normally.
- Pair with the RAG Search project for end-to-end retrieval-augmented question answering on top of the semantic index.
