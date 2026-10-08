# Entity Reference Integrity — manual setup guide

**Entity Reference Integrity** (`entity_reference_integrity`) answers one question for any
entity on your site: *"Is anything else pointing at this through an entity-reference field?"*
It's a small referential-integrity toolkit. The base module is **API-only** — it provides the
machinery to detect dependencies but doesn't change any behaviour on its own. Its companion
submodule, **Entity Reference Integrity Enforce**, uses that machinery to actually **block the
deletion** of an entity that is still referenced.

Behind the scenes, the base module scans every entity-reference field across the site and
builds a map of what references what. It then attaches a handler to every entity type that can
tell you, for a given entity, whether it has dependents, which entity IDs reference it, and the
referencing entities themselves. This is useful whenever you want to guard against orphaning
content: preventing the deletion of a taxonomy term, media item, or node that's still in use,
building a "used by" panel for editors, or checking references before a bulk delete.

On its own the base module is for developers — it exposes a service and an entity handler for
custom code to call, and enforces nothing. If you just want the practical "you can't delete
this, it's still referenced" behaviour without writing code, enable the **Enforce** submodule,
which consumes the same handler and adds the deletion protection. The base module has no
configuration, no permissions, and no admin UI; it has no dependencies beyond Drupal core.

This guide is written for a **human** deciding how to set the module up. If you want terse,
token‑cheap references for an AI coding agent — including the handler API and the field-map
service — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   turn on the Enforce submodule if you want deletion protection.

## How to use it

There is nothing to configure. What you do depends on what you want:

- **You want deletion protection out of the box.** Enable the **Entity Reference Integrity
  Enforce** submodule (see [Installation](installation/index.md)). With it on, trying to delete
  an entity that is still referenced by another entity is blocked, with a message explaining it
  is in use. The base module by itself does **not** do this — it only reports.
- **You're a developer building custom behaviour.** Use the base module's API. Every entity
  type gets an `entity_reference_integrity` handler you can fetch from the entity type manager;
  it offers `hasDependents()`, `getDependentEntityIds()`, and `getDependentEntities()` for a
  given entity. A `entity_reference_integrity.field_map` service can also enumerate which
  fields reference a particular entity type. From there you can power a "used by" report, a
  pre-delete guard, or your own enforcement rules. Full method signatures are in the
  [`agent/`](agent/start.md) docs.

Note that the dependency queries deliberately run without access checks — the module *reports*
every reference regardless of who can see it — so treat the results as complete rather than
filtered to the current user.
