<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AI Brand Voice analyzer, storage and hooks

## The analyzer plugin

`AIBrandVoiceAnalyzer` — `src/Plugin/Analyze/AIBrandVoiceAnalyzer.php`.

```
@Analyze(
  id = "analyze_ai_brand_voice_analyzer",
  label = "AI Brand Voice Analysis",
  description = "Analyzes content for ai brand voice consistency."
)
```

Extends `Drupal\analyze\AnalyzePluginBase`, implements
`Drupal\analyze\BatchableAnalyzerInterface`. Key methods:

- **`renderSummary($entity)`** — entry point the Analyze tab calls. Reads a cached score; on a miss
  runs `analyzeAiBrandVoice()` and saves it. Returns a `#theme => 'analyze_gauge'` render array
  (`#range_min -1`, `#range_max 1`, `#value = ($score + 1) / 2`, `#display_value` like `+0.4`).
  If there is no score and no provider → a "No chat AI provider is configured…" status table (with
  a link to `ai.settings_form` for users with `administer analyze`); if the entity has no text → a
  "no text available" status table.
- **`analyzeAiBrandVoice($entity): ?float`** — the actual analysis:
  1. `getHtml($entity)` — view builder renders the entity (`default` view mode, current UI
     language) via `renderer->renderInIsolation()`, then `strip_tags` + whitespace normalise to
     plain text.
  2. `getAiProvider()` — bails (NULL) unless `ai.provider` has a chat provider and a default
     provider/model exists; sets `temperature => 0.2` when the provider supports
     `setConfiguration`.
  3. `getBrandVoice()` — the `brand_voice` string from `analyze_ai_brand_voice.settings`
     (default `'Clear, approachable, professional, respectful'`).
  4. Builds a single heredoc prompt (`<task>/<brand_voice>/<text>/<instructions>/<output_format>`)
     asking for `{"score": number}` in `[-1.0, +1.0]`, wraps it in one `ChatMessage('user', …)`
     → `ChatInput`, and calls `$ai_provider->chat($messages, $model_id)->getNormalized()`.
  5. Decodes with `ai.prompt_json_decode`; requires a numeric `score`, then
     `max(-1.0, min(1.0, (float) $score))`. Any `\Exception` → NULL (returns no score);
     `AiRateLimitException` is re-thrown so the Analyze batch can back off.
- **`processEntity($entity, $force_refresh)`** — batch hook: skips if a result already exists
  (unless forcing), deletes old scores when forcing, analyses, saves. `hasResults()` /
  `countAnalyzedEntities()` delegate to the storage service.
- **`getFullReportUrl()`** returns NULL (no per-entity full report page).

The analyzer holds no external HTTP itself — all model traffic goes through the AI module's
provider abstraction.

## Storage service

`BrandVoiceStorageService` — `src/Service/BrandVoiceStorageService.php`, service
**`analyze_ai_brand_voice.storage`** (args: `@database`, `@entity_type.manager`, `@renderer`,
`@config.factory`, `@datetime.time`). Talks only to the `analyze_ai_brand_voice_results` table via
the DB API (select / merge / delete — no raw SQL).

- **`getScore($entity)`** — selects `score` matching entity_type + entity_id + langcode **and** the
  current `content_hash` (SHA-256 of the rendered content) **and** `config_hash` (MD5 of the
  guidelines). A stale content/config hash simply misses, forcing re-analysis.
- **`saveScore($entity, $score)`** — clamps to `[-1,1]` and `merge()`s a row keyed by
  entity_type/entity_id/langcode (also stores revision id, both hashes, request timestamp).
- **`deleteScores($entity)`** — removes all rows for an entity.
- **`invalidateConfigCache()`** — deletes every row whose `config_hash != current` (called on
  settings save).
- **`getStatistics()`** / **`countAnalyzedEntities($type, $bundle)`** — aggregate counts; the
  count joins `node_field_data` with a parameterised `:type` bind for node bundles.

## Results table

`analyze_ai_brand_voice_results` (`hook_schema` in `.install`): `id` (serial PK), `entity_type`,
`entity_id`, `entity_revision_id`, `langcode`, `score` (numeric 3,2), `content_hash` (sha256),
`config_hash` (md5), `analyzed_timestamp`. Unique key `entity_lang`
(entity_type + entity_id + langcode); indexes on content_hash, analyzed_timestamp, and
(entity_type, entity_id). `hook_uninstall` empties it.

## Hooks

- **`hook_ai_brand_voice_alter(string &$brand_voice)`** (`analyze_ai_brand_voice.api.php`) — lets
  other modules rewrite the guideline string used for analysis.
- `.module` implements `hook_entity_update` / `hook_entity_delete` (delete cached scores for
  supported entities), `hook_views_pre_view` (adds a settings button to the report),
  `hook_views_color_scale_popover_alter` (gauge popover for the score column).

## Batch operation

No Drush of its own — use the base Analyze module's batch:

```bash
drush analyze:batch --status
drush analyze:batch --analyzers=analyze_ai_brand_voice_analyzer
drush analyze:batch --analyzers=analyze_ai_brand_voice_analyzer --types=node:article --limit=50
drush analyze:batch --analyzers=analyze_ai_brand_voice_analyzer --force   # re-analyse
```

Each uncached analysis is one paid chat-model call; scores are then reused until the content or the
guidelines change.
