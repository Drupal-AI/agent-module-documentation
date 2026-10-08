# Scheduled Publish — manual setup guide

**Scheduled Publish** (`scheduled_publish`) lets editors line up future
**content-moderation** state changes on an entity. Instead of publishing a node
manually at the right moment, an editor picks a date and time and the target
moderation state — *Published*, *Archived*, or any state in your workflow — and
Drupal makes the transition automatically when the time arrives. Because the field
is normally multi-value, one node can carry a whole queue of changes: publish on
Friday, archive next month.

It works by adding a **Scheduled publish** field to a bundle. Each field entry
stores a datetime plus a target moderation state; on every cron run the module
finds entries whose time has passed and applies the matching transition, saving a
new revision. You can also fire due transitions on demand with a Drush command,
which is handy in deploy scripts or for testing. A dedicated admin listing shows
all pending scheduled changes across the site.

The one prerequisite to keep in mind is **Content Moderation**: the entity type
and bundle must be part of a moderation workflow, because that's where the target
states come from. There is no global settings form (`configure` is `null`) —
configuration is per field.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the field type internals,
the cron service id, and the Drush command — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the
   Content Moderation dependencies, and enable the module.
2. [Configuration](configuration/index.md) — add a Scheduled publish field to a
   moderated bundle, use it as an editor, run transitions via cron or Drush, and
   review pending changes.

## Where it lives in the admin menu

There is no settings page. The two things you interact with are:

- The **Scheduled publish** field you add on a bundle's *Manage fields* page
  (e.g. `/admin/structure/types/manage/article/fields`).
- The **pending changes listing** at **Content → Scheduled publish**
  (`/admin/content/scheduled-publish`), which lists queued transitions and lets
  you add, edit, or delete them. It is gated by the *Access scheduled publish
  pages* permission (and the listing itself also needs *View any unpublished
  content*).

See [Configuration](configuration/index.md) for the full walkthrough.
