# Content Moderation Revision Delete — manual setup guide

**Content Moderation Revision Delete** (`cm_revision_delete`) prunes old node
revisions on a schedule so your revision tables don't grow without bound — while
respecting **Content Moderation**. On an editorial site every save creates a new
forward revision, and over time the `node_revision` and related tables can balloon.
This module keeps a configurable number of revisions per node and deletes the
surplus, but it is careful never to remove the revisions that back the current
default (published) or the latest moderation state.

Once configured, it runs automatically via cron/queue. You set how many revisions
to keep and which content participates, and it does the rest. It also includes a
small developer form for inspecting or triggering the pruning logic while you're
setting things up. It deletes **only historical node revisions** — never the
entities themselves, and only for nodes (other entity types are out of scope).

**Please note:** this module is marked **obsolete and unsupported.** It was
originally written because the [Node Revision Delete](https://www.drupal.org/project/node_revision_delete)
module didn't support Content Moderation — but that has since changed. For new
sites, prefer Node Revision Delete instead. This guide is provided for existing
installations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — set the retention count and which
   content types/states participate.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Content Moderation
Revision Delete** (`/admin/config/content/cm_revision_delete`), and a developer
tools form sits at `/admin/config/content/cm_revision_delete/devel`. Both are gated
by the **`administer cm_revision_delete`** permission.
