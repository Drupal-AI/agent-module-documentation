# Configuration

Activity Tracker has **no settings form or admin page**. It works out of the box —
its pages appear immediately and its index updates itself as content changes. There
is exactly one configurable value, which you set with Drush.

## The one setting: `cron_index_limit`

When you first enable the module on a site that already has content, Tracker needs
to build its activity index for all the *existing* nodes. It does this gradually on
**cron**, a batch at a time, so it doesn't overwhelm your database in one go.

- **`cron_index_limit`** (default **1000**) — how many existing nodes are
  back‑indexed per cron run during that initial catch‑up.

Change it with Drush:

```bash
drush cset tracker.settings cron_index_limit 500 -y
```

- Lower it (e.g. `500`) if cron runs are getting heavy on a very large site.
- Raise it to finish the initial indexing sooner, if your database can handle it.

## How indexing works

- On install, the module records the highest node ID and, on each cron run, walks
  **downward** through your existing nodes in `cron_index_limit`‑sized batches until
  everything is indexed. Once it reaches the bottom, this back‑fill work stops — the
  setting no longer has any effect after the catch‑up is complete.
- **New and updated content doesn't wait for cron.** Whenever a node or comment is
  created, edited, or deleted, the relevant index rows are updated immediately. So
  `cron_index_limit` only governs that one‑time back‑fill of pre‑existing content.

## What you don't need to configure

- **Access** — the activity pages use core's **Access content** permission; there's
  nothing to grant beyond that.
- **Display** — the pages are ready to view at `/activity` and on user profiles. If
  you want a more customized listing, use the **Views** integration (Tracker exposes
  its index tables and a "user posted or commented" argument/filter to the Views UI).
