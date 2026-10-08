# Plotly.js — manual setup guide

**Plotly.js** (`plotly_js`) integrates the open‑source
[Plotly.js](https://plotly.com/javascript/) charting library with Drupal by
adding a **new field type**. Add a Plotly.js field to any content type, pick a
graph type, and content authors can build and configure a chart directly on each
piece of content — no JavaScript knowledge required. Everything is done through
the field's settings and display options.

Because the chart is a field, every node (or other fieldable entity) can carry
its own graph with its own data and display settings. Plotly.js supports a very
wide range of graph types — area, bar, box, bubble, candlestick, contour,
heatmap, histogram, line, pie, polar, Sankey, scatter, ternary, treemap, 3D
meshes, and many more — so the same field type covers everything from a simple
bar chart to a scientific or statistical visualization.

The module also ships **Drush commands** for developers, and it draws its charts
using the Plotly.js graphing library. As a content‑display feature it has no
access‑control role of its own: a chart's data comes from the content or
configuration it is attached to and respects that content's normal access rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site‑wide configuration page** for this module — it has no central
settings form. All setup happens per field, described in "How to use it" below.

## Where it lives in the admin menu

Plotly.js adds no admin settings page of its own. You use it from **Structure →
Content types → *(your type)* → Manage fields**, where **Plotly.js** appears as a
field type you can add, and from that content type's **Manage display** and the
content edit form.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields**
   and click **Add field**.
2. Choose the **Plotly.js** field type and give the field a label.
3. In the field settings, pick the **graph type** you want (bar, line, pie,
   scatter, and so on) and configure the display options.
4. Save the field. From now on, when authors add or edit that content type they
   fill in the graph's data and per‑item display settings on the edit form.
5. View the content — the field renders as an interactive Plotly.js chart.
