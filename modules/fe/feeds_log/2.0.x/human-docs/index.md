# Feeds Log — manual setup guide

**Feeds Log** (`feeds_log`) records the items a
[Feeds](https://www.drupal.org/project/feeds) import did **not** import — a log of
the source rows that were skipped during a run, so you can review and debug why
they were dropped. Each logged entry lists a label, the log time, and a message
naming the fields involved and the reason. It adds an **Unimported items** tab to
the Feeds view.

> **This module is obsolete.** Its functionality has been merged into the Feeds
> module itself (Drupal.org issue #2907721), so on current versions of Feeds you no
> longer need it. If you do use this standalone module, it depends on a patch being
> applied to Feeds first (the patch differs by branch — a different one for 8.x‑1.x
> versus 2.x — because the hook names differ). For new sites, prefer the built‑in
> Feeds logging instead.

A data‑handling note worth keeping in mind: the log captures **source feed data**
for the unimported records, which may include personal or otherwise sensitive
content pulled from the source. That data is stored in the site and is readable by
anyone with access to the log, so treat it accordingly and prune it. The module has
no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds (note the required patch).

There is **no configuration page** for this module — it simply adds an
**Unimported items** tab to the Feeds view once installed.

## Where it lives in the admin menu

Feeds Log adds no settings page. After installation, an **Unimported items** tab
appears on the Feeds view, where you can review the records that were skipped during
imports.

## How to use it

1. Run a Feeds import as normal.
2. Open the **Unimported items** tab on the feed to see the records that weren't
   imported, each with its label, log time, and a message explaining which fields
   caused the skip and why.
3. Use that information to fix the source data or the mapping, then re‑run the
   import. Prune the log periodically, since it may hold sensitive source data.
