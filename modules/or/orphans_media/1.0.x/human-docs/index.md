# Orphans Media — manual setup guide

**Orphans Media** (`orphans_media`) finds **media entities that nothing
references** and offers to delete them, so you can reclaim the storage a
long‑running site accumulates in unused uploads. Media libraries only grow: an
editor uploads three versions of an image and uses one, a node referencing a
document is deleted while the document stays, a migration imports assets that were
never placed. None of it is visible, all of it is backed up and moved between
environments.

The module scans your media entities, cross‑checks their usage, and lists the
unreferenced ones in a report. You can **filter by media bundle** to target
specific types, review a preview of what would be removed, and then delete in bulk
— large libraries are handled with Drupal's batch system. For developers, it emits
**pre‑delete** and **post‑delete** events so you can hook in logging or cleanup
logic. It depends on core's **Media** module.

> **Treat the list as candidates for review, not a delete queue — and take a
> backup first.** Reference tracking reliably finds media referenced by **entity
> reference fields**. It does **not** reliably find media referenced from inside
> **rich‑text fields** as an embedded entity, from **Layout Builder** section
> configuration, from **serialised settings**, or from another module's own
> tables. A media item used only that way looks orphaned but is not — and
> **deletion is irreversible**, so a missing image on a live page is a visible
> failure. Take a backup and understand how your site actually references media
> before you run it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no persistent settings form** — the module is a review‑and‑delete tool.
How to use it is described below.

## Where it lives in the admin menu

The report and delete form is at **Configuration → Media → Orphans Media**
(`/admin/config/media/orphans-media`), reachable by users with the **access
orphans media delete** permission.

## How to use it

1. Grant the **access orphans media delete** permission only to a trusted role —
   this is a destructive tool and should not be delegated widely.
2. Go to `/admin/config/media/orphans-media`.
3. Optionally **filter by media bundle** to limit the scan to specific media
   types.
4. Review the preview of unreferenced media carefully, cross‑checking anything you
   suspect might be referenced in ways the scan can't see (rich‑text embeds,
   Layout Builder, etc.).
5. Once you're confident and have a backup, delete the selected media in bulk.
