# Kendo UI Charts — manual setup guide

**Kendo UI Charts** (`charts_kendo_ui`) adds Kendo UI as a rendering library for
the [Charts](https://www.drupal.org/project/charts) module. Kendo UI is a
powerful jQuery‑based JavaScript UI library; once this module is enabled and the
library is in place, charts you already define through Charts (from Views or from
fields) can be rendered with the Kendo UI charting engine.

It is a thin backend/integration layer, not a standalone feature. It has no admin
page of its own — Kendo UI is integrated into Charts automatically, so once the
library files are present there is nothing Kendo‑specific to configure. You pick
Kendo UI as the chart library through the normal Charts settings. It depends on
the base **Charts** module.

Two things to know up front. First, **Kendo UI is a commercial library**: you
must buy a licence to use it, though a 30‑day trial is available. Installing the
library files (and pasting your licence) is the site owner's responsibility — see
the installation guide. Second, this release is an early (1.0.0‑alpha1) version.
Charts render on‑page data client‑side; the module has no content or access role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Kendo UI
   library files, and enable the module alongside Charts.

There is **no configuration page** for this module. Kendo UI is integrated into
Charts automatically; you just select it as the library in the Charts settings.

## How to use it

After installing the module and the Kendo UI library, open any place where Charts
offers a library — a Views chart display, a chart field formatter, or the Charts
configuration — and choose **Kendo UI** as the rendering library. All chart type
and styling options come from the Charts module itself. Refer to the Charts
documentation for how to build and configure a chart.
