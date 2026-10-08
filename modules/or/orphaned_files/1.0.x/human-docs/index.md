# Orphaned Files — manual setup guide

**Orphaned Files** (`orphaned_files`) gives administrators a report of **orphaned
managed files** — files Drupal is tracking that are no longer referenced by any
entity. Over time a site accumulates these: replaced images, documents left
behind when their node was deleted, assets imported but never placed. They still
sit on disk and in backups. This module surfaces them so you can review and clean
them up, reclaiming storage and reducing clutter.

You generate the list with filters so it stays relevant to what you're looking
for, review the results, and then delete the files you no longer want directly
from the interface. It depends only on core's **File** module.

> **Treat the list as candidates for review, not a delete queue — and take a
> backup first.** A file counts as "orphaned" when nothing the module can see
> references it, but some references aren't tracked: a file linked from inside a
> rich‑text body, referenced in configuration, or used by another module's own
> tables can look orphaned when it isn't. **Verify a file is genuinely unused
> before deleting it — deletion is irreversible.**

> **The report itself can be sensitive.** It lists file paths and names, which may
> reveal private files or content. Grant the module's permission only to trusted
> administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — it's a report‑and‑cleanup tool.
How to use it is described below.

## How to use it

1. Enable the module and grant its permission (see Installation) to the trusted
   administrators who should manage file cleanup.
2. Go to the **Orphaned Files** report in the admin area.
3. Apply the available filters to narrow the list to the files you're interested
   in, then review the results.
4. Confirm that the files you intend to remove are genuinely unreferenced — check
   for uses that aren't tracked (rich‑text embeds, configuration references) —
   then delete the ones you no longer need. Because deletion is permanent, take a
   backup before you start.
