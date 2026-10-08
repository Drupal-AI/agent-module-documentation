# PanKM Chart — manual setup guide

**PanKM Chart** (`pankm_chart`) is a charting module that draws charts from an
uploaded **CSV file**. It was written for the PanKM knowledge-management context,
but the mechanism is general: install the module and it automatically creates a
dedicated content type and a sample node; you then create nodes, upload a CSV in
the same shape as the sample, pick a chart type, and the chart renders
automatically. Supported chart types are **bar, line, multi-line, and pie**.

Each chart node also offers editor conveniences — **Copy link**, **Print the
page**, and an **embed code** — so a chart can be reused inside other articles and
blogs. The maximum CSV size is **100 rows**. The module supports Drupal 10 and 11.

One important setup detail: PanKM Chart depends on three **external JavaScript
libraries that you must download yourself** into the module's folder before charts
will render (see Installation). It is a display/visualization module with no
content-access role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, download the three
   required JavaScript libraries, and enable it.

There is **no central settings form** — the chart type and data are chosen
per node when you create a chart, as described in "How to use it" below.

## How to use it

1. After installing (see [Installation](installation/index.md)), visit the sample
   node the module created, listed under **Content** (`/admin/content`), to
   confirm charts render.
2. Create a new chart at **Content → Add content → PanKM Chart**
   (`/node/add/pankm_chart`).
3. Upload a **CSV file** in the same format as the bundled `sample.csv` (a data
   file is required; keep it to **100 rows or fewer**).
4. Select the **chart type** you want — bar, line, multi-line, or pie. The chart
   plots automatically from your data.
5. Use the **Copy link**, **Print**, and **embed code** options on the chart to
   reuse it in other articles and blogs.
