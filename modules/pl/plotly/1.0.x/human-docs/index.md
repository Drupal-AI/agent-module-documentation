# Plotly charts views — manual setup guide

**Plotly charts views** (`plotly`) adds a new Views *display style* that renders a
View's results as an interactive [Plotly.js](https://plotly.com/javascript/)
chart instead of a table or list. Point it at a View that returns fields, tell it
which field feeds the x‑axis and which fields become the plotted series, and you
get a zoomable, pannable chart — line, bar, scatter, pie, and many more of
Plotly's chart types.

The headline feature is interactivity: Plotly charts let a visitor zoom and pan
the plot, which ordinary static chart images cannot do. You can also mix chart
types in one View — for example plot a "date" field on the x‑axis, draw an
"income" field as bars, and draw an "expenses" field as a line, all on the same
chart. The View's name and description become the chart's title and legend.

One thing to know up front: this module draws its charts using the **Plotly.js
library loaded from a public CDN** rather than a copy bundled inside the module.
That keeps the module small, but it means the charts depend on that external
script being reachable from the visitor's browser — worth remembering for
offline, air‑gapped, or strict content‑security‑policy sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Views.

There is **no configuration page** for this module — it has no settings form. All
setup happens on an individual View, described in "How to use it" below.

## Where it lives in the admin menu

Plotly charts views adds no admin settings page of its own. You use it entirely
from the **Views UI** at **Structure → Views** (`/admin/structure/views`), where
it appears as a display *format/style* option on any View.

## How to use it

1. Create or edit a View at **Structure → Views**.
2. Set the display **Format** to **Plotly** and choose **Show: Fields** (the
   chart is built from the View's fields).
3. Add the fields you want to plot — typically one field for the x‑axis (labels)
   and one or more numeric fields for the series.
4. Open the Plotly **style settings** and associate each field with a chart
   column: pick the field that supplies the x‑axis, then assign the remaining
   fields to the y‑axis. You can hide any field you don't want drawn.
5. Choose the plot type (line, bar, scatter, pie, and so on). The maintainer
   notes it helps to save and re‑open the settings after picking a type so the
   form redraws with the options that match that chart type.
6. Save the View and view its page or block — the results render as an
   interactive Plotly chart.
