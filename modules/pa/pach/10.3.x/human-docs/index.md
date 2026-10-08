# pluggable Access Control Handler (pACH) — manual setup guide

**pluggable Access Control Handler** (`pach`) is a **developer** module. It lets
your modules influence any entity type's access checks through small **access
plugins**, instead of the two heavier options Drupal normally gives you:
implementing `hook_entity_access()` (limited in what it can do) or replacing an
entity's access control handler class (invasive, and only one module can win).

It works by decorating core's entity type manager so that every entity type which
defines an access control handler is swapped for pACH's own handler. That handler
gathers all the access plugins registered for the entity type and lets each one
contribute to the access decision for the `access`, `createAccess`, and
`fieldAccess` operations. Several modules can therefore each add rules to the same
entity type, and the results combine using Drupal's normal access‑result
semantics (allowed / forbidden / neutral).

Access plugins are plain classes: you define one with the `AccessControlHandler`
attribute (or annotation), extend `AccessControlHandlerBase`, and override
`access()`, `createAccess()`, and/or `fieldAccess()`. Each method receives the
running access result by reference, along with the entity, operation, and account,
so you adjust the decision in code. The bundled `pach_examples` submodule shows
working block and node examples.

One thing to keep in mind: pACH itself provides **no** access plugins, routes,
permissions, or configuration — it is pure infrastructure. Because a plugin can
both grant and deny access, a poorly written plugin could unintentionally broaden
access to an entity type. Treat your custom access plugins as security‑sensitive
code and review them accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and (optionally)
   the examples submodule.

There is **no configuration page** for this module. It has no UI: you extend
access control entirely in code by writing access plugins, as outlined below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In a custom module, create an access plugin class annotated with the
   `AccessControlHandler` attribute, extending `AccessControlHandlerBase`, and
   override `access()`, `createAccess()`, and/or `fieldAccess()` to shape the
   access decision for your target entity type.
3. Study the `pach_examples` submodule for reference block and node plugins, then
   clear caches so your plugin is discovered.
