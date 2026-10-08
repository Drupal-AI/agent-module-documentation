# Entity Auto Term — manual setup guide

**Entity Auto Term** (`eat`) keeps a taxonomy term in lock-step with your content
automatically. When you create an entity (currently **nodes**), EAT creates a
taxonomy term named after the entity's title in each vocabulary you've mapped —
so every article can have a matching term without an editor remembering to create
one. It's a Drupal 8+ successor in spirit to the old NAT module, built to work
across entity types.

The sync is two-way over the content's lifetime: when you **rename** the node,
EAT renames the linked term to match; when you **delete** the node, EAT removes
the term and the mapping. If a term of the same name already exists, EAT reuses it
rather than creating a duplicate. It records every entity-to-term link in its own
`{eat}` table, so the relationships are queryable.

Because the auto-term mirrors your content, it's handy for building "related
content" listings and contextual Views filters: EAT ships a **Views
argument-default plugin** ("Content ID from path for EAT") that supplies the
mapped term id from the current node's path. For existing content created before
you installed EAT, a **batch backfill form** and a Drush command (`drush eatas`)
can generate the terms retroactively. EAT depends on the **Views** module and
works on Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — map node bundles to vocabularies and
   backfill existing content.

## Where it lives in the admin menu

EAT's settings form is at **Configuration → System → Entity Auto Term**
(`/admin/config/system/eat`) and requires the **Administer site configuration**
permission. The batch backfill lives at `/admin/config/system/eat/batch`.
