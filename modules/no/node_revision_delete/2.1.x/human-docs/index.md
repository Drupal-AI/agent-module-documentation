# Node Revision Delete — manual setup guide

**Node Revision Delete** (`node_revision_delete`) automatically prunes old node
revisions so your database doesn't grow forever. By default Drupal keeps *every*
revision of a node for all time, and on a content-heavy site those revision
tables can balloon and slow down backups and admin listings. This module lets you
decide, **per content type**, how many prior revisions to keep and/or how old a
revision may be before it becomes eligible for deletion — and then it quietly
deletes the excess in the background on cron.

Rather than deleting revisions the moment you save the settings, the module marks
surplus revisions as candidates, queues them, and processes the queue with cron
(you can also trigger a run by hand). This keeps the site responsive even when
there is a large backlog to clear.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step, from installing the module to setting retention rules for each
content type. If you are looking for terse, token-cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Node Revision Delete settings page listing content types and the per-plugin defaults](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Content authoring → Node
Revision Delete** (`/admin/config/content/node_revision_delete`). That page is
organised into two tabs:

- **Settings** — the per-content-type retention rules and the global defaults
  (this is where you do almost all of your setup).
- **Queue** — trigger a queueing/deletion run from the UI instead of waiting for
  the next cron run.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the retention rules (how many
   revisions to keep and/or how old they may be) for each content type and save.
