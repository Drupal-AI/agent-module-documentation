<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage service, tables & Views report

## Service `analyze_ai_content_marketing_audit.storage`

`ContentMarketingAuditStorageService` (`src/Service/`, `final`, `declare(strict_types=1)`), args
`@database`, `@language_manager`, `@config.factory` (services.yml). All DB access uses the query
builder / `merge()` (parameterized) — no string-concatenated SQL.

Factor methods: `getFactors(?$type)`, `getQuantitativeFactors()`, `getQualitativeFactors()`,
`getFactor($id)`, `getFactorOptions($id)` (json-decodes the `options` column for qualitative
factors), `getFactorSelectOptions()`, `saveFactor(...)` (merge on `id`), `deleteFactor($id)`
(deletes factor row + its result rows).

Score methods, keyed by a **content hash** and a **config hash** so cache entries invalidate
automatically:

- `getScores($entity)` / `getScore($entity, $factor_id)` — select where entity_type/id, langcode,
  content_hash, config_hash match (score-per-factor picks newest `analyzed_timestamp`).
- `saveScore($entity, $factor_id, $score)` — `merge()` keyed on
  (entity_type, entity_id, factor_id, langcode).
- `deleteScores($entity)`, `countAnalyzedEntities($entity_type_id, $bundle)` (joins
  `node_field_data` for node bundles).
- `generateContentHash()` — `sha256` over title + `strip_tags(body)` + type + id + langcode
  (temporarily switches config-override language to the entity's).
- `generateConfigHash()` — `md5(serialize(...))` of all factors + `ai.settings` `default_provider`.
  So changing a factor **or** the default AI provider invalidates every cached score.

## Tables (analyze_ai_content_marketing_audit.install)

- **`..._factors`**: `id` (varchar PK), `label`, `description` (text), `type`
  (`quantitative`/`qualitative`), `options` (text, JSON array), `weight` (int), `status` (tinyint).
- **`..._results`**: `id` (serial PK), `entity_type`, `entity_id`, `entity_revision_id`, `langcode`,
  `factor_id`, `score` (float, -1.0…1.0), `content_hash` (sha256), `config_hash` (md5),
  `analyzed_timestamp`. Unique key over (entity_type, entity_id, factor_id, langcode) added in an
  update hook.

## Views integration

- **Views data** (`analyze_ai_content_marketing_audit.views.inc`, `hook_views_data`) exposes the
  `..._results` table as a base table (group "Content Marketing Audit") with fields incl. a computed
  `score_quantitative` and `classification` field, plus a relationship to the analyzed content.
- **Field handlers** (`src/Plugin/views/field/`):
  - `ContentMarketingAuditScore` (`content_marketing_audit_score`) — renders the numeric score only
    for `quantitative` factors, via `number_format()`, with configurable precision/prefix/suffix;
    prefix/suffix are passed through `sanitizeValue(..., 'xss')`.
  - `ContentMarketingAuditClassification` (`content_marketing_audit_classification`) — for
    `qualitative` factors, maps the stored numeric back to an option label via
    `getFactorOptions()`. Returns an empty string for the wrong factor type or missing rows.
- **Report View** ships in `config/install/views.view.ai_content_marketing_audit_results.yml`:
  display `page_1` at **`/admin/reports/content-marketing-audit`**, using
  `views_color_scales`-styled score columns. `hook_views_pre_view()` (`.module`) injects a
  "Configure settings" button (only for users with `administer analyze`).
- `hook_views_color_scale_popover_alter()` swaps the popover for an `analyze_gauge` render element
  (Poor/Average/Excellent) when the base table is this results table.
