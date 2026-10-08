# Backlinks (backlinks_index) — manual setup guide

**Backlinks** (`backlinks_index`) maintains a reverse index of the internal
links between your nodes, so an editor can always see which other pages point at
the page they are about to change. When you unpublish or delete a node, any page
that linked to it silently breaks — this module exists to warn you before that
happens.

Every time a node in a scanned bundle is saved, the module renders it, pulls out
the internal links, resolves each one back to a node id — handling `node/{id}`
paths, path aliases, language prefixes and even Redirect module source paths —
and records the relationship in its own `backlinks` table. Each node then gains a
**Backlinks** tab listing every page that links to it, with the linking page's
title, how many times it links, its type and its published status. The node edit
form also warns an editor when an unpublished node still has pages pointing at
it.

Two permissions guard the module: **Administer backlinks_index** for the settings
form (choosing which bundles are scanned, plus Reindex and Purge actions) and
**Access backlinks_index** for the read-only per-node tab. Two Drush commands
cover the same bulk operations from the command line. All database access uses
parameterized queries, and there is no anonymous or public-facing endpoint. It
depends on the **Hook Post Action** and **Redirect** modules and runs on
Drupal 9, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in its
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — choose which bundles are scanned,
   build the index, and use the per-node tab and Drush commands.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Backlinks**
(`/admin/config/content/backlinks`). Each node gets a **Backlinks** tab at
`/node/{node}/backlinks`.
