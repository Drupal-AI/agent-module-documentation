<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token-aware text chunker + embedding strategy

## `Service\TokenAwareTextChunker`

`final`, **extends `Drupal\ai\Utility\TextChunker`** and implements `TokenAwareTextChunkerInterface`.
Service `ai_dropsolid.token_aware_text_chunker` (arg `@ai.tokenizer`); the interface is aliased to
the service. Public API (`TokenAwareTextChunkerInterface`): `chunkText($text,$maxSize,$minOverlap)`,
`countTokens($text)`, `setModel($model)`.

### Why it exists

Instead of tokenizing every candidate chunk (N tokenizer calls, each possibly an HTTP round-trip),
it estimates token **density** (tokens/char) from a few probes, converts the token budget to a
character budget, and splits on separators — typically **3-4 tokenizer calls per document total**.

### `chunkText()` algorithm (from source)

1. `validateChunkingParameters()` — `maxSize > 0`, `minOverlap >= 0`, `minOverlap < maxSize` (else
   `InvalidArgumentException`).
2. `normalizeTextForProcessing()` — CRLF/CR → LF, trim per line, collapse 2+ blank lines to one
   blank line, trim leading/trailing newlines.
3. Fast path: if the whole text fits in `hardMaxChars = floor((maxSize - 10) / 0.36)`, return it as
   a single chunk.
4. Otherwise `buildChunkingPlan()`:
   - `determineTokenDensity()` probes segments — one probe at 50% for short text (`<= 1200` chars),
     else three at 10/50/90% (`PROBE_CENTERS`), window 1200-2200 chars — and takes the **max**
     observed density.
   - `guardDensity = max(0.36, observed * 1.03)` (`MODEL_MAX_DENSITY` ceiling, `VARIANCE_FACTOR` 3%).
   - `deriveBudgetsFromDensity()`: `effectiveLimit = floor((maxSize - 10) * 0.99)`
     (`TOKEN_SAFETY_MARGIN` 10, `TARGET_FILL` 0.99); `charBudget = effectiveLimit / guardDensity`
     (capped at text length); `overlapChars = ceil(minOverlap / guardDensity)` capped at 60% of
     budget (`MAX_OVERLAP_FRACTION`); `minStride = 40%` of budget (`MIN_STRIDE_FRACTION`).
5. `chunkWithSeparators()` walks the text: end guess = `start + charBudget`, snapped **backward** to
   the nearest separator within a 400-char window (`snapBackwardToBoundary`), ignoring the snap if it
   would shrink the chunk below 75% of budget (`MIN_POST_SNAP_FRACTION`). Next start =
   `max(start + minStride, end - overlapChars)`, snapped **forward**. A too-small last chunk
   (`< 66%` of budget) is merged into the previous one.
   Separator priority (`DEFAULT_SEPARATORS`): `"\n\n" > "\n" > ". " > "\t" > " "` (bare `.` removed
   so URLs aren't split).
6. Risk-based validation: `pickChunkForValidation()` scores chunks (length + non-ASCII ratio ×600 +
   emoji ratio ×900) and validates only the riskiest by calling `countTokens()`. If it exceeds
   `maxSize`, the guard density is raised from the observed density and budgets recomputed (or the
   budget cut by `VALIDATION_REDUCTION_RATIO` 0.90); at most `MAX_VALIDATION_ATTEMPTS` (1) re-chunk.
7. `sanitizeChunks()` trims and drops empties.

`countTokens()` delegates to the injected `ai.tokenizer` (wrapping failures in `RuntimeException`);
`setModel()` forwards to it. Because the injected `ai.tokenizer` is the decorated one, a Dropsolid
model routes token counting through `DropsolidXlmRobertaTokenizer`
([tokenizer.md](tokenizer.md)).

## `Plugin\EmbeddingStrategy\TokenAwareEmbeddingStrategy`

Plugin for the **AI Search** (`ai_search`) `EmbeddingStrategy` plugin type — attribute
`#[EmbeddingStrategy(id: 'ds_token_aware_chunks', label: 'Token-Aware Embedding Strategy (Separator-Based Chunking)', …)]`,
extends `Drupal\ai_search\Plugin\EmbeddingStrategy\EmbeddingBase`.

Its only override is `create()`: after `parent::create()`, it replaces the base class's
`$instance->textChunker` with the `ai_dropsolid.token_aware_text_chunker` service. All other
embedding behaviour comes from `EmbeddingBase`. Select this strategy in an AI Search index/server's
embedding configuration to use the token-aware chunker for that index.

## Operate

- Requires `ai_search` for the plugin to be discovered; the chunker service itself works without it.
- Set the tokenizer mode (LiteLLM/CLI/none) in the tokenizer settings form so `countTokens()` has a
  backend; with `none`/no backend the tokenizer falls back to character counting, which still yields
  usable (if coarser) chunk budgets.
