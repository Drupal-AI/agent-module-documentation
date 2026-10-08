# Reporting Dataset Builder — manual setup guide

**Reporting Dataset Builder** (`reporting_dataset`) gives you a flexible way to
turn Drupal's normalized entity data into **analytics-friendly datasets**. Drupal
stores content across many related tables, which makes reporting and BI queries
painful to write. This module lets site builders **visually select fields** from
entities, paragraphs, and nested structures, then automatically generates a SQL
**VIEW** — or an optional **materialized dataset table** — that presents those
fields as one flat, queryable dataset.

The builder includes a visual schema explorer for browsing entity structures and
a drag-and-drop interface for assembling a dataset. It supports nodes,
paragraphs, nested paragraphs, and entity references, and offers several data
strategies — **Expand**, **Aggregate**, and **JSON** — for how repeated/nested
values are flattened. Datasets can be multilingual and can be rebuilt from the
UI, on cron, or via Drush. It depends on core's **Node** and **Field** modules
and supports Drupal 10 and 11.

Each dataset it builds creates a database object named like
`reporting_dataset_article`, which you can query directly or feed into other
tools. It pairs well with the
[View Custom Table](https://www.drupal.org/project/view_custom_table) module,
which lets Drupal **Views** use a custom database table as a base — so you can
build reports, dashboards, and CSV exports on top of your dataset, or point BI
tools such as PowerBI, Tableau, or Metabase at it.

> **Note:** This is an early release (alpha) and does **not** carry official
> security-advisory coverage. Datasets can flatten and expose content-wide data,
> so treat access to the builder and to the generated datasets as a privileged,
> admin-only concern, and keep the module updated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — the dataset builder, step by step,
   and how to consume the generated datasets.

## Where it lives in the admin menu

Once enabled, Reporting Dataset Builder adds a dataset-building interface (the
visual schema explorer and drag-and-drop builder) in the admin area, restricted
by the permission it provides. See [Configuration](configuration/index.md) for
how to build and rebuild datasets.
