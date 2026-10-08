<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Dropsolid is a support bundle for Dropsolid's AI stack: it swaps in an XLM-Roberta-aware tokenizer, adds a token-budget-aware text chunker and matching embedding strategy for AI Search, and tags outgoing LiteLLM requests with Dropsolid DXP feature labels.
---
AI Dropsolid extends the Dropsolid AI provider (`ai_provider_dropsolidai`) and Drupal's AI module with utilities tuned for Dropsolid's self-hosted embedding models. It decorates the AI module's `ai.tokenizer` service so that, when a Dropsolid XLM-Roberta model is selected, token counting is delegated to a purpose-built tokenizer that can count via LiteLLM's HTTP token endpoint, a local SentencePiece CLI, or a character-count fallback. On top of that tokenizer it provides `TokenAwareTextChunker` — a chunker that estimates token density from a few probe samples to convert token limits into character budgets, splitting text on paragraph/sentence/word boundaries with far fewer tokenization calls than per-chunk validation — and exposes it to AI Search as the "Token-Aware Embedding Strategy" plugin. A LiteLLM event subscriber adds a single `dxp_*` metadata tag to each AI request routed through the LiteLLM provider, so operations can be attributed by feature (chat, search, embeddings, translation, etc.).

Configuration lives at `/admin/config/ai/dropsolid/tokenizer` (permission `administer ai`), where an administrator picks the tokenizer mode (LiteLLM HTTP, CLI SentencePiece, or none) and, for the CLI mode, supplies the SentencePiece executable and model file (stored in the private file system). The module ships one config object (`ai_dropsolid.settings`) with schema, one settings form, three services, an embedding-strategy plugin, and an event subscriber; it defines no permissions, entities, or Drush commands of its own.
---
- Count tokens for Dropsolid XLM-Roberta embedding models more accurately than the default tokenizer.
- Delegate token counting to LiteLLM's `/utils/token_counter` HTTP endpoint.
- Use a local SentencePiece (`spm_encode`) executable for faster, offline token counting.
- Fall back to character-level counting when no tokenizer backend is available.
- Choose the tokenizer mode (LiteLLM / CLI SentencePiece / none) from an admin form.
- Upload a SentencePiece model file into the private file system for the CLI tokenizer.
- Verify a configured tokenizer end to end from the settings form before saving.
- Chunk long documents for embedding while respecting a per-chunk token budget.
- Reduce tokenization API calls by probing token density instead of validating every chunk.
- Split text on natural boundaries (paragraphs, sentences, words) to keep chunks coherent.
- Add configurable overlap between consecutive embedding chunks for better retrieval.
- Select the "Token-Aware Embedding Strategy" in AI Search index/server configuration.
- Improve embedding quality for multilingual content via the E5-Large / XLM-Roberta tokenizers.
- Tag AI operations sent through the LiteLLM provider with `dxp_*` feature labels.
- Attribute AI usage by feature (chat, search, embeddings, translation, agents, content creation).
- Preserve an explicit `dxp_` tag already present on a request.
- Decorate the AI module's `ai.tokenizer` service without changing other providers' behaviour.
- Reuse the LiteLLM provider's existing host + API-key configuration for tokenization.
- Integrate token-aware chunking into a Dropsolid RAG / vector-search pipeline.
- Keep embedding chunk sizes aligned to the embedding model's real token limit.
