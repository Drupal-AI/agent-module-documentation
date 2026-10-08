<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze plugins

Two `@Analyze` plugins in `src/Plugin/Analyze/`, both extending `Drupal\analyze\AnalyzePluginBase`.
They render on an entity's **Analyze** tab (provided by the parent `analyze` module).

## `ContentMarketingAuditAnalyzer` (id `analyze_content_marketing_audit_analyzer`)

Non-AI placeholder. Only `renderSummary()` is meaningful: it checks that the analyzer is enabled
for the entity's bundle in `analyze.settings` `status`, that at least one factor is enabled, then
prints "Basic content marketing audit functionality. Consider using the AI-powered version…". No
scoring, no storage writes. Injects `messenger` and `analyze_ai_content_marketing_audit.storage`.

## `AIContentMarketingAuditAnalyzer` (id `analyze_ai_content_marketing_audit_analyzer`)

The real analyzer. `final`, implements `Drupal\analyze\BatchableAnalyzerInterface`. Injects
`ai.provider` (`AiProviderPluginManager`), `config.factory`, `entity_type.manager`, `renderer`,
`language_manager`, `messenger`, `ai.prompt_json_decode` (`PromptJsonDecoderInterface`), and the
storage service.

### Batch / entrypoints

- `processEntity(EntityInterface $entity, bool $force_refresh = FALSE): bool` — the batch entry.
  Skips if `hasResults()` and not forcing; on force, `storage->deleteScores($entity)` first; then
  `analyzeContentMarketingAudit()` and `saveScores()`. Returns TRUE if scores were produced.
- `hasResults()` → `!empty(storage->getScores($entity))`.
- `countAnalyzedEntities($entity_type_id, $bundle)` → delegates to storage.
- `renderSummary()` / `renderFullReport()` — lazy: try cached scores via `getStoredScores()`,
  else run `analyzeContentMarketingAudit()` and save. Both first guard on the analyzer being enabled
  for the bundle and on there being enabled factors, otherwise return a status table with a
  contextual admin link.

### How content is gathered — `getHtml()`

Builds the entity's **default** view mode in the current language
(`entityTypeManager->getViewBuilder(...)->view()`), renders it with
`renderer->renderInIsolation()`, then `strip_tags()`, `&nbsp;`→space, collapse whitespace, trim.
Only plain text is sent to the model. Empty text → "no text available" status, no AI call.

### The AI calls

`analyzeContentMarketingAudit()` splits enabled factors into **quantitative** and **qualitative**
and calls `analyzeQuantitativeFactors()` / `analyzeQualitativeFactors()`.

- Provider resolution: `getAiProvider()` requires
  `aiProvider->hasProvidersForOperationType('chat', TRUE)` and a default chat provider
  (`getDefaultModel()` → `getDefaultProviderForOperationType('chat')`, needs both `provider_id` and
  `model_id`). The instance is created via `createInstance()` and, if supported,
  `setConfiguration(['temperature' => 0.2])` for consistency. All network/TLS handling lives inside
  the `ai` provider plugin — this module never touches HTTP directly.
- Prompt: a heredoc with `<task>`, `<content>`, `<factors>` (each `factor_id: description`, plus
  `(Options: …)` for qualitative), `<instructions>`, and `<output_format>` giving a JSON template.
  Sent as a single `ChatMessage('user', $prompt)` in a `ChatInput`, then
  `->chat($messages, $model_id)->getNormalized()`.
- Parsing: `promptJsonDecoder->decode($message)`; non-array → `[]`.
- **Validation is strict.** Quantitative: keep only keys present in the factor set where the value
  `is_numeric`, then clamp `max(-1.0, min(1.0, (float) $value))`. Qualitative: keep only values that
  are `in_array($value, $options, TRUE)` — any model output outside the configured option list is
  dropped. So stored/rendered values are always module-controlled numbers or known option strings,
  never free-form model text.
- Errors: `AiRateLimitException` is re-thrown (so batch can back off); any other `\Exception` is
  caught, surfaced via `messenger->addError()`, and returns `[]`.

### Storage of results — `saveScores()`

Qualitative classifications are converted to a numeric via `convertQualitativeToNumeric()`
(index of the option, mapped onto -1.0..1.0); quantitative saved as float. Everything lives in the
`..._results` table as a `float` score. On read, `convertNumericToQualitative()` maps the number
back to the nearest option label.

### Rendering

- `renderSummary()` shows the **first** enabled factor only: a `#theme => analyze_gauge`
  (value `($score+1)/2`, display `sprintf('%+.1f', $score)`) for quantitative, or an
  `#theme => analyze_table` classification row for qualitative.
- `renderFullReport()` groups qualitative factors into one "Content Classifications" table and
  renders each quantitative factor as its own gauge; factors with no score show an "AI analysis
  failed" row. All output goes through Drupal render arrays (`analyze_gauge`, `analyze_table`) — no
  raw markup.
- `hook_views_color_scale_popover_alter()` (in `.module`) reuses the `analyze_gauge` theme for the
  Views color-scale popover on the report table.
