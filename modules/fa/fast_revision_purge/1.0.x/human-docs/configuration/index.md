# Configuration

Fast Revision Purge is configured and run from **Configuration → Development → Fast
Revision Purge** (permission: *Administer site configuration*). Everything here
deletes data permanently, so read the warning before you save and run.

> **Purging revisions cannot be undone.** Always run a dry run first and take a
> database backup before a real purge. Restrict the module's access to trusted
> administrators.

## Set a retention policy

The **Retention policy** section decides which node and paragraph revisions survive:

- **Keep latest N non-default node revisions** — retain the most recent *N*
  non-current revisions of each node and stage older ones for deletion.
- **Apply keep-last per language** — when checked, the "latest N" count is applied
  per `(node, language)` instead of per node.
- **Keep revisions since date** — a `YYYY-MM-DD` date; any node revision on or after
  that date is kept. Leave empty to disable.
- **Protect latest published revision per node** — when checked, the most recent
  published revision of each node is always kept (on by default).
- **Keep last M paragraph revisions per paragraph entity** — retain the most recent
  *M* revisions of each Paragraph entity.

The current (default) revision of every node and paragraph is always kept, and
paragraph revisions still referenced by kept node revisions are traced and kept too.

## Execution settings

- **Chunk size** — how many revisions are deleted per batch step (default 5000).
- **Sleep between chunks (ms)** — an optional pause between steps to reduce lock
  pressure on busy databases.
- **Ensure helpful DB indexes before running** — when checked, adds indexes that
  speed up planning and purging.

## Preview with a dry run

Before deleting anything, click **Plan (Dry run)**. It computes the KEEP/DELETE sets
and reports counts for node, paragraph, and (if applicable) Layout Builder revisions,
along with a sample of the IDs it would delete and an estimate of the space that could
be reclaimed — without touching your content. Review these counts carefully; this is
your chance to catch a policy that is too aggressive.

## Run the purge

When you are satisfied with the dry-run counts (and have a backup), check the
**Danger zone** confirmation box and click **Run purge now**. The purge runs in
chunked, resumable batches so it completes without timeouts, deleting paragraph
revisions before node revisions. In the **Extra purges** area you can additionally
enable a dedicated **Paragraph revisions** purge and/or a **Layout Builder
revisions** purge (each available only when the matching module is enabled).

After a purge, an optional **Post-purge maintenance** section shows ready-to-copy
`ANALYZE TABLE` / `OPTIMIZE TABLE` SQL — MySQL does not shrink files on `DELETE`, so
run these during a maintenance window to reclaim disk space.

## Running from Drush (for automation and CI)

The module provides Drush commands designed for scripted and scheduled use:

```bash
# Preview (dry run): compute the plan and print KEEP/DELETE counts + samples
drush fastrev:report --keep-last=5 --since=2024-01-01 --protect-published --per-language --keep-paragraph-last=1

# Execute the purge in chunks (with an optional pause between chunks)
drush fastrev:purge --chunk=5000 --sleep-ms=50

# Ensure the helpful DB indexes exist (safe to re-run)
drush fastrev:reindex
```

Aliases: `fr:report`, `fr:purge`, `fr:reindex`.

A common pattern is to schedule `drush fastrev:purge` via cron so revision growth is
kept in check automatically — but only after you have validated your policy with a
dry run and a backup.
