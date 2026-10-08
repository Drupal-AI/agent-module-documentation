# Trash — manual setup guide

**Trash** (`trash`) gives your Drupal site a site‑wide recycle bin. Instead of
permanently destroying content the moment someone clicks *Delete*, Trash
soft‑deletes it: the item disappears from normal listings and search results,
but it stays safely in storage where a trusted user can review it, restore it,
or purge it for good later. It is the "undo" that core deletion never had.

Under the hood, Trash intercepts deletion for the entity types you turn on —
nodes, taxonomy terms, menu links, files, path aliases, redirects, and other
supported content entities — and simply stamps a *deleted* timestamp rather than
removing the row. A **Trash** admin page at `/admin/content/trash` lists
everything that has been soft‑deleted, grouped by entity type, so editors can
restore items back to their original state or delete them permanently. You can
also enable automatic purging so trashed items are cleaned up after a retention
window (for example "30 days"), handled quietly by a queue worker on cron.

Trash is a foundational safety net: it protects against accidental data loss,
gives editors confidence, and plays nicely with core Workspaces. It has no module
dependencies, ships Drush commands for restoring and purging from the command
line, and lets developers extend it to custom entity types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: choosing which
   entity types use the bin, and turning on auto‑purge.

## Where it lives in the admin menu

There are two places to know about once Trash is enabled:

- **The recycle bin** — **Content → Trash** (`/admin/content/trash`). This is the
  day‑to‑day listing of soft‑deleted items, with actions to restore or purge.
- **The settings form** — **Configuration → Content authoring → Trash**
  (`/admin/config/content/trash`). This is where you decide which entity types
  and bundles participate and configure automatic purging.

## How to use it

Once you have enabled at least one entity type on the settings form (see
[Configuration](configuration/index.md)), deleting one of those entities no
longer removes it — it moves to the bin. To recover or clean up items:

1. Go to **Content → Trash**.
2. Find the item in the list (it is grouped by entity type, and you can enable a
   compact overview if many types are enabled).
3. Choose **Restore** to bring it back to its original state, or **Purge** to
   delete it permanently. You can act on a batch of items at once.

Trusted staff can be given permission to purge while junior editors are limited
to deleting (which only soft‑deletes) and restoring. If you prefer the command
line, Trash also provides Drush commands: `drush trash:restore`,
`drush trash:purge`, and `drush trash:export-views` (Drush 12 or 13 is
suggested). Developers can react to soft‑deletion and restoration in custom code
via `hook_entity_trash_delete()` and `hook_entity_trash_restore()`, and can add
trash support to a custom entity type with a trash handler service — see the
[`agent/`](../agent/start.md) docs for those details.
