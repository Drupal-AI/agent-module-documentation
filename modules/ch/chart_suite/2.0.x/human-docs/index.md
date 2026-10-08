# Chart Suite — manual setup guide

**Chart Suite** (`chart_suite`) turns uploaded data files into interactive charts.
It adds **file‑field formatters** that read the content of a file attached to an
entity and render it as a visualization — line and area plots, scatter plots, bar
and pie charts, and tree diagrams. It understands a range of well‑known text
formats: comma‑separated values (CSV), tab‑separated values (TSV), HTML tables,
and JSON tables, trees, and graphs in common array and object schemas. It was
built by the San Diego Supercomputer Center (SDSC) and is well suited to
scientific and data‑portal sites that present datasets.

The way you use it is to change a file field's display formatter to a Chart Suite
formatter. From then on, whenever someone views a page containing that field,
Chart Suite parses the uploaded file and draws the appropriate interactive chart
automatically. It can also be configured for use with the FolderShare module.

Two practical notes. First, the module bundles a copy of SDSC's Structured Data
parsing library (in its `libraries`/`src/SDSC` folder) — file parsing happens
server‑side on files you've already uploaded, so there are no external data
fetches from user‑supplied URLs. Second, the **charts are drawn with Google
Charts**, whose JavaScript is served from Google and loads further libraries on
demand; because of how Google Charts is structured and its terms of service,
those files **cannot be served locally**. If your site must avoid third‑party
script/egress to Google, factor that in before choosing this module. This version
targets **Drupal 9 and 10** (`^9 || ^10`) and needs **PHP 8**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

The charts are set up on a **file field's display**, not on a central settings
form — see "How to use it" below. (There is a minor admin route at
`/admin/config/media/chart_suite`, but it is gated by a non‑standard `admin`
permission, so in practice only user 1 or a user explicitly granted that
permission can reach it; the normal workflow does not require it.)

## Where it lives in the admin menu

Chart Suite adds no everyday settings page. You use it entirely from **Structure
→ Content types → *(your type)* → Manage display**, where you switch a file
field's formatter to a Chart Suite formatter.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create (or pick) a content type and add a **file field**, allowing the data
   formats you want to chart — for example `csv`, `tsv`, `htm`, `html`, `json`.
3. Go to that content type's **Manage display** tab and change the file field's
   formatter from the generic file formatter to a **Chart Suite** formatter.
   Configure the formatter's options as needed.
4. Add content of that type and upload a supported data file.
5. View the entity. Chart Suite parses the file and renders an interactive chart
   (using jQuery UI dialogs/menus for interaction). Access to the charted data
   follows the normal access of the host entity and file.
