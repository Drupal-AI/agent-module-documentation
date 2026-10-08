<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Cannibalization Detector (content_cannibalization_detector) — agent index

info.yml name **Content Cannibalization Detector**. An **SEO audit tool** that finds
**keyword cannibalization** — pairs of published nodes whose keyword profiles overlap
enough to compete in search. It extracts keywords per node (TF-based, with bigrams),
compares every node pair by **cosine similarity**, and stores flagged pairs with a
severity level and a recommended fix. It **only reads and reports** — it never edits
content, meta tags, or redirects. All processing is **local PHP**: no external/LLM/SEO
API, no HTTP client, no credentials, no libraries. Package `SEO`. Core
`^10 || ^11 || ^12`. License GPL-2.0-or-later. Installed **1.0.1** (version dir `1.0.x`).

## Dependencies

- Core only: **`node`**, **`path_alias`** (`.info.yml`). No contrib required; **Metatag**
  is optional (enables meta-tag keyword extraction). No PHP library dependencies.

## What it provides (from source)

- **Four routes** (`.routing.yml`):
  - `content_cannibalization_detector.dashboard` → `/admin/reports/cannibalization`
    (`DashboardController::dashboard`) — summary cards + severity-sorted results table.
    Permission **`view cannibalization reports`**.
  - `content_cannibalization_detector.node_detail` →
    `/admin/reports/cannibalization/node/{node}` (`::nodeDetail`, `{node}` = `\d+`) —
    per-node extracted keywords + competing pages. Permission **`view cannibalization reports`**.
  - `content_cannibalization_detector.analyze` → `/admin/reports/cannibalization/analyze`
    (`::runAnalysis`) — runs the analysis, then redirects to the dashboard. Permission
    **`administer content cannibalization detector`** (`restrict access: true`). Plain GET
    link (button in the dashboard template).
  - `content_cannibalization_detector.settings` → `/admin/config/search/cannibalization`
    (`SettingsForm`, a `ConfigFormBase`). Permission **`administer content cannibalization detector`**.
- **Two permissions** (`.permissions.yml`): `administer content cannibalization detector`
  (`restrict access: true`) and `view cannibalization reports`.
- **Two services** (`.services.yml`):
  - `content_cannibalization_detector.keyword_extractor` → `Service\KeywordExtractor`
    (`@config.factory`, `@path_alias.manager`).
  - `content_cannibalization_detector.analyzer` → `Service\CannibalizationAnalyzer`
    (`@entity_type.manager`, the extractor, `@database`, `@config.factory`, `@datetime.time`).
    This is the documented extension point for automating analysis (e.g. from `hook_cron`).
- **Three Drush commands** (`drush.services.yml` → `Commands\CannibalizationCommands`):
  `ccd:analyze` (alias `ccd-analyze`), `ccd:report` (`ccd-report`), `ccd:node <nid>`
  (`ccd-node`). Drush 12+ attribute-style commands.
- **Two theme hooks / Twig templates** (`.module` `hook_theme`, `templates/`):
  `ccd_dashboard` (`ccd-dashboard.html.twig`), `ccd_node_detail` (`ccd-node-detail.html.twig`).
  Plus `hook_help` for `help.page.content_cannibalization_detector`.
- **CSS library** `content_cannibalization_detector/dashboard` (`css/dashboard.css`,
  `.libraries.yml`); attached by both controller pages. No JS.
- **Menu link** (`.links.menu.yml`) and `configure:` link to the settings form.
- **Two DB tables** (`.install` `hook_schema`): `ccd_node_keywords` (PK `nid`+`keyword`;
  columns `score` float, `source` varchar) and `ccd_cannibalization_results` (serial `id`,
  `nid_a`, `nid_b`, `similarity_score`, `shared_keywords` serialized text, `severity`,
  `recommendation`, `analyzed`; unique key on `nid_a`+`nid_b`). `hook_uninstall` deletes
  the settings config.

## How the analysis works (from source)

- **Config** (`config/install/...settings.yml`, schema in `config/schema/`):
  `enabled_content_types` (empty by default → analysis returns `error` until set),
  `similarity_threshold` (default 40, form range 10–95), `max_keywords_per_node` (20),
  `min_keyword_length` (3), source toggles `analyze_title` / `analyze_body` /
  `analyze_path_alias` / `analyze_meta_tags` (all default true), `custom_stop_words`
  (comma-separated), `last_analysis` timestamp.
- **`KeywordExtractor::extractFromNode()`** lowercases text, strips non-alphanumerics, drops
  stop words (a ~130-word built-in English list `STOP_WORDS` + custom), scores single words
  by term frequency and adds **bigrams** (weight 1.5/total). Per-source multipliers: **title
  ×3.0, meta ×2.5, path ×2.0, body ×1.0**; keeps the highest score per keyword, caps at
  `max_keywords_per_node`. Meta text comes from a `field_metatag` JSON field
  (description/keywords/abstract) or `field_meta_description` / `field_seo_description` /
  `field_description`.
- **`CannibalizationAnalyzer::analyze()`** truncates both tables, entity-queries **published**
  (`status = 1`) nodes of the enabled types (in chunks of 50), stores keywords via `merge()`,
  then does an **O(n²) pair comparison** (`compareNodes()` — cosine similarity of the two
  keyword vectors, ×100). Pairs at or above the threshold are inserted with a severity
  (`calculateSeverity`: ≥80 critical, ≥60 high, ≥40 medium, else low) and a recommendation
  (`generateRecommendation`: ≥80 merge, ≥65 redirect, ≥50 canonical, else differentiate).
  Read methods `getResults` / `getResultsForNode` / `getKeywordsForNode` / `getSummary` back
  the dashboard and Drush output. Serialized `shared_keywords` is read back with
  `unserialize(..., ['allowed_classes' => FALSE])`.

## Notes for agents

- **Read-only by design**: the module writes only to its own two tables + the `last_analysis`
  config value; it does not modify nodes. README FAQ confirms this.
- **Quadratic cost**: comparison is every-pair; large sites should scope to one content type
  or run `drush ccd:analyze` off-peak (README troubleshooting).
- **Not SA-covered** (`security_advisory_coverage: not-covered`).
- Sibling human guide: [`../human-docs/index.md`](../human-docs/index.md); one-liner + usage
  bullets in [`../usage.md`](../usage.md).
