# Devel Entity Updates — manual setup guide

**Devel Entity Updates** (`devel_entity_updates`) is a **development-only** tool that
restores the old `drush entity:updates` / `entup` behavior that Drupal core removed.
When you're actively building a custom entity type and repeatedly adding, removing,
or altering entity type and field storage definitions in code, this module lets you
apply those pending schema changes on the fly with a single Drush command — instead
of hand-writing a `hook_update_N()` every time you tweak a definition.

Core removed automatic entity-definition updates on purpose, because applying
arbitrary schema changes is not safe or predictable for real deployments. This
module brings the convenience back **only for the narrow case of local
development**. It is emphatically **not** for production, and it is **not** a way to
"fix" a *Mismatched entity and/or field definitions* error on a live site — released
schema changes must still go through proper `hook_update_N()` /
`hook_post_update_NAME()` update functions.

The module depends on the **Devel** module and requires **Drush 12 or 13**. It has
no admin UI, no configuration, and no permissions — everything happens through its
Drush command (see below). It refuses any change that would require a data
migration, throwing an error rather than proceeding.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the
`DevelEntityDefinitionUpdateManager` API — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it in your development environment.

## Where it lives in the admin menu

Nowhere — this module has no admin pages, settings, or permissions. It works
entirely through Drush.

## How to use it

After editing your entity type or field definitions in code, run:

```bash
drush entup
```

(The command is `devel-entity-updates`, with the aliases `dentup`, `entup`, and
`entity-updates` — a drop-in for the old core command.) It prints a summary of the
pending entity type and field storage changes, asks you to confirm, then applies
them and rebuilds caches. Pass `--cache-clear=0` to skip the automatic cache
rebuild if you'll clear caches yourself.

A typical local loop is: edit your entity definitions, run `entup`, refresh, repeat.
Just remember to never enable or rely on this module in production.
