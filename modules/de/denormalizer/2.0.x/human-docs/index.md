# Denormalizer — manual setup guide

**Denormalizer** (`denormalizer`) flattens Drupal entity data into denormalized
database **views or tables** — a classic star / snowflake schema — so that
business‑intelligence (BI) and ETL tools can read your Drupal data without
needing to understand Drupal's internals, such as how fields are stored across
many tables.

Drupal stores content in a highly normalized way: a single node's fields are
spread across separate tables, joined at runtime. That is efficient for Drupal
but awkward for a reporting or analytics tool, which would rather query one wide,
flat table per content type. Denormalizer bridges that gap. You describe the data
you want flattened, and it produces either database *views* (a live, read‑only
projection) or real *tables* (populated by selecting the data in, then updated
incrementally on later runs based on the primary key and a "changed" field). You
can even target a **separate database**, which is handy if you want to give a BI
or ETL tool access only to the denormalized data and nothing else. It is a
developer / data‑transformation tool; it deliberately does *not* use
`entity_load` and does not perform the "Load" step of ETL itself.

Using it has two parts. First, in **code**, you tell Denormalizer what to flatten
by implementing `hook_denormalizer_info()` in a custom module — listing the plain
tables and entities (with bundles and a "changed" key) you want denormalized.
Second, in the **admin UI**, you set prefixes and the destination database, then
use the Create and Export tabs to build the views/tables or preview the SQL.

> ## ⚠️ Handle with care — it performs destructive database operations
>
> Denormalizer **creates databases and performs destructive operations on tables
> and views**. There are sanity checks to stop you overwriting your own tables,
> but the module's own documentation warns you explicitly. **Back up first, use a
> dedicated destination database where possible, and confirm what the Export tab
> shows before you run the Create step.**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define what to denormalize (in
   code), then set prefixes, the destination, and create the views/tables.

## Where it lives in the admin menu

Its settings live at **Configuration → Development → Denormalizer**
(`/admin/config/development/denormalizer`), which is also where the **Create** and
**Export** tabs live.
