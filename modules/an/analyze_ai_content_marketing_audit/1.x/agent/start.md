<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze AI Content Marketing Audit (analyze_ai_content_marketing_audit) — agent index

An **Analyze** plugin that scores content entities against configurable **marketing factors** using
the site's default **AI chat provider**. Package `Analyze`. Core `^10.2 || ^11`, GPL-2.0-or-later,
version 1.3.1. Depends on `views`, **`analyze` (>=1.3.0)**, **`views_color_scales` (>=1.1.0)**, and
**`ai`**. Configure at `analyze_ai_content_marketing_audit.settings`
(`/admin/config/analyze/content-marketing-audit`). No new permissions — everything reuses Analyze's
**`administer analyze`**.

## What it provides

- **Two Analyze plugins** (`src/Plugin/Analyze/`):
  - `AIContentMarketingAuditAnalyzer` (id `analyze_ai_content_marketing_audit_analyzer`) — the real
    one; implements `BatchableAnalyzerInterface`. Renders the entity, sends plain text to the AI
    chat provider, parses a JSON score object, caches results.
  - `ContentMarketingAuditAnalyzer` (id `analyze_content_marketing_audit_analyzer`) — a non-AI
    placeholder that only prints status.
- **Storage service** `analyze_ai_content_marketing_audit.storage` →
  `ContentMarketingAuditStorageService` (`src/Service/`): CRUD for factors + scores over two custom
  tables, with content-hash / config-hash cache keying.
- **Two custom DB tables** (`.install`): `..._factors` (factor definitions) and `..._results`
  (per-entity/factor/langcode scores).
- **Two Views field handlers** (`src/Plugin/views/field/`): `content_marketing_audit_score`
  (`ContentMarketingAuditScore`) and `content_marketing_audit_classification`
  (`ContentMarketingAuditClassification`); Views data + a bundled report View
  (`view.ai_content_marketing_audit_results.page_1` at `/admin/reports/content-marketing-audit`).
- **Four forms** (`src/Form/`): settings/factor-list, add, edit, delete factor — all routes gated by
  `administer analyze`.
- **Hooks** (`.module`): `hook_views_color_scale_popover_alter`, `hook_views_pre_view` (adds a
  Configure-settings button to the report), `hook_help`.

## Solution docs

- **Plugins — the AI analyzer, prompts, scoring, report rendering** → [plugins/analyzers.md](plugins/analyzers.md)
- **Factors — settings routes, forms, config schema, install defaults** → [config/factors.md](config/factors.md)
- **Storage, tables, Views report & field handlers** → [api/storage-and-views.md](api/storage-and-views.md)

## Operating notes

- Requires a configured AI **chat** provider (`/admin/config/ai/providers`); with none, the Analyze
  tab shows a "no chat AI provider" status instead of scores.
- Enable per content type at the Analyze settings (`analyze.analyze_settings`); factors are managed
  at this module's own settings page.
- Analysis is on-demand when the Analyze tab is viewed (or via batch), then cached until the content
  or factor config changes.
