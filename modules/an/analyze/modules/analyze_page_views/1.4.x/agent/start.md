<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze Node Statistics (analyze_page_views) — agent index

A submodule of **Analyze** that ships **one** `Plugin/Analyze` plugin: `NodeViews`
(id **`node_views`**, label *"Node Page Views Reports"*). On a node's Analyze tab it renders a
"Node views" table with **Total views** and **Today's count**, read from **core Statistics**'
`node_counter` table. No routes, services or config of its own. Depends on `analyze`, `node`,
`statistics`. Package `Analyze`. Core `^10.3 || ^11`. GPL-2.0-or-later. Version 1.4.x.

- **The plugin, where the counts come from, access, and how to enable it** →
  [plugins/node-views.md](plugins/node-views.md)

## What it actually is

- `src/Plugin/Analyze/NodeViews.php` — `final class NodeViews extends AnalyzePluginBase`.
  Annotation `@Analyze(id = "node_views", label = @Translation("Node Page Views Reports"),
  description = @Translation("Provides details from the Statistics module about nodes for Analyzer."))`.
- Injects (beyond the base's `analyze.helper` / `current_user` / `config.factory`):
  **`statistics.storage.node`** (`Drupal\statistics\NodeStatisticsDatabaseStorage`).
- **Data source = core Statistics, NOT Google Analytics.** `renderSummary()` calls
  `nodeStatisticsDatabaseStorage->fetchView($entity->id())`; if a record exists it reads
  `getTotalCount()` and `getDayCount()`. `fetchView()` queries the core **`node_counter`** table
  (populated by the Statistics module's view-counter, which must be enabled/configured to count
  content views).
- `renderSummary()` returns `['#theme' => 'analyze_table', '#table_title' => 'Node views',
  '#rows' => [Total views, Today's count]]`.
- `isApplicable('node')` only — returns `$entity_type == 'node'`; no-ops for every other entity type.
- `getFullReportUrl()` returns `NULL` → summary-only, no full-report tab/link.
- `access()` **overrides the base** to require the Statistics permission
  **`view post access counter`** (base default returns TRUE). This is an *extra* gate on top of the
  parent Analyze tab's `view analyze reports`.
- No `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, `*.install`, `config/**` — everything
  else (tab, route, per-bundle toggle) comes from the parent Analyze module.
