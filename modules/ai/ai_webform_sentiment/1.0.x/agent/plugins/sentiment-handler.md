<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sentiment analysis pipeline — handler, queue, processor, Drush

The full path from "visitor submits a webform" to "an integer score in the database".

## 1. The Webform handler (enqueue)

`src/Plugin/WebformHandler/SentimentAnalysisWebformHandler.php`, annotated
`@WebformHandler(id = "sentiment_analysis", category = "AI",
cardinality = CARDINALITY_UNLIMITED, results = RESULTS_PROCESSED)`. Add it per webform under
**Settings → Emails / Handlers → Add handler → Sentiment Analysis**.

- `defaultConfiguration()`: `prompt` (a multi-line default asking the model to *"score it from 0
  (negative low) to 5 (positive, high)… you only return a number"* with a `[submission]` token) and
  `llm_model` (`''`).
- `buildConfigurationForm()`: a **LLM Model** select built from
  `aiProviderManager->getSimpleProviderModelOptions('chat')` (`array_shift` drops the first option;
  empty option = *"Default from AI module (chat)"*) and a required **Prompt** textarea. Values are
  saved by `submitConfigurationForm()`.
- `postSave($webform_submission, $update)`: **returns early if `isDraft()`**; otherwise
  `queueFactory->get('analyze_sentiment')->createItem([...])` with `webform_id`, `submission_id`,
  and `handler_id`. Runs on **every** completed save (create and update).

## 2. Queue worker (cron)

`src/Plugin/QueueWorker/SentimentAnalysisQueueWorker.php`, `@QueueWorker(id = "analyze_sentiment",
cron = {"time" = 60})`. Its `processItem($data)` just calls
`ai_webform_sentiment.processor->processItem($data)`. So core's cron queue runner drains the queue,
up to 60s per cron. Independently, **`hook_cron()`** in `.module` also calls
`processor->processQueue()` (which loops `claimItem()` with no time cap). Both drive the same work.

## 3. The processor service

`src/SentimentProcessor.php`, service `ai_webform_sentiment.processor`
(args `@queue @entity_type.manager @ai.provider @database @datetime.time`).

`processItem(array $data)`:
1. Loads the `webform_submission` entity; logs + returns if missing.
2. Loads the handler config from the webform to get `prompt` and `llm_model`.
3. **Prompt build**: if `[submission]` is present, concatenates **all** submission fields as
   `key: value\n` (array values `implode(', ')`) and `str_replace`s it into the prompt. (All
   submission field values are included in the prompt text sent to the provider.)
4. Provider resolution: if `llm_model` is empty, uses
   `aiProviderManager->getDefaultProviderForOperationType('chat')`; else splits `provider__model`
   on `__`. Loads via `loadProviderFromSimpleOption()`.
5. Sets `temperature` from config `llm_temp` (default `0.5`), then
   `$provider->chat(new ChatInput([new ChatMessage('user', $prompt)]), $model, ['ai_search_block'])`.
6. **`$sentiment = (int) trim($response)`** — the model's text reply is coerced to an integer, so a
   non-numeric or prose reply becomes `0`. This int is what gets stored.
7. `INSERT` into table `ai_webform_sentiment` (`webform_id`, `submission_id`, `datetime` now,
   `sentiment`) via the DB query builder.
8. On any exception it logs and re-throws so the queue item is released/retried.

`processQueue()` (used by cron/Drush): logs the queue size, loops `claimItem()`, calls
`processItem()`, `deleteItem()` on success or `releaseItem()` on exception, returns the count.
Note: emits several `notice`-level log lines per run (queue size, per-item, the raw prompt).

## 4. Database table

`hook_schema()` in `ai_webform_sentiment.install` creates table **`ai_webform_sentiment`**:
`sentiment_id` (serial PK), `webform_id` (varchar 64), `submission_id` (int), `datetime`
(datetime), `sentiment` (**varchar 255**, though only `(int)` values are ever written). Indexes:
`webform_submission` (webform_id, submission_id) and `datetime`. `hook_install`/`hook_uninstall`
only post a status message; the table is dropped by core on uninstall.

## 5. Drush

`src/Commands/SentimentCommands.php` (registered in `drush.services.yml`) provides
**`ai_webform_sentiment:process-queue`** (alias **`aisq`**) → `processor->processQueue()`. Use it
to drain the queue immediately instead of waiting for cron.

## Operating notes

- **Cron is mandatory** — nothing is scored until cron (or the Drush command) runs.
- **Cost**: one LLM chat call per non-draft submission (and per update). High-volume forms =
  proportional API spend.
- Prompt must keep the literal `[submission]` token to include the answers; the scale (0-5, 1-10,
  binary…) is whatever the prompt asks for, but the dashboard's average is hard-labelled `/ 5`.
