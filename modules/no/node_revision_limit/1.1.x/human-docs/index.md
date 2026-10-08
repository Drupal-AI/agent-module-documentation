# Node Revision Limit — manual setup guide

**Node Revision Limit** (`node_revision_limit`) keeps your node revision history
from growing without bound. Every time a node is saved, Drupal by default keeps
*every* previous version forever, and on a busy editorial site the revision
tables can balloon to many times the size of the live content. This module caps
the number of revisions each node retains: when a node is updated, it counts the
node's revisions and deletes the oldest ones beyond your configured limit,
keeping the current (default) revision untouched.

You set a **global limit** and, optionally, **per‑content‑type overrides**, so
high‑churn types can keep only a handful of versions while others keep more (or
are excluded). The pruning respects Drupal's revision system and is applied
independently for each enabled language, which makes it a good fit for
multilingual sites. In fact, this module was written specifically because a
popular alternative did not prune correctly on multilingual sites; it is also
compatible with **Content Translation** and **Content Moderation**.

Once configured, it runs entirely automatically — there are no cron jobs to set
up, no permissions to grant, and no web‑facing routes beyond the admin settings
form. It has no module dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the global and per‑content‑type
   revision limits.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Node Revision
Limit** (`/admin/config/content/node_revision_limit`), gated by the **Administer
site configuration** permission.
