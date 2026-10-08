# Node Cleanup — manual setup guide

**Node Cleanup** (`node_cleanup`) gives administrators a single, safety-first screen
for tidying up content. From one interface you can browse nodes filtered by content
type and publication status, move unwanted **unpublished** content into a restorable
**trash bin**, restore items later, and detect likely **duplicate** content — all
without any risk to your live, published pages.

The key idea is safety. Unlike core's bulk *Delete content* action, every cleanup
operation here is **restricted to unpublished content**, and that rule is enforced on
the server even if a published node somehow gets selected. So the module is designed
for exactly the housekeeping that's normally nerve-wracking: clearing out stale
drafts, recovering something you trashed by mistake, and finding duplicate pages left
behind by migrations, imports, or collaborative editing.

Trashed nodes are removed from the main listing but kept in the database until they
are purged, so a restore always preserves the node's original publication status. You
can purge expired trash manually, or configure a **retention period** so cron
permanently removes expired items automatically. It depends only on core's **Node**
module and reuses core's existing **Administer content** permission — it does not
introduce a new one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no separate module settings form beyond the small auto‑purge page described
below, so setup and usage are covered here in "How to use it."

## Where it lives in the admin menu

- The main tool is at **Content → Node Cleanup**
  (`/admin/content/node-manager`), which has four tabs: **List**, **Trash**,
  **Duplicate Content**, and **Settings**.
- The auto‑purge options also have a home under
  **Configuration → Content authoring → Node Cleanup**
  (`/admin/config/content/node-cleanup`).

## How to use it

1. Grant the core **Administer content** permission to the roles that should manage
   cleanup, at **People → Permissions** (`/admin/people/permissions`). No new
   permission is added by this module.
2. Go to **Content → Node Cleanup** (`/admin/content/node-manager`).
3. On the **List** tab, filter nodes by content type and publication status. A reset
   option appears whenever a filter is applied. Bulk cleanup actions become available
   only when unpublished content is present in the listing, and they act only on
   unpublished nodes.
4. Use the **Trash** tab to review soft‑deleted nodes and **restore** any of them —
   restored content keeps its original published/unpublished status.
5. Use the **Duplicate Content** tab to find nodes that share a title within the same
   content type; those with identical body content are highlighted as stronger
   matches, and you can move duplicates to the trash directly from there.
6. On the **Settings** tab (or at
   `/admin/config/content/node-cleanup`), enable **auto‑purge** if you want expired
   trash removed permanently during cron, and set a **retention period** in days.
   Auto‑purge is **off by default**. You can also trigger a purge immediately with the
   **Purge Expired Trash Now** action.

> **Tip:** Auto‑purge only runs during cron, so make sure cron is running (core's
> Automated Cron, or a scheduler such as Ultimate Cron) if you enable it.
