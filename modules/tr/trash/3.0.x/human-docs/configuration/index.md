# Configuration

Trash has one settings form. Until you enable at least one entity type here,
deleting content behaves exactly as it did before — nothing is soft‑deleted. So
this page is the step that actually switches the recycle bin on.

## Open the settings form

1. Log in as a user with the **Administer trash** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Trash**, or navigate directly to
   `/admin/config/content/trash`.

## Enabled entity types

This is the heart of the form. It lists the content entity types that Trash
supports out of the box — **node** (content), **taxonomy term**, **menu link**,
**file**, **path alias**, and **redirect** (each has a dedicated internal
handler) — and lets you tick which ones should use the recycle bin. For types
that have bundles (for example the different content types under *node*), you can
narrow participation down to just the bundles you care about, so you might
protect *Article* and *Page* but leave a throwaway type alone.

Only the types and bundles you enable here are soft‑deleted; everything else is
deleted normally. Enabling a type through this form also triggers the necessary
schema and route rebuilds behind the scenes, so prefer the form over editing
config by hand.

## Automatic purging

Trash can clean out the bin for you on a schedule so it does not grow forever:

- **Enable automatic purge** — when ticked, trashed items are permanently deleted
  after a retention period. Leave it off to keep items until someone purges them
  by hand.
- **Purge after** — the retention window, written as a human period such as
  `30 days`, `15 days`, or `2 hours` (this is the default: `30 days`). The value
  is validated, so an unparseable period is rejected.

Auto‑purge runs on **cron** through a queue worker, so make sure cron is running
regularly for the retention window to be enforced. This pairs well with a
data‑retention policy: soft‑delete gives editors a grace period, and auto‑purge
guarantees old items are eventually gone for good.

## Compact overview

- **Compact overview** — simplifies the `/admin/content/trash` listing page. If
  you have enabled many entity types and the grouped overview feels cluttered,
  turn this on for a more condensed view.

## Save

Click **Save configuration**. From this point on, deleting any enabled entity
type moves it to the bin at **Content → Trash** instead of destroying it.
