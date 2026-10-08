# Configuration

Entity Recycle works as soon as it is enabled, but you should review its
**permissions** and its **retention/purge behaviour**, and decide how trashed
content behaves in your existing Views.

## Permissions — gate restore and permanent delete

Go to **People → Permissions** (`/admin/people/permissions`) and grant the
module's permissions carefully. The important ones are:

- **View entity recycle bin** — lets a role see the recycle‑bin listing and the
  soft‑deleted content it contains. Only content that a user with this permission
  can see should end up visible in the bin, so grant it to trusted editorial or
  administrative roles.
- **Restore / permanently delete** recycled items — these are powerful actions
  (restoring content, or removing it for good). Grant them only to trusted roles.

Because these permissions control who can recover or truly erase content, treat
them as sensitive and keep them off untrusted roles.

## Retention and automatic purge

The recycle bin can **purge (permanently delete) items after they have been in
the bin for a set amount of time**, so trashed content does not accumulate
forever. Configure the retention period to match your policy — a longer window
gives more time to recover mistakes, a shorter one clears storage and limits how
long "deleted" data lingers. Purging typically runs on Drupal's cron, so make
sure cron is running for automatic clean‑up to take effect.

> **Data‑retention caveat:** until an item is purged, "deleted" content still
> exists on the site. For legal erasure or data‑retention requests, make sure the
> relevant content is genuinely purged (not merely sitting in the bin).

## Hiding trashed items from your Views

By default the module does **not** alter your existing Views, so soft‑deleted
content can still appear in listings you have built. To keep recycled items out
of a View's results, add a filter on the **`recycle_bin`** field and set it to
**FALSE** (i.e. only show content that is not in the bin). The bundled
**Content Recycle Bin** view is a working reference for how the field is used —
look at it to see the filter in action. (The module README documents how to do
the same programmatically.)

## Save

After adjusting permissions, save the Permissions page; after setting the
retention period, save that settings form. Test by deleting a test item,
confirming it lands in the bin, restoring it, and — if you enabled purging —
checking that old items are cleared after cron runs.
