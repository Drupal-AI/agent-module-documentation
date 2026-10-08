<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ai` TMGMT translator plugin + queue worker

This module defines **no plugin type**. It provides two plugin instances that plug into
TMGMT's and core's existing plugin managers.

## `@TranslatorPlugin` — id `ai`

`src/Plugin/tmgmt/Translator/AiTranslator.php`, extends `TmgmtTranslatorPluginBase`,
implements `ContinuousTranslatorInterface`.

```
@TranslatorPlugin(
  id = "ai", label = @Translation("AI"),
  ui = "Drupal\ai_tmgmt\AiTranslatorUi",
  logo = "icons/ai-module-logo.jpg",
)
```

Key methods:
- `checkAvailable()` — available when `model_selection_type == 'ai_translate'`, or when it is
  `'ai_tmgmt'` and a non-empty `chat_model` is set; otherwise `AvailableResult::no()`.
- `getSupportedRemoteLanguages()` / `getSupportedTargetLanguages()` — all enabled site
  languages; **any-to-any** (no fixed language pairs; the source is removed from the target list).
- `hasCheckoutSettings()` — `FALSE` (no per-job checkout form).
- `requestTranslation($job)` → `requestJobItemsTranslation()` then `$job->submitted()`.

## Translation flow (how a job reaches the AI provider)

`requestJobItemsTranslation(array $job_items)`:
1. Reads translator settings; sets the model on `ai.tokenizer` and `ai.text_chunker`
   (`tokenizer_model`). Reads `advanced.max_tokens` (chunk size), `advanced.rate_limit_delay`
   (default 300), `advanced.max_attempts` (default 3).
2. Flattens each job item's translatable data via `tmgmt.data`→`filterTranslatable()`.
3. **Chunking** — per field `#text`: if it contains HTML (`preg_match("/<[^<]+>/")`), split with
   `htmlSplitter()` (DOMDocument body child-nodes grouped under `max_tokens`, counted by
   `ai.tokenizer->countTokens()`); otherwise `ai.text_chunker->chunkText($text, $max, 0)`.
4. Enqueues one item per chunk on the **`ai_translator_worker`** queue
   (`job_item_id`, `key`, `keys_sequence`, `chunk`, `rate_limit_delay`, `max_attempts`, `attempts`).
5. Non-continuous jobs: `processQueue()` claims the queued items into a core `BatchBuilder`
   (`batchRequestTranslation` operations, `batchFinished` callback) and `batch_set()`s them —
   so a UI submit runs the batch immediately; failures/abandonment fall back to cron.
   Continuous jobs: items are left on the queue for cron.

`doRequest($translator, 'translate', $query_params)` — the actual model call, dispatched on
`model_selection_type`:
- **`ai_tmgmt` (basic prompt, default):** builds a **system** prompt from `advanced.prompt`
  (default `"Translate from %source% into %target% language"`) with `%source%`/`%target%`/
  `%source_code%`/`%target_code%` substituted, then:
  ```php
  $provider = \Drupal::service('ai.provider')->loadProviderFromSimpleOption($settings['chat_model']);
  $model_id = \Drupal::service('ai.provider')->getModelNameFromSimpleOption($settings['chat_model']);
  $messages = new ChatInput([new ChatMessage('system', $system_prompt), new ChatMessage('user', $chunk)]);
  $text = $provider->chat($messages, $model_id, ['ai_tmgmt'])->getNormalized()->getText();
  ```
  The `['ai_tmgmt']` tag is what the pre-request event subscriber keys off (see
  [../events/pre-request.md](../events/pre-request.md)).
- **`ai_translate` (per-language prompts):** requires the `ai_translate` submodule enabled and
  its `ai_translate.settings.prompt` configured; loads the content entity, pulls field metadata
  from `ai_translate.text_extractor->extractTextMetadata()`, and delegates to
  `ai_translate.text_translator->translateContent($chunk, $lang_to, $lang_from, $context)`.
  Non-content-entity storage or missing field metadata → the chunk is returned untranslated.

Empty or control-character-only chunks are returned unchanged (no model call).

`batchRequestTranslation()` accumulates per-key results in the batch context and does **partial
saves** via `$jobItem->addTranslatedData($tmgmtData->unflatten(...))` after each chunk (so a
mid-job failure keeps completed fields). `batchFinished()` writes the collected data again and
emits TMGMT request messages (logger under CLI, `tmgmt_write_request_messages()` in the UI).

## `@QueueWorker` — id `ai_translator_worker` (`cron = {time = 120}`)

`src/Plugin/QueueWorker/AiTranslatorWorker.php`. `processItem()` calls
`AiTranslator::batchRequestTranslation()` + `batchFinished()` for one chunk. Reliability logic:
- **Rate limits:** on an `AiRateLimitException` (or a message matching `/rate.?limit|too.?many.?request/i`)
  it stores an end-timestamp in state key `ai_tmgmt.queue.suspend_until` (= now + `rate_limit_delay`)
  and throws `SuspendQueueException`; subsequent items skip until the window elapses. Rate-limit
  failures do **not** count against `max_attempts`.
- **Retries:** other failures re-queue the item with `attempts+1`; once `attempts >= max_attempts`
  the job item is set to `JobItemInterface::STATE_ABORTED` and the item is dropped.

## Queue lifecycle hook

`ai_tmgmt.hook` implements `hook_entity_delete()` (`src/Hook/AiTranslatorHook.php`, wrapped by
`ai_tmgmt_entity_delete()` in the `.module`): when a `tmgmt_job` or `tmgmt_job_item` is deleted,
it walks the `ai_translator_worker` queue and deletes the queue items belonging to it.
