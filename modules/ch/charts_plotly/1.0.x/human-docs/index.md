# Charts Plotly — manual setup guide

**Charts Plotly** (`charts_plotly`) adds Plotly.js as a rendering library for the
[Charts](https://www.drupal.org/project/charts) module. Plotly.js is an
open‑source (MIT‑licensed) JavaScript charting library built on D3.js and WebGL,
free to use in commercial applications, offering a wide range of chart types —
area, bar, box plot, bubble, candlestick, column, donut, gauge, heatmap, line,
pie, radar, scatter, and spline.

It is a rendering provider, not a standalone feature. Once enabled and set as your
charting library, the charts you define through Charts (from Views, from fields,
from the Charts Text Filter, from Charts Twig, or via the Charts API) are drawn
with Plotly.js. It depends on the base **Charts** module (version 5.2.1 or newer)
and ships an optional example submodule, **`charts_plotly_api_example`**, that
demonstrates the render‑array API.

Unlike the commercial Highcharts/Kendo add‑ons, Plotly is free — but installing
its JavaScript involves a small amount of Composer setup (the Asset Packagist
repository plus an installer‑paths entry), described in the installation guide.
Charts render client‑side from data supplied by access‑respecting Views or config;
the module has no content or access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — set up Asset Packagist, install the
   module and the Plotly.js library with Composer, and enable everything.

There is **no dedicated configuration page** for this module. You select Plotly as
your default library in the Charts settings (`/admin/config/content/charts`) — see
"How to use it" below.

## Where it lives in the admin menu

Charts Plotly adds no admin page of its own. The Charts library selection lives at
**Configuration → Content authoring → Charts**
(`/admin/config/content/charts`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to `/admin/config/content/charts` and set **Plotly** as your default
   charting library (or choose it per chart).
3. Create your chart in any of the usual ways:
   - Create a View and use the **Chart** format.
   - Add a chart field to an entity type (node, user, etc.).
   - Add a chart in a WYSIWYG field using **Charts Text Filter**.
   - Add a chart in a Twig template using **Charts Twig**.
   - Build a chart programmatically with the Charts API.

If you don't already have data on your site to chart, modules such as Views CSV
Source, Views JSON Source, Views Database Connector, or External Entities can
supply it.
