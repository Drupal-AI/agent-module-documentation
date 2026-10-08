# CSV Field — manual setup guide

**CSV Field** (`csv_field`) adds a field type for storing **CSV (comma‑separated)
data** and a formatter that renders it as an **HTML table** on display. Editors
paste or upload CSV content, and the field shows a tidy tabular view — handy for
simple data tables such as price lists, schedules, or specifications that are far
easier to maintain as CSV than as a full paragraph or entity structure.

The default formatter offers two rendering choices. It can display the table using
the **DataTables** plugin (sortable, searchable tables), or it can **render the
CSV as a table on the client**, which parses the data in the browser with the
**PapaParse** JavaScript library — reducing bandwidth by not sending the full table
HTML over the network.

It depends on core's **File** module and the **PapaParse** asset library, and
supports Drupal 9.3 through 11. It is a content‑display/field module with no
access‑control role: the rendered table is derived from authored field data and
goes through Drupal's normal render/Twig layer, so the usual text‑escaping
expectations apply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the PapaParse
   library with Composer, and enable it.

There is **no module settings page** — you add the field and pick its formatter
options on the entity display, as described in "How to use it" below.

## Where it lives in the admin menu

CSV Field adds no admin settings page. You use it through the standard Field UI at
**Structure → Content types → *(type)* → Manage fields** and the matching **Manage
display** tab, where the CSV formatter options live.

## How to use it

1. Go to **Structure → Content types → *(type)* → Manage fields** and click **Add
   field**.
2. Choose the **CSV** field type, give it a label, and save.
3. When editing content, paste or upload your CSV data into the field.
4. On **Manage display**, choose the CSV formatter and pick how to render it:
   - **DataTables** — a sortable, searchable table, or
   - **Render CSV as table on the client** — parses the CSV in the browser with
     PapaParse to save bandwidth.
5. View the content to confirm the table renders as you expect.
