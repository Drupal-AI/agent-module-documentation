# Highcharts Stock Charts — manual setup guide

**Highcharts Stock Charts** (`charts_highstock`) adds the Highcharts Stock
(Highstock) library to the [Charts](https://www.drupal.org/project/charts)
framework — the time‑series and financial flavour of Highcharts, with a range
selector, candlestick and OHLC chart types, and a navigator strip. Once enabled,
"Highstock" appears as a library choice anywhere Charts is configured: a Views
chart display, a chart field formatter, or a config/render array.

The clever part is that it does **not** ship a separate Highstock build. Instead
it appends the Highcharts *Stock module* (`stock.js`) onto the Highcharts core
that the `charts_highcharts` submodule already loads, so a single Highcharts core
serves both regular `Highcharts.chart()` and stock `Highcharts.stockChart()`
rendering. That means Highcharts and Highstock charts can happily live on the same
page. This 2.0.x branch requires the base **Charts** module version 5.2 or newer
and its **Charts Highcharts** submodule, on Drupal 10.3, 11, or 12.

There is no admin form and no dedicated configuration route — settings live inside
the per‑chart Charts configuration, where the plugin adds one extra option (a
"Range selector zoom" label). The module ships an optional example submodule,
**`charts_highstock_api_example`**, that demonstrates the render‑array API and a
JavaScript override. Everything renders client‑side; the module adds no routes,
permissions, anonymous endpoints, or server‑side network calls.

One thing to know up front: the Highcharts/Highstock library requires a licence
for commercial use, and providing the JavaScript is the site owner's
responsibility. See the installation guide for the three ways to supply it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, supply the
   Highstock `stock.js` library (local file or CDN), and enable the module and its
   Charts dependencies.

There is **no configuration page** for this module — see "How to use it" below for
the per‑chart settings.

## How to use it

After the module is enabled and the library is available, open any place where
Charts offers a library — a Views chart display, a chart field formatter, or the
Charts configuration — and choose **Highstock** as the rendering library. It
supports area, bar, boxplot, bubble, candlestick, column, donut, gauge, heatmap,
line, OHLC, pie, scatter, and spline types.

The one setting the plugin adds over plain Highcharts is the **Range selector
zoom** label (the text on the zoom control, default *Zoom*), configured per chart
alongside the other Charts settings.

For Views‑based charts, use the module's **Highstock Value Field**
(`field_charts_highstock`), which pairs a timestamp‑providing field with a
value‑providing field and emits a `[timestamp, value]` pair; that combined field
is then what you pick as the chart's data provider. Note that the interactive
stock chart (range selector, navigator) only appears when the x‑axis is a
**datetime** axis — category or linear axes fall back to a plain chart so they
don't render as 1970 epoch timestamps.
