# Data Visualisation Framework — manual setup guide

**Data Visualisation Framework** (`dvf`, "DVF" for short) turns raw data sources —
CSV files, JSON files, or CKAN datasets — into interactive charts and styled tables,
without custom code. It gives content authors a way to add meaning to otherwise
"boring" data: illustrate trends, show comparisons, and engage readers with proper
visualisations rather than a wall of numbers.

Under the hood DVF is a "middle man" between a data source and a visualisation:
*data source → DVF → chart*. It provides a field type (with its own storage, widget,
and formatter) that you add to any entity. An editor attaches a data source to that
field — either by uploading a file or entering a data URL — and then chooses how the
data should be displayed. It ships industry‑standard JavaScript libraries for the
output: **billboard.js** (built on D3) for charting and **DataTables** for table
styling, with style plugins for bar, line, pie, donut, scatter, bubble, radar,
gauge, spline, and table.

DVF has **no central settings page** — all of the meaningful configuration happens on
the field you add and on each field value an editor enters. What you do install
centrally is DVF plus one or more **source submodules** that determine where data
can come from: **DVF CSV** (`dvf_csv`), **DVF JSON** (`dvf_json`), and **DVF CKAN**
(`dvf_ckan`). The framework is extensible too — developers can add their own data
sources and visualisation styles via plugins.

> **Note:** the *Visualisation (URL)* field fetches its data source from the server
> side when the visualisation renders. (TLS verification is left at Guzzle defaults.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable DVF
   plus the source submodule(s) you need.

There is **no configuration page** for this module — it has no global settings form.
Setup happens on the field you add and on each field value, described in "How to use
it" below.

## Where it lives in the admin menu

DVF adds no top‑level settings page. You work with it entirely through **Field UI** —
adding a DVF field to a content type at **Structure → Content types → *(type)* →
Manage fields**, then entering data sources when you create or edit content. (The
only route DVF registers is a set of help pages.)

## How to use it

1. Enable DVF and the source submodule(s) you need — `dvf_csv`, `dvf_json`, and/or
   `dvf_ckan` (see [Installation](installation/index.md)).
2. On a content type, add a DVF field via **Manage fields**. DVF provides two field
   types: **Visualisation (File)** (`dvf_file`) for an uploaded data file, and
   **Visualisation (URL)** (`dvf_url`) for a remote data URL.
3. When creating or editing content, upload the data file (or enter the data URL)
   and choose a **visualisation style** — bar, line, pie, table, and so on. The
   field's widget exposes per‑visualisation options such as axes, colours, and keys.
4. Save. The visualisation renders at display time like any other formatted field,
   and it works in Views as well.

> **Tip:** Clear caches (`drush cr`) after enabling a source submodule so DVF
> discovers the new source and style plugins. Fetched data is cached with a
> configurable expiry, which also cushions repeat hits to a remote source. Very
> large datasets are read into memory before charting, so test them for memory and
> time limits.
