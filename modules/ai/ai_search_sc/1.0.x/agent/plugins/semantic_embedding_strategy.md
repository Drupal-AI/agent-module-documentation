<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Semantic Embedding Strategy plugin (`semantic_chunks`)

`src/Plugin/EmbeddingStrategy/SemanticEmbeddingStrategy.php`. `#[EmbeddingStrategy(id: 'semantic_chunks',
label: 'Semantic Embedding Strategy')]`, `final`, extends `Drupal\ai_search\Plugin\EmbeddingStrategy\EmbeddingBase`.
It is an AI Search plugin type — this module does **not** define a new plugin type, it adds one instance.

## Install / enable

`drush en ai_search_sc`. Requires `ai` + `ai_search` enabled and an **AI embedding provider already
configured for AI Search** (the strategy reuses whatever provider AI Search is wired to). Then edit a
Search API index (`/admin/config/search/search-api`), and on the AI Search server/index config choose
**Semantic Embedding Strategy**. Re-index to apply.

## Configuration (per-index strategy subform)

`getConfigurationSubform()` extends the parent Enriched subform. Field ids come from
`src/Enum/FormFieldsNames.php`; schema is `ai_search_sc.strategy_configuration` in
`config/schema/ai_search_sc.schema.yml`. Keys and defaults (`getDefaultConfigurationValues()`):

| Key | Type | Default | Form bounds | Meaning |
|---|---|---|---|---|
| `breakpoint_percentile` | float | `0.95` | min 0.5, max 0.99, step 0.01, required | Percentile of inter-sentence distances used as the split threshold. Higher = fewer, larger chunks. |
| `min_sentences_per_chunk` | int | `2` | min 1, max 20, required | Breakpoints suppressed until the current chunk has this many sentences. |
| `max_chunk_chars` | int | `4000` | min 200, required | Hard cap (Unicode chars) on the assembled chunk. Soft for a single oversized sentence or an oversized title (never truncated). |
| `max_sentences_for_semantic` | int | `500` | min 10, required | Above this sentence count, skip embeddings and use the character fallback. Primary cost knob. |
| `chunk_size` | int/null | model max | — | **Fallback path only** (token chunker). Blank = embedding-model maximum. |
| `chunk_min_overlap` | int/null | `100` | not required | **Fallback path only.** Blank = 100 tokens (`FALLBACK_CHUNK_MIN_OVERLAP`). |
| `skip_moderation` | bool | inherited | — | From parent; adds `skip_moderation` tag to embedding calls. |
| `contextual_content_max_percentage` | int | inherited | — | Parent budget split between contextual and main content. |

`init()` reads config into typed properties, coercing with `is_numeric`; unset/invalid values keep the
class-constant defaults.

## Algorithm (`getChunks()` → `SemanticChunker::chunk()`)

1. `getChunks($title, $main_content, $contextual_content)` computes character budgets from
   `contextual_content_max_percentage`. `$main_budget = maxChunkChars * mainRatio - mb_strlen(title)`;
   a title longer than the main budget clamps the budget to 1 but is **not** clipped (identity
   preserved), so the final chunk may exceed `max_chunk_chars`. Empty main content → `parent::getChunks()`.
2. It builds an `$embedder` closure and calls `SemanticChunker::chunk($main_content, $embedder,
   $main_budget, breakpointPercentile, minSentencesPerChunk, maxSentencesForSemantic)`.
3. Empty/unusable result → `parent::getChunks()` (token path) so content is never silently dropped.
   Otherwise each returned chunk is re-assembled via `prepareChunkText($title, $chunk, $context)`.

`SemanticChunker::chunk()` (`src/Service/SemanticChunker.php`, `final readonly`):

- Splits with the injected `SentenceSplitterInterface`. 0 sentences → `[]`; 1 sentence → emitted intact
  (or `sizeFallback` if over the cap).
- If `count(sentences) > max_sentences_for_semantic` → logs a warning and returns `sizeFallback()`
  (no embeddings).
- Calls `$embedder($sentences)`. Any `\Throwable`, or a vector list whose shape/length/row-length is
  off, → `sizeFallback()`.
- `cosineDistance()` (1 − cosine similarity; 1.0 for a zero-magnitude vector) between consecutive
  sentence vectors; `percentile()` (numpy-style linear interpolation) picks the threshold.
- Walks sentences: flush the current buffer and start a new chunk when appending would overflow
  `max_chunk_chars`, or when the boundary distance ≥ threshold **and** the buffer already has ≥
  `min_sentences_per_chunk` sentences. Chunks join sentences with a single space.

## The embedder closure

In `getChunks()`: tags `['ai_search', 'ai_search_sc']` (+ `skip_moderation` when set), then for each
distinct sentence calls `$this->embeddingLlm->embeddings(new EmbeddingsInput($sentence), $this->modelId,
$tags)->getNormalized()`, caching by sentence string so duplicates cost one call. This is the **only**
outbound call and it goes through the **drupal/ai** provider abstraction (`@ai.provider`) — the module
makes no direct HTTP calls and handles no credentials of its own.

## Services & sentence splitting

- `SentenceSplitter` (`ai_search_sc.splitter`): normalises whitespace/EOL, splits on `\n{2,}`
  paragraph breaks then on `.?!。！？` + whitespace with a Unicode lookahead; `mergeAbbreviationSplits()`
  re-glues splits after a short abbreviation list (`mr`, `eg`, `etc`, `inc`, …).
- `MarkdownAwareSentenceSplitter` (`ai_search_sc.markdown_aware_splitter`, **decorates**
  `ai_search_sc.splitter`): `prepareMarkdown()` strips setext underlines, horizontal rules, ATX `#`,
  rewrites `1.` list markers to `1)`, and strips `**`/`__`/`*`/`_` emphasis before splitting;
  `mergeShortFragments()` re-merges un-terminated fragments under 60 chars (`FRAGMENT_CHAR_LIMIT`) with
  the next sentence. Remove its definition in a custom `ServiceProviderInterface::register()` to disable.

## Fallbacks (summary)

Character-based `sizeFallback()` fires on: embedder exception, bad vector shape, or document over
`max_sentences_for_semantic`. Parent token `getChunks()` fires on: empty main content, or semantic
chunker returning `[]`. Both keep indexing running without dropping content.
