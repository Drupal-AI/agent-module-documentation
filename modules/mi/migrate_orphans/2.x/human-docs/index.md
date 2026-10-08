# Migrate Orphans — manual setup guide

**Migrate Orphans** (`migrate_orphans`) cleans up the leftovers that build up when
you repeatedly import data from an external source. When a record you previously
imported is later **deleted at the source**, the migrated content stays behind in
Drupal and your `migrate_map` tables fill with entries that no longer point at
anything real — "orphans". This module compares a migration's map table against
the current source and lets you deal with the orphaned items, so your Drupal
content mirrors the source again.

It gives you a Drush command with two modes: you can **delete** the orphaned
entities outright, or **disable** them (leaving them in place but switched off).
That choice matters — see the caution below.

It depends on core **Migrate** (`migrate`), the contributed **Migrate Plus**
(`migrate_plus`), and **Migrate Tools** (`migrate_tools`, version 6.0.4 or newer),
and it supports **Drupal 8 through 11**. This is a migration‑maintenance tool run
from the command line; there is no admin settings screen and nothing your site
visitors see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate, Migrate Plus, and Migrate Tools.

There is **no configuration page** for this module. It has no settings form; you
run it from Drush as described below.

## How to use it

Migrate Orphans is driven entirely from Drush. The two commands are:

```bash
# Delete orphaned items (content whose source row is gone)
drush migrate:orphans-purge

# Disable orphaned items instead of deleting them
drush migrate:orphans-disable
```

Run them against the migration you want to reconcile with its source.

> **Important — this deletes content, so use it deliberately.** "Orphaned" here
> means "no longer present in the source according to the migration map." That is
> exactly right for a **mirror** migration, where deletions at the source are
> meant to propagate to Drupal. But if your migration is *not* a strict mirror,
> purging orphans will delete content you meant to keep. Before you run it:
>
> - confirm the migration really is a mirror (source deletions *should* remove
>   the corresponding Drupal content);
> - review what the command proposes to remove;
> - keep a database backup, and test on a copy of the site first.
>
> If you are unsure, prefer `migrate:orphans-disable` — it switches the items off
> without deleting them, which is easier to undo.
