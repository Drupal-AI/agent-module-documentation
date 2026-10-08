<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI webform submission sentiment detection (ai_webform_sentiment) — agent index

Attaches an AI **sentiment score** to Webform submissions. A Webform **handler** queues each
non-draft submission; on **cron** a queue worker sends the submission's data to an LLM (via the
**AI module** chat operation), casts the reply to an **integer**, and stores it in the
`ai_webform_sentiment` DB table. A per-webform **"Sentiment"** results tab charts it with Chart.js.
Package `AI`. Experimental. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

Depends on **`ai`** (LLM provider abstraction), **`webform`** (`^6.2`), and **`chartjs_api`**
(Chart.js library for the dashboard).

- **The handler, queue, processor, prompt, DB table and Drush command (the analysis pipeline)** →
  [plugins/sentiment-handler.md](plugins/sentiment-handler.md)
- **Routes, permissions, the results dashboard/charts, and the settings form** →
  [config/dashboard-and-settings.md](config/dashboard-and-settings.md)

## What it actually provides (from source)

- **Webform handler** `SentimentAnalysisWebformHandler` (id **`sentiment_analysis`**, category *AI*,
  cardinality UNLIMITED) in `src/Plugin/WebformHandler/`. `postSave()` enqueues non-draft
  submissions into queue **`analyze_sentiment`**. Config: `prompt` (with `[submission]`
  placeholder) and `llm_model`.
- **Queue worker** `SentimentAnalysisQueueWorker` (id **`analyze_sentiment`**, `cron` time 60s) in
  `src/Plugin/QueueWorker/` — delegates to the processor service.
- **Service** `ai_webform_sentiment.processor` → `SentimentProcessor` (`src/SentimentProcessor.php`);
  args `@queue @entity_type.manager @ai.provider @database @datetime.time`. `processItem()` builds
  the prompt, calls `$provider->chat()`, `(int)` casts the text, inserts into `ai_webform_sentiment`.
- **Controller** `SentimentDashboardController::dashboard()` (`src/Controller/`) — renders the
  results-tab charts via `#theme` `ai_webform_sentiment_dashboard`.
- **Settings form** `SettingsForm` (`src/Form/`) editing config object `ai_webform_sentiment.settings`
  (currently a near-empty placeholder form; no schema shipped).
- **Drush** `SentimentCommands::processQueue()` — `ai_webform_sentiment:process-queue` (alias `aisq`).
- **hook_cron** calls `processor->processQueue()`; **hook_theme** registers the dashboard template;
  **hook_schema** (`.install`) creates the `ai_webform_sentiment` table.
- **Routes**: `ai_webform_sentiment.dashboard` (perm *access webform results*),
  `ai_webform_sentiment.settings_form` (perm *administer ai webform sentiment*).
- **Permission**: `administer ai webform sentiment` (restrict access). **No config schema**, no
  config/install, no submodules, no new plugin types.
