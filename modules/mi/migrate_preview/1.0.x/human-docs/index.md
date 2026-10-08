# Migrate Preview — manual setup guide

**Migrate Preview** (`migrate_preview`) lets you see what a migration *would* do
before you actually run it. Rather than importing and then checking the result,
you preview how your source rows map to destination entities, so you can verify
your mappings and process transforms while you are still building the migration.

It works by extending the **Migrate Tools** module: it adds a **Preview** tab to
the "View" page of a migration. That tab shows the data in two tables — **Source
data** (the data coming from the source after the source plugin and process
plugins have been applied; note that process plugins can cause rows to be skipped
but are expected not to otherwise alter the data) and **Processed data** (what
would actually be written to the destination when the migration runs). Comparing
the two is a quick way to catch a mapping mistake before it becomes imported
content.

It depends on core **Migrate** (`migrate`) and the contributed **Migrate Tools**
(`migrate_tools`) module, and supports **Drupal 10 and 11**. This is a
developer/site‑builder tool with no runtime or access role of its own, and it has
no settings form.

> **Note:** a preview may render **source data**, which can be sensitive. Use it
> in a controlled development context, and be mindful that anyone who can reach a
> migration's admin pages can see the previewed data. This module's releases are
> **not covered** by Drupal's security advisory policy, which is another reason to
> keep it to non‑production environments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate and Migrate Tools.

There is **no configuration page** for this module — it ships no settings form.
Its feature is the Preview tab described below.

## How to use it

1. Make sure **Migrate Tools** is installed and you have your migrations defined.
2. Open a migration's **View** page (the migration overview that Migrate Tools
   provides).
3. Click the **Preview** tab.
4. Review the two tables — **Source data** and **Processed data** — to confirm the
   mapping and transforms produce what you expect. Adjust your migration
   definition and preview again until it looks right, then run the import as
   usual.
