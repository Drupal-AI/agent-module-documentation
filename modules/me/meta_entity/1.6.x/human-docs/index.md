# Meta Entity — manual setup guide

**Meta Entity** (`meta_entity`) lets you store metadata *about* an entity **outside**
that entity's own storage. Instead of adding a field to a node (or user, term, media,
etc.) to hold things like view counts, likes, ratings, editorial notes or sync state,
you attach a separate "sidecar" record — a `meta_entity` — that points at the content
entity through a [Dynamic Entity Reference](https://www.drupal.org/project/dynamic_entity_reference).

Why not just add a field? Because in several recurring cases a field is the wrong tool:
the data changes far more often than the entity and would spawn a new revision every
time; it is operational rather than editorial and shouldn't clutter the edit form; it
applies to entity types you don't control; or it is written by a background process
and shouldn't bump the entity's "last modified" timestamp or invalidate its cache
tags. A sidecar record avoids all of that, and because it uses Dynamic Entity
Reference, one metadata type can serve nodes, users, media and more without a separate
field per target type.

You define **meta entity types** (bundle configuration entities of type
`meta_entity_type`) that declare which content bundles they can attach to, then add
fields to those types for the data you want to store. Optionally, each targeted bundle
can expose a computed reverse-reference field so the content entity can point back at
its meta entity, and types can auto-create a meta entity when a matching content
entity is created.

An important trade-off to keep in mind: because the data lives off the entity, it is
**not** in the entity's revisions, **not** in its default rendering, and **not**
automatically in its search index — anything that needs to read it has to know to look
for it. Although the module ships an admin UI, it is **primarily intended to be used
programmatically** (via the `MetaEntityType` and `MetaEntity` APIs). It depends on the
[Dynamic Entity Reference](https://www.drupal.org/project/dynamic_entity_reference)
module and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Dynamic Entity Reference.

There is **no site-wide settings form** for this module. You manage meta entity
**types** at **Structure → Meta entity** (`/admin/structure/meta-entity`), behind the
**Administer meta entity** permission — described under "How to use it" below.

## Where it lives in the admin menu

Meta entity types are managed at **Structure → Meta entity**
(`/admin/structure/meta-entity`). Access to that admin surface is restricted by the
**Administer meta entity** permission, and each meta entity type also generates its own
per-type permissions.

## How to use it

The module is mostly used from code, but the overall shape is:

1. Define a **meta entity type** (for example "Visits") that declares which content
   bundles it applies to — via the UI at **Structure → Meta entity**, or in code with
   `MetaEntityType::create([...])`. In the mapping you can optionally set a
   `field_name` (to expose a reverse-reference field on the target bundle) and
   `auto_create` (to create the meta entity automatically when a matching content
   entity is created).
2. **Add fields** to that meta entity type for the data you want to store (for
   example an integer `field_count`), as config or through the UI.
3. **Create and link** a meta entity to a content entity — for example
   `MetaEntity::create(['type' => 'visits', 'target' => $node, 'field_count' => 10])`.

A content entity can be referenced by a single meta entity of a given type. From then
on, code (or the reverse-reference field, if you configured one) can read and update
that metadata without ever resaving — or revisioning — the content entity itself.
