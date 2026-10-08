<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, hooks & the analysis pipeline

## Routes (`ai_watchdog_analyst.routing.yml`)

| route | path | handler | permission |
|-------|------|---------|------------|
| `ai_watchdog_analyst.suggest_solution` | `/admin/reports/dblog/ai-solution/{wid}` | `AiWatchdogAnalystController::suggestSolution` | `access site reports` |
| `ai_watchdog_analyst.analyze_detail` | `/admin/reports/dblog/event/{wid}/analyze` | `AiWatchdogAnalystController::analyzeDetail` | `access site reports` |
| `ai_watchdog_analyst.settings` | `/admin/config/ai/watchdog-analyst` | `SettingsForm` | `administer site configuration` |

`{wid}` is constrained to `\d+`. Both analysis routes are `_admin_route: TRUE`.

## Where the buttons come from (`.module`)

- `hook_preprocess_views_view_table` (`ai_watchdog_analyst_preprocess_views_view_table`): on the
  `watchdog` view `page` display, adds an **"AI Solution"** column and, for each row whose
  `severity <= 4`, a `🤖 Analyze` link to `suggest_solution` with `use-ajax` + `data-dialog-type=modal`
  (85% width, maxWidth 1400, height 700). Severity is looked up per row with a direct
  `select('watchdog')` query.
- `hook_page_bottom` (`..._page_bottom`): on `dblog.event`, reads the event's severity; for
  `severity <= 4` either renders a stored solution (from tempstore, theme `ai_log_solution_table`)
  or shows an **"🤖 Analyze with AI"** link to `analyze_detail`. The stored solution is deleted
  from tempstore after rendering (one-shot).
- `hook_page_attachments_alter`: attaches `core/drupal.dialog.ajax` + library
  `ai_watchdog_analyst/modal` on `dblog.overview`, and the modal library on `dblog.event`.
- `hook_theme`: declares `ai_log_solution` (modal, template `ai-log-solution.html.twig`) and
  `ai_log_solution_table` (detail page, `ai-log-solution-table.html.twig`).

## Controller (`AiWatchdogAnalystController`)

Both handlers load the row with `database->select('watchdog')->condition('wid', …)->fetchAssoc()`,
then rebuild the human-readable message: `variables` is `unserialize()`d with
`allowed_classes` restricted to `TranslatableMarkup`, `FormattableMarkup`, `Markup` (safe-list),
non-scalar/non-stringable values are dropped, and `formatted_message = strtr(message, variables)`.

- `suggestSolution($wid)` — calls the analyzer, returns a render array themed with
  `ai_log_solution` (shown inside the AJAX modal). On no result: an error `#markup` block.
- `analyzeDetail($wid)` — calls the analyzer, stashes `['solution', 'log_entry', 'timestamp']` into
  private tempstore key `solution_{wid}` (collection `ai_watchdog_analyst`), then
  `redirect('dblog.event', ['event_id' => $wid])` so `hook_page_bottom` renders it.

## Analysis pipeline (`Service\LogAnalyzerService`)

Service id `ai_watchdog_analyst.analyzer`; deps: `@ai.provider`, `@cache.default`,
`@logger.factory`, `@module_handler`, `@config.factory`, `@language_manager`.

`analyzeLogs(array $log_entry): ?string`:

1. Cache key `ai_watchdog_analyst:` . `md5($type . ':' . $message)`; returns cached HTML if present.
2. Reads config: `provider_id` (default `azure`), `model_id`, `system_prompt`.
3. `createInstance($provider_id)` on the AI provider manager.
4. `buildPrompt()` composes a text block: log type, severity name (0–7 map), the
   `formatted_message` (falling back to `message`), `location`, `referer`, and — via
   `detectModuleInfo()` — whether `type` names an installed module and, for
   `modules/contrib/…` paths, a `https://www.drupal.org/project/{type}` line.
5. Model falls back to `getDefaultChatModel()` (`getModelConfig('chat')` → first key) when unset;
   throws if still empty.
6. Appends "IMPORTANT: Respond in {current language name}." to the system prompt.
7. Builds `ChatInput([ChatMessage('system', …), ChatMessage('user', prompt)])` and calls
   `$provider->chat($chat_input, $model_id)`.
8. `extractSolution()` pulls text from the `ChatOutput` (tries `getNormalized()->getText()`,
   `getText()`, `__toString()`, string, `['text']`), then `markdownToHtml()`.
9. Caches the HTML for `time() + 86400` (24h) and returns it. Any exception is logged to channel
   `ai_watchdog_analyst` and the method returns `NULL` (controllers then show an error/redirect).

`markdownToHtml()` uses `League\CommonMark\CommonMarkConverter` with `html_input => 'strip'` and
`allow_unsafe_links => FALSE`, so raw HTML in the model output is stripped rather than emitted.

## Templates

`ai-log-solution.html.twig` (modal) and `ai-log-solution-table.html.twig` (detail page) print the
converted `solution`. The modal template also prints the log's `formatted_message`. Rendering
detail is in the templates themselves; the analyzer produces the HTML string they display.

## Operating quick-reference

- Enable a chat provider in the `ai` module first, then set provider/model at
  [../config/settings.md](../config/settings.md).
- Trigger: click 🤖 Analyze on a Warning-or-worse dblog row, or "Analyze with AI" on an event page.
- Failures ("Could not generate a solution…") are usually a missing/misconfigured provider or model
  — check the `ai_watchdog_analyst` logger channel.
