<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze AI Brand Voice (analyze_ai_brand_voice) — agent index

An **Analyze-framework plugin** that scores how well a content entity matches an admin-written
**brand voice guideline**, from **-1.0 (off-brand) to +1.0 (on-brand)**, using a chat provider from
the **AI** module. Package `Analyze`. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.3.1.

Depends on three contrib modules (info.yml): **`analyze`** (>=1.3.0), **`ai`**,
**`views_color_scales`** (>=1.1.0). It provides **no permissions, no Drush commands, no plugin
types** of its own — batch runs and permissions come from the base Analyze module.

- **Settings form, config object + schema, routes, the report View** →
  [config/settings.md](config/settings.md)
- **The analyzer plugin, storage service, results table, hooks** →
  [plugins/analyzer.md](plugins/analyzer.md)

## What it actually provides

- **One Analyze plugin** — `AIBrandVoiceAnalyzer` (id **`analyze_ai_brand_voice_analyzer`**, label
  *"AI Brand Voice Analysis"*), `src/Plugin/Analyze/AIBrandVoiceAnalyzer.php`, extends
  `Drupal\analyze\AnalyzePluginBase` and implements `BatchableAnalyzerInterface`.
- **One service** — `analyze_ai_brand_voice.storage` →
  `BrandVoiceStorageService` (`src/Service/BrandVoiceStorageService.php`), caches/reads scores.
- **One config form** — `BrandVoiceSettingsForm` at route
  **`analyze_ai_brand_voice.settings`** → `/admin/config/analyze/brand-voice`
  (permission **`administer analyze`**).
- **One config object** — `analyze_ai_brand_voice.settings` (single key `brand_voice`), schema in
  `config/schema/`, default in `config/install/`.
- **One database table** — `analyze_ai_brand_voice_results` (`hook_schema` in `.install`), with
  Views data (`.views.inc`).
- **One bundled View** — `ai_brand_voice_analysis`, page display at
  **`/admin/reports/brand-voice-analysis`** (permission **`view analyze results`**).
- **One alter hook** — `hook_ai_brand_voice_alter(string &$brand_voice)` (`.api.php`).

## Mechanism (from source)

- The Analyze framework calls `renderSummary($entity)`. It reads a cached score
  (`storage->getScore`); on a miss it calls `analyzeAiBrandVoice($entity)`.
- `analyzeAiBrandVoice()` renders the entity to plain text (`getHtml()` → view builder +
  `renderInIsolation` + `strip_tags`), reads the guideline string (`getBrandVoice()` from
  `analyze_ai_brand_voice.settings`), builds one `ChatMessage`/`ChatInput`, and calls
  `ai.provider`'s default **chat** model (temperature 0.2). The reply is JSON-decoded
  (`ai.prompt_json_decode`) and the `score` clamped to `[-1.0, 1.0]`.
- The score renders as `#theme => 'analyze_gauge'` (value mapped to 0..1); no AI text is echoed to
  the page. Scores are cached in `analyze_ai_brand_voice_results` keyed by SHA-256 content hash +
  MD5 config hash; `hook_entity_update`/`hook_entity_delete` and a guidelines change invalidate them.

See the two solution docs above for exact keys, routes and operating steps.
