<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AISentimentsAnalyzer — the AI analyze plugin

File `src/Plugin/Analyze/AISentimentsAnalyzer.php`. `@Analyze(id="analyze_ai_sentiments_analyzer",
label="Sentiments Analysis")`. `final class AISentimentsAnalyzer extends AnalyzePluginBase implements
BatchableAnalyzerInterface`. Registered as an Analyze plugin (discovered by the parent `analyze`
module); no route/service of its own — it is invoked by Analyze's tab/summary and batch runner.

## Dependencies (via `create()`)
`analyze.helper`, `current_user`, `ai.provider` (`AiProviderPluginManager`), `config.factory`,
`entity_type.manager`, `renderer`, `language_manager`, `messenger`, `ai.prompt_json_decode`
(`PromptJsonDecoderInterface`), and `analyze_ai_sentiments.storage`.

## What gets analyzed
`getHtml($entity)` (private): renders the entity in `default` view mode in the entity's active
language via `renderer->renderInIsolation()`, then `strip_tags`, `&nbsp;`→space, whitespace-collapse,
`trim`. Plain text only is sent to the model.

## Which dimensions run
- `getConfiguredSentiments()` → `storage->getAllSentiments()` (config-defined, see
  [config/dimensions.md](../config/dimensions.md)).
- `getEnabledSentiments($entity_type, $bundle)`: returns `[]` unless enabled for the type/bundle
  (`isEnabledForEntityType`). Reads per-bundle toggles from **`analyze.plugin_settings`** at key
  `"{entity_type}.{bundle}.{plugin_id}"`; if no `sentiments` key is stored yet, **all** dimensions are
  enabled by default. Sorted by `weight`.

## The AI call — `analyzeSentiments()`
1. Get plain text (`getHtml`) and the provider (`getAiProvider()`); bail returning `[]` if no provider
   or no default model.
2. Build a prompt (heredoc) listing each enabled dimension as `- label: Score from -1.0 (min_label)
   to +1.0 (max_label), with 0.0 being mid_label`, and a dynamic JSON template `{"id": number, ...}`.
3. `new ChatInput([new ChatMessage('user', $prompt)])`; `$ai_provider->chat($messages,
   $defaults['model_id'])->getNormalized()`.
4. Decode with `promptJsonDecoder->decode($message)`; if not an array → `[]`.
5. For each enabled dimension present in the decode, cast `(float)` and **clamp to -1.0…+1.0**
   (`max(-1.0, min(1.0, $score))`). Return `id => score`.
`AiRateLimitException` is re-thrown; any other `\Exception` returns `[]` (analysis "failed" state).

### Provider selection — `getAiProvider()` / `getDefaultModel()`
Uses the **default chat provider/model** from `ai.provider`
(`getDefaultProviderForOperationType('chat')`); returns NULL if none configured. Sets
`temperature => 0.2` when `setConfiguration()` exists. All transport (HTTP/TLS, API key) is handled by
the `ai` provider plugin — this module makes no direct HTTP calls.

## Rendering
- `renderSummary($entity)`: shows the first enabled dimension as one `analyze_gauge`; converts score
  `s` to gauge value `(s+1)/2`, display `sprintf('%+.1f', s)`. Falls back to an `analyze_table` status
  row when not enabled / no dimensions / no provider / no content (with contextual links, e.g.
  `ai.settings_form`, `analyze.analyze_settings`, `analyze_ai_sentiments.settings`).
- `renderFullReport($entity)`: one `analyze_gauge` per enabled dimension (container class
  `analyze-sentiments-report`); per-dimension failure rows for dimensions with no score.
- Both call `storage->getScores()` first; on a cache miss they run `analyzeSentiments()` and
  `storage->saveScores()`.

## Batch interface (`BatchableAnalyzerInterface`)
- `processEntity($entity, $force_refresh=FALSE)`: skips if `hasResults()` and not forcing; on force,
  `storage->deleteScores()` first; analyzes and saves; returns whether scores were produced.
- `hasResults($entity)` → non-empty `storage->getScores()`.
- `countAnalyzedEntities($type, $bundle)` → delegates to storage.

## Settings persistence (Analyze framework)
- `getSettings` / `saveSettings`: enabled flag → `analyze.settings` `status[type][bundle][plugin_id]`;
  per-dimension toggles → `analyze.plugin_settings` at `"{type}.{bundle}.{plugin_id}"`.
- `getDefaultSettings` / `getConfigurableSettings`: expose one checkbox per configured dimension,
  default enabled.
