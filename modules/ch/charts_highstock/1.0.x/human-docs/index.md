# Highcharts Stock Charts — manual setup guide

**Highcharts Stock Charts** (`charts_highstock`) adds the Highcharts Stock
(Highstock) library as a rendering option for the
[Charts](https://www.drupal.org/project/charts) module. Highstock is the
time‑series and financial flavour of Highcharts — the one with a range selector,
a navigator strip, candlestick and OHLC chart types — and this module makes it
available anywhere Charts lets you pick a library (a Views chart display, a chart
field formatter, or the Charts configuration).

It is a thin integration layer, not a standalone feature: it registers a
Highstock chart type/plugin, ships a Views include, and stores its settings
through the Charts module's own configuration. There is no admin page of its own.
Because of that it depends on both the base **Charts** module and the
**Charts Highcharts** submodule (`charts_highcharts`), which supply the plumbing
and the underlying Highcharts core.

One thing to know up front: the Highcharts Stock library requires a licence for
commercial use. Purchasing and installing the JavaScript library is the site
owner's responsibility — see the installation guide for where the file goes.
Everything renders client‑side; the module makes no server‑side network calls and
adds no routes, permissions, or anonymous endpoints. Data access follows the
permissions of whatever view or field supplies the chart data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, provide the
   Highstock JavaScript library, and enable the module alongside its Charts
   dependencies.

There is **no configuration page** for this module. Once enabled, "Highstock"
simply appears as a library choice in the Charts settings you already use.

## How to use it

After installing and enabling the module (and providing the Highstock library),
open any place where Charts offers a library — a Views chart display, a chart
field formatter, or the Charts configuration — and choose **Highstock** as the
rendering library. Configure the chart's type and options through the normal
Charts UI.

For Views‑based charts, use the module's **Highstock Value Field**, which pairs a
"timestamp provider" field with a "value provider" field; that combined field is
then what you select as the chart's data provider in the Chart settings. Highstock
is best suited to financial and time‑series datasets where the range selector and
navigator add real value.
