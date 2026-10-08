<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, storage, queue & node integration

## Services

| Service id | Class | Role |
|---|---|---|
| `ai_seo.service` | `AiSeoAnalyzer` | runs analysis: `analyzeEntity($report_type, $entity_type_id, $entity_id, $revision_id, $langcode?, $langcode2?, $options)` — renders the entity, sends prompt+HTML to the AI provider, saves the result |
| `ai_seo.report_service` | `ReportService` | reads/formats stored reports, e.g. `getFormattedReports($node_id)` |
| `ai_seo.render_entity_html` | `RenderEntityHtmlService` | renders an entity to HTML as anonymous for a clean audit surface |

## Storage: the `ai_seo` DB table

Reports are **not** entities; they live in a custom table `ai_seo` (see `ai_seo.install`).
Columns: `rid` (PK), `entity_type_id`, `entity_id`, `revision_id`, `langcode`, `url`, `uid`,
`report` (rendered HTML/markdown), `report_type` (references an `ai_seo_report_type` id,
default `full`), `prompt`, `html` (source HTML analyzed), `timestamp`. Indexed on
`entity_id`, `uid`, `report_type`.

```sql
SELECT rid, entity_id, report_type, FROM_UNIXTIME(timestamp)
FROM ai_seo ORDER BY timestamp DESC;
```

## Background queue

Queue worker plugin `ai_seo_analysis` (`AiSeoAnalysisWorker`, `cron.time = 120`) processes
jobs pushed by the node form's "Queue SEO analysis after saving" checkbox. Each item carries
`report_type`, `entity_type_id`, `entity_id`, `revision_id`, `langcode`, `options`; the worker
calls `AiSeoAnalyzer::analyzeEntity()`. Runs on cron.

```php
\Drupal::queue('ai_seo_analysis')->createItem([
  'report_type' => 'full', 'entity_type_id' => 'node', 'entity_id' => 123,
  'revision_id' => NULL, 'langcode' => 'en',
  'options' => ['request_as_anonymous' => TRUE, 'report_type' => 'full'],
]);
```

## Routes

| Route | Path | Permission |
|---|---|---|
| `ai_seo.settings` | `/admin/config/ai/seo` | `administer ai seo` |
| `entity.node.seo_analyzer` | `/node/{node}/seo` | `view seo reports` |
| `entity.node.view_seo_report` | `/node/{node}/seo/{report_id}` | `view seo reports` |
| `ai_seo.stream_analysis` | `/ai-seo/stream/{node}` | `create seo reports` |
| `ai_seo.stream_draft` | `/ai-seo/stream-draft` | `create seo reports` |
| `ai_seo.stream_field` | `/ai-seo/stream-field` | `create seo reports` |
| `entity.ai_seo_report_type.collection` | `/admin/config/ai/seo/report-types` | `administer ai seo settings` |

## Node integration (hooks in `ai_seo.module`)

- `hook_entity_operation` / `hook_contextual_links_view_alter` add an "Analyze SEO" link to
  every node (needs `view seo reports`).
- `hook_form_node_form_alter` adds the "AI SEO/GEO Analysis" sidebar: view latest report,
  streaming "Analyze draft" of unsaved content, and a "Queue analysis after saving" checkbox.
- `hook_field_widget_single_element_form_alter` adds per-field "SEO/GEO ✦" buttons when
  `ai_seo.settings:enable_field_buttons` is true and the user has `create seo reports`.
