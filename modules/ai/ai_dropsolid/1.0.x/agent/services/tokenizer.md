<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tokenizer: decorator + XLM-Roberta implementation

Two services in `src/Tokenizer/` provide token counting for Dropsolid's XLM-Roberta embedding
models, plugging into the AI module's `ai.tokenizer` service (`Drupal\ai\Utility\TokenizerInterface`).

## Service wiring (`ai_dropsolid.services.yml`)

```yaml
ai_dropsolid.tokenizer.xlm_roberta:
  class: Drupal\ai_dropsolid\Tokenizer\DropsolidXlmRobertaTokenizer
  arguments: ['@config.factory','@file_system','@entity_type.manager','@key.repository','@http_client','@logger.channel.ai_dropsolid']

ai_dropsolid.tokenizer.decorator:
  class: Drupal\ai_dropsolid\Tokenizer\DropsolidTokenizerDecorator
  decorates: ai.tokenizer
  decoration_priority: 10
  arguments: ['@ai_dropsolid.tokenizer.decorator.inner','@ai_dropsolid.tokenizer.xlm_roberta']

logger.channel.ai_dropsolid: { parent: logger.channel_base, arguments: ['ai_dropsolid'] }
```

## `DropsolidTokenizerDecorator`

Implements `TokenizerInterface`; wraps the inner core `ai.tokenizer` plus the Dropsolid tokenizer.

- `setModel($model)` — if `dropsolidTokenizer->supportsModel($model)` sets a private flag ON and
  routes to the Dropsolid tokenizer; otherwise flag OFF and delegates to the inner tokenizer. So
  **only Dropsolid-supported models change behaviour**; every other model is untouched.
- `getSupportedModels()` — merges inner models with Dropsolid's (adds
  `dropsolid_xlmr__xlm-roberta-base` => "Dropsolid.ai - XLM-Roberta Base").
- `getTokens()`, `countTokens()`, `getEncodedChunks()`, `decodeChunk()` — forwarded to whichever
  tokenizer is active (`activeTokenizer()`), guarding `method_exists` for the chunk methods.

## `DropsolidXlmRobertaTokenizer`

`final`, implements `TokenizerInterface`. Supported option
`dropsolid_xlmr__xlm-roberta-base`; default model `xlm-roberta-base`. Mode is read from
`ai_dropsolid.settings` `tokenizer.mode` (`getConfiguredMode()`, defaults to / falls back to
`lite_llm` on any invalid value).

### `countTokens($chunk)`

Trims; empty → 0. If mode `cli_sentencepiece` → `tokenizeWithSentencePiece()` and returns
`count($tokens)` when non-null. If mode `lite_llm` → `countTokensWithLiteLlm()`. Otherwise (or on
failure) returns `mb_strlen($chunk)` (character count).

### `getTokens()` / `tokenize()`

`cli_sentencepiece` first (falls back to LiteLLM then to per-character split on failure, logging a
`notice` each step); `lite_llm` calls `tokenizeWithLiteLlm()`; final fallback `fallbackTokenize()`
= `preg_split('//u', ...)` (one token per grapheme). `getEncodedChunks($text,$maxSize)` splits the
token list with `array_chunk` (throws on `$maxSize <= 0`); `decodeChunk()` = `implode('', ...)`.

### SentencePiece path (`tokenizeWithSentencePiece()`)

- Reads `tokenizer.cli` config; needs a non-empty `executable_name` (else warns → null).
- `resolveSentencePieceModelPath()` prefers `model_path` (if `file_exists`), else loads the
  `model_file` File entity and uses `file_system->realpath($file->getFileUri())`.
- Builds `sprintf('%s --model=%s --output_format=piece', escapeshellarg($fullExecutablePath), escapeshellarg($modelPath))`
  and runs it via `proc_open` with pipes. **The text is written to the process's STDIN**
  (`fwrite($pipes[0], $text)`), not placed on the command line. Non-zero exit or empty stdout →
  logs + null; success → `preg_split('/\s+/', ...)` of the piece output.

### LiteLLM path (`tokenizeWithLiteLlm()` / `countTokensWithLiteLlm()`)

- `resolveLiteLlmContext()` reads `ai_provider_litellm.settings`: `host` and `api_key` (a Key
  machine name). Resolves the key via `key.repository->getKey($apiKeyId)->getKeyValue()` (falling
  back to the raw id string). Returns `[rtrim($host,'/') . '/utils/token_counter', $apiKey]` or null
  if host/key missing.
- POSTs via `@http_client` (Guzzle) with `headers: { Authorization: 'Bearer '.$apiKey }`,
  `json: { model: 'eu-e5large-embeddings-selfhosted', prompt: $text }`, `timeout: 10`. TLS uses the
  Guzzle default (verified). Reads `original_tokens` (→ token list) or `total_tokens` (→ count).
  Guzzle/other exceptions are caught and logged via the `ai_dropsolid` channel.

### Model helpers

`supportsModel()` compares against the identifiers derived from `SUPPORTED_OPTIONS` keys (the part
after `__`), so `xlm-roberta-base` matches. `setModel()` falls back to the default when unsupported.

## Notes

- The tokenizer only takes over for the Dropsolid model id; all other AI providers keep the core
  tokenizer via the decorator.
- The LiteLLM host/key are **not** configured in this module — they come from
  `ai_provider_litellm.settings` (host string + Key entity). The API key is sent only in the
  `Authorization` header, never in the URL or query string, and is not logged.
