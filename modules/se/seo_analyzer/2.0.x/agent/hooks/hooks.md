<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks, theme hooks and templates

`seo_analyzer.module` implements three hooks. There are no update hooks (no `.install`).

## `seo_analyzer_entity_operation($entity)`

Adds an **SEO Analyzer** operation (weight 100) to the operations list of any non-new `node` and
`canvas_page`, linking to `entity.node.seo_analyzer` / `entity.canvas_page.seo_analyzer`. This is what
surfaces the analyzer alongside Edit/Translate. Pairs with the local-task tabs in
`seo_analyzer.links.task.yml`.

## `seo_analyzer_help($route_name, …)`

Returns a one-line help paragraph on `help.page.seo_analyzer`.

## `seo_analyzer_theme()` — five theme hooks

| Theme hook | Template | Key variables |
| --- | --- | --- |
| `page_seo_analyzer` | `templates/page-seo-analyzer.html.twig` | `search_form`, `keyword_analytics`, `content_analytics`, `general_analytics`, `data`, `bgclasses`, `url`, `page_url`, `keyword` |
| `table_keyword_analytics` | `templates/table-keyword-analytics.html.twig` | `data`, `bgclasses` |
| `table_content_analytics` | `templates/table-content-analytics.html.twig` | `data`, `bgclasses`, `page_url` |
| `table_general_analytics` | `templates/table-general-analytics.html.twig` | `data`, `bgclasses`, `page_url` |
| `page_seo_analyzer_error` | `templates/page-seo-analyzer-error.html.twig` | `message` |

The controller returns `#theme => 'page_seo_analyzer'` whose three analytics slots are themselves
render arrays built by `Analyzer::createKeywordAnalyticsForm()` /
`createContentAnalyticsForm()` / `createGeneralAnalyticsForm()` (each a `details` element wrapping one
of the three `table_*` theme hooks). On a fetch/parse error the controller returns
`#theme => 'page_seo_analyzer_error'` instead.

Each row of the `data` array passed to a `table_*` template is
`{analysis, name, description, value, negative_impact}` (from `Analyzer::formatResults()`).
`bgclasses` maps a `negative_impact` of 0–10 to the row's `bg-success` / `bg-warning` / `bg-danger`
class (defined as `Analyzer::$backgroundClasses`). The value column shows the metric's `value`
(e.g. the meta title/description text, the per-heading lists, the keyword-density tables) and the
`analysis` column shows the advice string for that check.

## Styling / override

- Attach or replace CSS via the `seo_analyzer/styling` library (`css/seo-analyzer.css`), attached in
  every render array the controller returns.
- Override any table by copying its template into your theme (standard Twig theme override); the theme
  hooks and variables above are the contract.
