# Taxonomy Entity Index — manual setup guide

**Taxonomy Entity Index** (`taxonomy_entity_index`) keeps a dedicated database
table that maps your content to the taxonomy terms it references. Drupal core
already does this, but only for nodes (the `taxonomy_index` table). This module
generalizes the idea: you pick which entity types to index — media, users,
paragraphs, commerce products, your own custom entities — and it maintains one
tidy lookup table (`taxonomy_entity_index`) that records every "this entity
references this term" relationship across all of them.

Why bother? Because that table is what makes term-based listings fast and
possible for non-node content. Once media (say) is indexed, you can build a View
of media filtered by taxonomy term, add a contextual filter that accepts a term
ID and pulls in child terms to a chosen depth, or count how many entities of any
type reference a given term. The module ships Views integration — a contextual
filter (argument), a field, and a filter — that all read from its index table, so
you get the same term-driven Views features core gives nodes, but for whatever
entity types you choose.

The table stays current on its own. Whenever an editor saves, updates, or deletes
content — or deletes a term or a taxonomy field — the module adds or removes the
matching rows behind the scenes. After a bulk import (or after you change which
types are indexed) you can rebuild the whole table from a reindex form or with a
Drush command. It depends only on core's Taxonomy module and defines no
permissions of its own; its admin pages use core's **Administer site
configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which entity types to index,
   the two indexing options, and how to rebuild the table.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Taxonomy Entity Index**
(`/admin/config/system/taxonomy-entity-index`). A companion reindex form lives
just beneath it at `/admin/config/system/taxonomy-entity-index/reindex`. Both
require the **Administer site configuration** permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form and tick the entity types you want indexed — for
   example **Media** or **User** — then save.
3. Run a rebuild so existing content is indexed: use the reindex form, or run
   `drush taxonomy_entity_index:rebuild` from the command line.
4. Build your Views. When you add a contextual filter, field, or filter to a
   View of an indexed entity type, you'll see the Taxonomy Entity Index handlers
   (for example the **term ID with depth** argument) alongside the core ones.
   These let you filter or list by term — including child terms — for content
   types that core's taxonomy Views support never reached.
