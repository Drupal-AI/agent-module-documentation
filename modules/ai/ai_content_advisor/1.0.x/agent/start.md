<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Advisor (ai_content_advisor) — agent index

Renders a node's HTML, sends it to a configured **drupal/ai** chat model with an analysis prompt, and
stores an AI **report of recommendations** (SEO/readability/editorial). Package `AI`. Version 1.0.0
(dir `1.0.x`). Core `^10.3 || ^11`. Depends on `ai:ai` and (Composer) `league/commonmark ^2.5`.
Configure route: **`ai_content_advisor.settings`**. License GPL-2.0-or-later.

- **Settings, report-type config entities, routes & permissions** →
  [config/settings.md](config/settings.md)
- **The analyzer/render services, the node form, the block, and the report store** →
  [api/analyzer.md](api/analyzer.md)

## What it provides (from source)

- **Config entity type** `ai_content_advisor_report_type` (`src/Entity/AiContentAdvisorReportType.php`)
  — a named prompt template; config-installed defaults `full`, `topic_authority`, `natural_language`,
  `link_analysis`, `headings_and_structure`. List builder + add/edit/delete forms.
- **Services** (`ai_content_advisor.services.yml`): `ai_content_advisor.service`
  (`AiContentAdvisorAnalyzer`) and `ai_content_advisor.render_entity_html` (`RenderEntityHtmlService`).
- **Forms**: `ConfigurationForm` (settings), `AnalyzeNodeForm` (per-node report UI),
  `AiContentAdvisorReportTypeForm` (report-type CRUD).
- **Controller** `AnalyzeContentController::printReport` — renders `AnalyzeNodeForm` at the node tab.
- **Block** `ai_content_advisor_advanced_report_block` (node-context) that embeds the form.
- **DB table** `ai_content_advisor` (`.install`) storing each report row.
- **Hooks** (`.module`): `hook_help`, `hook_contextual_links_view_alter`, `hook_entity_operation`
  add the "Analyze Content with AI" link (all gated by `view ai content advisor reports`).

## Routes & permissions

- `ai_content_advisor.settings` — `/admin/config/ai/content-advisor` — perm `administer ai content advisor`.
- `entity.ai_content_advisor_report_type.*` — `/admin/config/ai-content-advisor/report-types[...]` —
  perm `administer ai content advisor report types`.
- `entity.node.content_analyzer` — `/node/{node}/content-advisor` — perm
  `view ai content advisor reports` (node upcast as `entity:node`); creating a new report additionally
  requires `create ai content advisor reports`.

Permissions (`ai_content_advisor.permissions.yml`): `view ai content advisor reports`,
`create ai content advisor reports`, `administer ai content advisor`,
`administer ai content advisor report types`.

## Config objects

- `ai_content_advisor.configuration` — `provider_and_model` (`<provider>__<model>`) and
  `custom_system_prompt` (set by `ConfigurationForm`; no config/install file — created on first save).
- `ai_content_advisor.report_type.*` — the report-type config entities
  (schema `config/schema/ai_content_advisor_report_type.schema.yml`).

## Flow (short)

`AnalyzeNodeForm` → `AiContentAdvisorAnalyzer::analyzeEntity()` →
`RenderEntityHtmlService::renderHtml()` (sub-request render, anonymous by default) →
`parseHtml()`/`minifyText()` (token trimming) → drupal/ai `chat()` → CommonMark markdown→HTML →
`saveReport()` into the `ai_content_advisor` table. Details in
[api/analyzer.md](api/analyzer.md).
