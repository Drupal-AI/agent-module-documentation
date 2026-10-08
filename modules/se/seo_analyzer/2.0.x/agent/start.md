<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SEO analyzer (seo_analyzer) — agent index

Adds an **"SEO Analyzer"** operation/task link to every saved **node** (and, if the Canvas /
Experience Builder module is present, every **canvas_page**). Opening it runs a battery of on-page
SEO checks and renders a three-section results page (keyword / content / general analytics). The
mechanism is server-side HTTP self-fetch: the controller resolves the entity's own canonical URL,
then `Analyzer` uses a Guzzle wrapper (`HttpClient\Client`) to `GET` that URL, parses the returned
HTML with `DOMDocument` (`Parser`), computes ~20 metrics (`Metric/**`, built through the plain
static `MetricFactory` — not a Drupal plugin type), and themes the numbers into tables. A keyword to
score the page against is taken from the `?keyword=` query parameter (default `keyword`); a small
`KeywordForm` at the top of the page just redirects back to the same route with that query set.

The analysis is not persisted anywhere — there is no config, no database table, no settings form; each
page view re-fetches and re-computes. The whole feature is one controller, one form, five theme hooks,
one permission and two routes; the bulk of the code is a reusable, framework-agnostic analysis library
under `src/` (`Analyzer`, `Page`, `Factor`, `Parser`, `Metric/**`) ported from Grzegorz Karpiak's
`seo-analyzer` PHP project.

- Depends on: nothing (`dependencies` is empty in info.yml). Soft/optional: **Canvas** (Experience
  Builder) — the `entity.canvas_page.seo_analyzer` route and `Drupal\canvas\Entity\Page` type hint are
  only usable when that module is installed; it is **not** declared as a dependency.
- Core: `^11` (Drupal 11 only). Package: `SEO`. PHP `>=8.0` (composer.json).
- **No settings page / no `configure` route.** Ideal ranges, colour thresholds and the two fetched
  filenames (`robots.txt`, `sitemap.xml`) are hard-coded. Provides **one permission**, no config
  schema, no drush, no plugin types, no field widgets/formatters.
- Output is rendered through five theme hooks (templates in `templates/`), styled by one CSS library.

## What you'd do → where

- **Reach / drive the analyzer UI, understand access gating and the `?keyword` flow** →
  [permissions/access.md](permissions/access.md), [forms/keyword-form.md](forms/keyword-form.md)
- **Call the analysis engine from your own code (analyze a URL / file / HTML string), add a metric or
  a custom parser** → [api/analyzer.md](api/analyzer.md)
- **Override the results markup or styling; understand the theme hooks and the operation link** →
  [hooks/hooks.md](hooks/hooks.md)

## Key facts (real machine names)

- Routes: `entity.node.seo_analyzer` (`/node/{node}/seo-analyzer`),
  `entity.canvas_page.seo_analyzer` (`/canvas_page/{canvas_page}/seo-analyzer`) — both
  `_permission: 'access seo analyzer'`, `_admin_route: TRUE`, `_node_operation_route: TRUE`.
- Controller: `Drupal\seo_analyzer\Controller\SeoAnalyzerController` — methods
  `generateAnalyzerPageFromNode(NodeInterface $node)`, `generateAnalyzerPageFromCanvasPage(Page $canvas_page)`.
- Permission: `access seo analyzer` (in `seo_analyzer.permissions.yml`).
- Local tasks (`seo_analyzer.links.task.yml`): `entity.node.seo_analyzer`,
  `entity.canvas_page.seo_analyzer` (base_route = canonical). Operation link added by
  `seo_analyzer_entity_operation()` for `node` and `canvas_page`.
- Form: `Drupal\seo_analyzer\Form\KeywordForm`, form id `seo_analyzer_keyword_form`. Reads/writes the
  `keyword` query parameter.
- Theme hooks (`seo_analyzer_theme()`): `page_seo_analyzer`, `table_keyword_analytics`,
  `table_content_analytics`, `table_general_analytics`, `page_seo_analyzer_error` — templates in
  `templates/`.
- Library: `seo_analyzer/styling` (`css/seo-analyzer.css`).
- Analysis library (no DI, plain `new`): `Drupal\seo_analyzer\Analyzer`, `…\Page`, `…\Factor`,
  `…\Metric\MetricFactory`, `…\Parser\Parser` (`AbstractParser`, `ExampleCustomParser`),
  `…\HttpClient\Client` (Guzzle wrapper, `ClientInterface`).
- Metric ids resolved by `MetricFactory::get('page.<name>' | 'file.<name>', $data)` →
  `Metric\Page\*Metric`, `Metric\File\{Robots,Sitemap}Metric`. Not plugins; no discovery/annotations.
- Stopword lists: `stopwords/en.yml`, `stopwords/nl.yml`, `stopwords/pl.yml` (keyword-density noise words).
- Hooks implemented: `hook_help`, `hook_theme`, `hook_entity_operation`.
