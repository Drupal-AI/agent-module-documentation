# Revision Delete Tools — manual setup guide

**Revision Delete Tools** (`revision_delete_tools`) provides efficient **Drush
commands** for bulk-deleting entity revisions, using a queue so that even entities
with tens of thousands of revisions can be pruned without exhausting memory. It
works across entity types — nodes, media, and other revisionable entities — and by
default keeps the latest three revisions unless you ask for a different number.

This is a command-line tool. It has **no admin UI, no permissions, and no settings
form** — you drive it entirely with Drush and cron. Because it is built around a
queue, a single command queues the work in chunks, and the actual deletion happens
as cron (or a manual queue run) processes the queue.

**Deletion is irreversible.** There is no confirmation prompt and no dry-run: once
a revision is processed out of the queue it is gone. Take a database backup before
the first run on production, and remember that revisions are often the only record
of who changed what. See "How to use it" below for the safe sequence.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — everything is done through Drush, described in
"How to use it" below.

## How to use it

The single command is `rdt:remove-revisions`. It takes optional arguments to
narrow what it targets (entity type, then bundle, then a single entity ID) and a
`--keep` option for how many revisions to retain (default **3**):

```bash
drush rdt:remove-revisions                        # every revisionable entity
drush rdt:remove-revisions node                   # all node revisions
drush rdt:remove-revisions node page --keep=5     # "page" nodes, keep the last 5
drush rdt:remove-revisions node page 123          # a single node (ID 123)
drush rdt:remove-revisions media image 123        # a single media entity (ID 123)
```

`--keep` must be at least 1 (the default revision must always be kept), and a
non-revisionable entity type is refused up front.

**Important — the command only queues the work; it does not delete anything by
itself.** Deletion happens when cron runs and processes the queue (in chunks of
500). To make it happen now, run the queue yourself:

```bash
drush queue:list                 # see the pending queue
drush queue:run <queue name>     # process it now
```

Because the work is queued, a mistake is only *partly* recoverable: clearing the
queue **before** cron runs prevents the pending deletions, but anything already
processed is gone. Back up first.
