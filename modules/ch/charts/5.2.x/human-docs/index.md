# Charts — manual setup guide

**Charts** (`charts`) is a charting framework for Drupal. It turns your site's
data into interactive charts — line, column, bar, pie, donut, scatter, gauge,
and more — without you writing any JavaScript. You can render a View as a chart,
place a chart in a block, store chart data on a content type as a field, or build
one in code from a render array.

The clever part of Charts is that it is *library‑agnostic*. The core module
defines everything about a chart except how to draw it; the actual drawing is
done by one of several popular JavaScript charting libraries — Highcharts,
Chart.js, Google Charts, Billboard.js, or C3.js. You enable a small submodule for
the library you want, pick it as your default, and every chart on the site uses
it. Switching libraries later is a one‑setting change.

Site‑wide defaults — the default library and chart type, a 25‑color series
palette, legends, tooltips, dimensions, gauge thresholds, and whether library
code loads from a CDN or a local copy — live on a central settings form. Each
View, block, or field can then override those defaults for its own chart.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Important:** the core Charts module ships **no** charting library on its own.
> You must enable at least one library submodule (for example `charts_highcharts`)
> before any chart will render. See [Installation](installation/index.md).

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose a charting‑library submodule.
2. [Configuration](configuration/index.md) — the global settings form plus the
   Views style and the chart field, option by option.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Chart
configuration** (`/admin/config/content/charts`), with an accompanying
**Advanced** tab for debug and CDN/local library options. Access is controlled by
the core **Administer site configuration** permission.

## How to use it

There are three common ways to produce a chart:

1. **From a View** — set a View's **Format** to **Chart**, then choose which field
   is the label and which are the data series.
2. **In a block** — enable the **Charts Blocks** submodule and place a chart
   block on a page without needing a View.
3. **On an entity** — add a **Chart** (`chart_config`) field to a content type so
   editors can enter chart data directly on content.

See [Configuration](configuration/index.md) for the settings behind each of these.
