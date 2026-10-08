# Charts Highcharts Caption — manual setup guide

**Charts Highcharts Caption** (`charts_highcharts_caption`) does one small thing:
it lets you add a **caption** to a Highcharts chart. It provides a **Views area
plugin** that you place in a View's footer; whatever you put there is rendered
*inside the chart* as its Highcharts caption, rather than as separate text below
the chart. It's a small display enhancement for the Charts ecosystem, with no
content or access role of its own.

It only applies in a specific situation: the chart must be built by a **View**,
and the View's chart library must be set to **Highcharts**. That means it needs
the Charts module and its Highcharts backend in place.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You add the caption as a
footer area on your chart View, described in "How to use it" below.

## Where it lives in the admin menu

Charts Highcharts Caption adds no admin page. You use it from the **Views UI**
(**Structure → Views**), on a View that renders a Highcharts chart.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Views, Charts,
   and Charts Highcharts must all be installed, and the chart must use the
   Highcharts library.
2. Edit the chart View and, in the **Footer** section, add the caption area
   provided by this module.
3. Enter your caption text. When the chart renders, the text appears inside the
   chart as its Highcharts caption.
