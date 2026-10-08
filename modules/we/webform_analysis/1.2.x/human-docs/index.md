# Webform Analysis — manual setup guide

**Webform Analysis** (`webform_analysis`) adds a per‑webform **Analysis** tab that
turns your submission data into quick, visual statistics — counts, tables, and
Google charts (pie or column) — for the elements you choose. It is the fast way to
answer "how did people respond?" without exporting submissions to a spreadsheet.

You pick which elements of a webform to analyze and how to display each one. For a
"How did you hear about us?" select you might show a pie chart of the options; for
a satisfaction rating, a column chart; for anything else, a plain table of value
counts. It understands the common element types, showing Yes/No for checkboxes and
the referenced labels for entity‑reference and taxonomy elements. You can also
bound the analysis to a **date range** (to report on a single campaign) and choose
whether to **include draft submissions**.

The results appear on a read‑only **Analysis** tab alongside the webform's other
results screens — perfect for giving editors and stakeholders an at‑a‑glance
summary. And a bundled **block** lets you embed any one component's chart or table
on any page, such as a dashboard.

Webform Analysis requires the contributed **Webform** module. Access to the
Analysis tab is governed by Webform's own submission‑results permissions, so it
does not add a permission of its own. Its charts are drawn with Google Charts. A
submodule, **Webform Node Analysis** (`webform_node_analysis`), extends the same
analysis to webforms attached to nodes through a webform field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including where settings are
stored and the analysis handler class — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and enable the node‑analysis submodule if you need it.
2. [Configuration](configuration/index.md) — the Analysis tab, field by field:
   choosing components, chart type, date range, and drafts.

## Where it lives in the admin menu

There is no global settings page. Analysis is configured per webform on its own
**Analysis** tab, at **Structure → Webforms → (your webform) → Results →
Analysis** (`/admin/structure/webform/manage/{webform}/results/analysis`).

## How to use it

Open a webform's **Analysis** tab, choose which elements to analyze and a chart
type for the display, optionally set a date range and whether to include drafts,
and save. The tab then shows the statistics. To place a chart elsewhere, add the
Webform Analysis block to a region and point it at the component you want. See
[Configuration](configuration/index.md) for the details.
