# Permanent Entities — manual setup guide

**Permanent Entities** (`permanent_entities`) gives you a special kind of entity
that **cannot be created or deleted through the Drupal UI or API** — not even by
a site administrator with full privileges. Entities of this kind can only be
created or removed from code (a `hook_update_N` or a Drush command). Editing and
translating them is still allowed; it is only creation and deletion that are
locked down.

This is useful for content that must always exist and must never be removed by
accident — reference data and config-like "singletons" that rarely change. The
classic examples are things like the planets of the solar system, the districts
of a city, or the seasons of the year: a fixed set of records that a content
editor should be able to relabel or translate, but should never be able to
delete or add to on a whim.

Because deletion is blocked in the UI, treat these entities as effectively
permanent: removing one is a deliberate, code-level act. If your site relies on
the "permanent" guarantee for data integrity, confirm the restriction holds on
every path you care about — the UI and any programmatic/API delete paths — and
remember that update (editing) remains open unless you restrict it with the
per-bundle edit permissions the module provides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module. You work with it through the
structure and content admin pages and through Drush, as described below.

## Where it lives in the admin menu

- **Structure → Permanent Entity Types**
  (`/admin/structure/permanent_entity_types`) — where you define the *types*
  (bundles) of permanent entity, before creating any instances.
- **Content → Permanent Entities** (`/admin/content/permanent_entities`) — where
  the individual permanent entities are listed for editing and translating.
  Notice there is no "Add" or "Delete" action here — that is by design.

## How to use it

1. **Create a Permanent Entity Type** at
   `/admin/structure/permanent_entity_types` — for example a type called
   `planet`.
2. **Create the individual entities from code**, since the UI cannot. The
   quickest way is Drush:

   ```bash
   drush pec planet jupiter Jupiter
   ```

   (arguments: the type, the machine id, and the label). You can also create
   them in a `hook_update_N` or install hook with
   `Drupal\permanent_entities\Entity\PermanentEntity::create([...])->save();`.
3. **Edit or translate** the resulting entities at
   `/admin/content/permanent_entities`. Editors can update labels and
   translations, but the delete and add operations are unavailable — the whole
   point of the module.
