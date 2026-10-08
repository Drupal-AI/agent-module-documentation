# Entity expand — manual setup guide

**Entity expand** (`entity_expand`) is a small **developer utility**, not a
point-and-click feature. It wraps a loaded Drupal entity in a lightweight
decorator (`EntityExpandBase`) so you can hang your own per-entity-type methods on
it and use a set of fluent field helpers — without subclassing core's entity
classes.

The idea is that a lot of logic naturally "belongs to" an entity but ends up
scattered across procedural hooks and helper functions. With this module you write
an expand class for, say, users (`UserExpand`) with domain methods like
`newname()`, register it via `hook_entity_expand_load()`, and then call
`entity_expand_load(User::load(1))->newname()`. The base wrapper also adds
convenience helpers — `setValues([...])`, `get()`, `bundleKey()`, and field-item
helpers such as `val()`, `ref()`/`refs()`, `targets()`, `listTextLabel()` and
`view()` — so reading references and list labels reads fluently in code.

There is **no UI, no admin page, no permission and no configuration** — this is
purely an API for module code. It wraps entities you have already loaded, so it
applies no access checks of its own: whatever access you enforced when loading the
entity still applies, and access control remains your responsibility. It supports
Drupal 8 through 11 and needs PHP 7 or 8, with no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — this module ships an API for developers, not
a settings form. See "How to use it" below for the code entry points.

## How to use it

Everything happens in your own module's PHP:

1. Create an expand class extending `EntityExpandBase`, e.g.
   `src/EntityExpand/UserExpand.php`, and add your domain methods.
2. Implement `hook_entity_expand_load($entity, $entity_type_id)` in your module to
   return the right subclass for a given entity type. If no hook returns a
   wrapper, `entity_expand_load()` falls back to the base `EntityExpandBase`.
3. Call `entity_expand_load(User::load(1))` (or `_entity_load('node', 42)` to load
   and wrap in one step — pass `$unchanged = TRUE` for `loadUnchanged()`), then
   call your methods or chain field helpers like
   `$node->field_ref->ref()->yourMethod()`.

Because the wrapper does no access checking, apply access when you load the entity.
The [`agent/`](../agent/start.md) docs include a compact API reference.
