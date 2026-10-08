# Revisions Bulk Operations — manual setup guide

**Revisions Bulk Operations** (`revisions_bulk_operations`) solves a small but
real annoyance: cleaning up old node revisions one at a time. On a content-heavy
site, a single node can accumulate dozens or hundreds of revisions over its life,
and Drupal core only lets you delete them individually from the revisions tab.
This module adds checkboxes and a bulk **delete** action so an editor or
administrator can select several revisions at once and remove them in a single
step — freeing storage and reducing clutter.

It works on the **Revisions** tab of a node (its current focus is node entities),
and it also provides an action to bulk-delete the old revisions of selected nodes.
The project's stated hope is that this functionality eventually lands in Drupal
core.

Two things are worth flagging before you turn it loose. First, **deleting
revisions is destructive and permanent** — once a revision is gone, it is gone, so
take a database backup before a large cleanup and grant the capability only to
roles you trust. Second, the bulk selection interface is gated behind a dedicated
permission, so it stays hidden until you deliberately grant it. (Note: at the time
of writing this version is not compatible with the Diff module.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

This module has **no settings form**. Its only setup step is granting the
permission, described below and in the installation guide.

## How to use it

1. Grant the **bulk selection of revisions** permission (machine name
   `bulk select revisions`) to the roles that should be able to clean up
   revisions. Do this at **People → Permissions** (`/admin/people/permissions`).
2. Visit any node's **Revisions** tab (the *Revisions* link on a node page). With
   the permission granted, each revision now has a checkbox and a bulk action to
   delete the selected revisions.
3. Select the revisions you want to remove, choose the delete action, and confirm.

> **Back up first.** Because deletion is permanent, take a database backup before
> running a large cleanup, and restrict the permission to trusted editorial or
> administrative roles only.
