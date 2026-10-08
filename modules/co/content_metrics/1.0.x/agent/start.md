<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content metrics (content_metrics) — agent index

**Admin dashboard of charts about content activity** — how many nodes/comments exist and were created
over a series of recent time periods. `info.yml` name **"Content metrics"**, package **Statistics**,
version **1.0.0-beta2**, core `^10 || ^11`. Single hard dependency: **`chartjs_api:chartjs_api`**
(draws the charts). License GPL-2.0-or-later. No permissions.yml, no config schema, no submodules,
no update hooks, no Drush.

## How it works (from source)

- **One route** `content_metrics.dashboard` → `/admin/content-metrics/dashboard`
  (`content_metrics.routing.yml`), permission `access administration pages`.
- **Controller** `ContentMetricsController` (invokable, `__invoke()`) injects the `database` service and
  just renders the form `Drupal\content_metrics\Form\ContentMetricsForm`.
- **Form** `ContentMetricsForm` (`getFormId()` = `content_metrics_form`) sets `method=get` and reads its
  filters directly from `$_GET` — `bundle` (node type, default `any`), `periods` (int, default 12),
  `date_unit` (`months`|`years`, default `years`), `date_field` (default `created`), `status` (default
  `any`, currently unused). `validateForm()` / `submitForm()` are empty stubs. It builds a
  `vertical_tabs` group of six chart panes and attaches library `content_metrics/base`.
- **Six chart builder files** in `charts/` (plain functions, `require_once`'d by the form; not classes/
  services). Each returns a `chartjs_api` render element (`#type => 'chartjs_api'`, `#graph_type => 'bar'`).
  `content_metrics.module` defines the shared `get_chart_default_options()` helper.

## The six charts (each a details pane under the vertical tabs)

1. **Content type counts** (`content_type_counts.php`) — `entityQueryAggregate('node')` grouped by `type`,
   COUNT(nid). Node count per content type.
2. **Content cumulative composition** (`content_cumulative_composition.php`) — per node type, a stacked
   running total of nodes created before each period boundary.
3. **Content over time** (`content_type_periods.php`) — node count per period, optionally filtered by
   `bundle`.
4. **Content mentioning "<keyword>"** (`content_mention_keyword.php`) — `cmk_keyword` + `cmk_type`
   (`nodes` = count of nodes whose `body` LIKEs the keyword, via entityQuery; `instances` = a raw
   `Connection::query()` aggregate over `node__body` summing keyword occurrences). Renders only when a
   keyword is supplied.
5. **Content referencing "<entity>"** (`content_reference.php`) — count of nodes whose chosen entity-
   reference field (`cf_field`) points at an autocompleted `taxonomy_term`/`node` (`cf_refd_entity`),
   per period. Renders only when all filters are set.
6. **Comments over time** (`comment_periods.php`) — comment count per period.

Charts 2–6 loop `periods` buckets sized by `date_unit` off `strtotime()` and output **aggregate counts
only** (labels + a single numeric dataset) — no titles, URLs, or authors. The five entityQuery-based
charts use `->accessCheck(TRUE)`.

## Notes for agents

- **No settings form / no config entity.** README: "This module doesn't have site-specific configuration";
  all tuning is via the on-page exposed filters (query string). `data.json.configure` is null.
- It does **not** use Views — charts are custom form/controller code, not a view.
- The `status` filter select is rendered but has only an `- Any -` option and is not applied
  (`// @todo Use $status`).
- `content_metrics.css` + `content_metrics/base` library provide styling only.
