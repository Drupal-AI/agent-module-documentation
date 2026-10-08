# DKAN chart visualization — manual setup guide

**DKAN chart visualization** (`dkan_chart`) adds interactive **Chart.js** charts
and spreadsheet‑style tables to a DKAN open‑data portal. Once installed, dataset
nodes that have a datastore distribution gain a **Visualize** tab where editors
can build and arrange charts — bar, line and more — directly from the data, and
those visualizations can be embedded elsewhere as web components.

It works by consuming DKAN's own datastore query API: a modeller service queries
`/api/1/datastore/query/...` on your site and turns the results into chart
datasets, honoring DKAN's datastore rows limit and this module's number‑format
settings. Charts and the field‑picker controls render client‑side using bundled
copies of Chart.js and Choices.js (no external CDN), and copy‑to‑clipboard support
comes from the **clipboardjs** module.

A bundled submodule, **dkan_tables**, adds equivalent spreadsheet‑style output
(sortable, searchable tables via DataTables by default) on a **Tables** tab. Both
the chart builder and the table builder are gated by their own permissions, so you
choose which roles can create and customize visualizations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   datastore, install the clipboard.js library, and optionally enable the tables
   submodule.
2. [Configuration](configuration/index.md) — permissions, number formatting, the
   datastore rows limit, and the Visualize/Tables workflow.

## Where it lives in the admin menu

DKAN chart adds no single settings page. You work with it in two places: on
individual dataset nodes (the **Visualize** and, with the submodule, **Tables**
local tabs), and on the permissions page at
**`/admin/people/permissions/module/dkan_chart`** where you grant who may build
charts. Number formatting and the datastore rows limit are set in configuration —
see the [Configuration](configuration/index.md) guide.

## How to use it

1. Make sure the dataset has a distribution imported into the DKAN **datastore**
   (charts read from the datastore query API).
2. Open the dataset node and click the **Visualize** tab. If you don't see the tab
   — for example when using the DKAN React front end — go directly to
   `node/{ID}/visualize`.
3. Add one or more visualizations, choose the fields to plot (using the Choices.js
   selectors), and arrange them for the distribution.
4. To reuse a visualization elsewhere, embed it via
   `/node/{node}/embed/visualize`.

If you enabled **dkan_tables**, the same pattern applies for spreadsheet output on
the **Tables** tab (or `node/{ID}/tables`).
