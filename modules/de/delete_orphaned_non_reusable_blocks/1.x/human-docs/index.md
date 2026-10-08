# Delete Orphaned Non-Reusable Blocks — manual setup guide

**Delete Orphaned Non-Reusable Blocks** (`delete_orphaned_non_reusable_blocks`)
finds and deletes the inline (non‑reusable) block content that Layout Builder can
leave behind, and which Drupal otherwise gives you no way to see or clean up.

When you add a custom block to a page with Layout Builder — "Create custom block"
— Drupal creates a `block_content` entity of the *inline / non‑reusable* kind
that belongs only to that layout. If the layout or page is later changed or
deleted, those inline blocks are not always cleaned up: they become **orphans**,
rows in the `block_content` table that nothing references. Over time they
accumulate and bloat the table, and — more painfully — they can **block you from
uninstalling a module** that provided such blocks, because Drupal insists you
still have content of that type. There is no built‑in screen to find or remove
them, which is exactly the gap this module fills: it searches for non‑reusable
blocks, checks whether each is still in use, and offers to delete the ones that
are orphaned.

> ## ⚠️ This is destructive — treat it as a deliberate maintenance action
>
> The module's own guidance is unusually emphatic, and worth repeating:
>
> - **Do not run this on a production environment.** Run it against a copy or a
>   maintenance environment.
> - **Back up your database first.** There is **no rollback** — deleted blocks
>   are gone.
> - The determination of "orphaned" relies on Layout Builder's inline‑block usage
>   service, whose behavior is not extensively documented. **Confirm it is doing
>   what you expect** before you delete, especially on a complex site with custom
>   layout usage.
> - **List first, review, then delete** — do not treat it as an automated sweep.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no ongoing settings page — the module provides a list‑and‑delete action,
whose workflow is described below.

## Where it lives in the admin menu

The tool is at **Content → Content authoring → Delete Orphaned Block Content**.

## How to use it

1. **Take a database backup**, and do this on a non‑production environment.
2. Enable the module and clear caches (`drush cr`).
3. Go to **Content → Content authoring → Delete Orphaned Block Content**.
4. The module searches for orphaned non‑reusable blocks and, if it finds any,
   asks whether you want to delete them (all or nothing, at present).
5. **Review** what it found and confirm it matches your expectations.
6. Click **Delete orphans**, then confirm again to remove them.
