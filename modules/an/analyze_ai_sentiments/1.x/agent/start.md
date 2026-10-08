<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze AI Sentiments (analyze_ai_sentiments) — agent index

An **Analyze** plugin that scores content entities on configurable **sentiment dimensions** using
the site's default **AI chat provider**. Package `Analyze`. Core `^10.2 || ^11`, GPL-2.0-or-later,
version 1.3.1. Depends on **`analyze` (>=1.3.0)**, **`views_color_scales` (>=1.1.0)**, and **`ai`**.
Configure at `analyze_ai_sentiments.settings` (`/admin/config/analyze/sentiments`). Provides **no new
permissions** — its admin routes reuse core `administer site configuration` and the report reuses
Analyze's `view analyze results`.

## What it provides

- **One Analyze plugin** (`src/Plugin/Analyze/AISentimentsAnalyzer.php`, id
  `analyze_ai_sentiments_analyzer`) implementing `BatchableAnalyzerInterface`. Renders the entity to
  plain text, sends it to the AI chat provider (temperature 0.2), decodes a JSON score object, clamps
  each score to -1.0…+1.0, caches results, and renders `analyze_gauge` / `analyze_table` render
  elements.
- **Storage service** `analyze_ai_sentiments.storage` → `SentimentsStorageService`
  (`src/Service/`): cache read/write of scores, plus CRUD for the sentiment-dimension definitions
  held in config, with content-hash / config-hash cache keying.
- **One custom DB table** (`.install`): `analyze_ai_sentiments_results` (per entity/dimension/langcode
  score, hashes, timestamp).
- **Config-defined dimensions** in `analyze_ai_sentiments.settings` (config, not a DB table); default
  set shipped in `config/install/analyze_ai_sentiments.settings.yml` and `hook_install`.
- **Three forms** (`src/Form/`): settings/dimension-list (`SentimentsSettingsForm`), add
  (`AddSentimentsForm`), delete (`DeleteSentimentsForm`) — all three routes gated by `administer site
  configuration`.
- **Views**: `hook_views_data` in `.views.inc` exposes the results table; a bundled report View
  `view.ai_sentiments_analysis_results` (`page_1`) gated by `view analyze results`.
- **Hooks** (`.module`): `hook_views_color_scale_popover_alter` (gauge popover),
  `hook_views_pre_view` (adds a Configure-settings button to the report), `hook_entity_update` /
  `hook_entity_delete` (cache invalidation).

## Solution docs

- **Plugin — the AI analyzer, prompt, scoring, gauge rendering** → [plugins/analyzer.md](plugins/analyzer.md)
- **Dimensions — settings routes, forms, config schema, install defaults** → [config/dimensions.md](config/dimensions.md)
- **Storage, results table, Views report & hooks** → [api/storage-and-views.md](api/storage-and-views.md)

## Operating notes

- Requires a configured AI **chat** provider (`/admin/config/ai/providers`); with none, the Analyze
  tab shows a "no chat AI provider" status instead of scores.
- Enable per entity type/bundle at the Analyze settings (`analyze.analyze_settings`); dimensions are
  managed at this module's own settings page.
- Analysis is on-demand when the Analyze tab / summary is rendered (or via Analyze batch), then cached
  in `analyze_ai_sentiments_results` until the content or dimension config changes.
