# Entity Repository — manual setup guide

**Entity Repository** (`entity_repository`) is a **developer tool**, not a
click‑through feature. It provides base repository service classes you extend so
that entity queries live in a named service — `NewsRepository::findAll()` — instead
of being copied, slightly differently each time, across controllers, blocks and
forms. Its own README puts it plainly: *"This module won't do much by itself.
Extend the base classes and create your own repository classes."*

The problem it addresses is familiar in any codebase past a certain size. The same
`getStorage('node')->getQuery()->condition(...)` appears in three places, each
copy subtly different and each at risk of forgetting `accessCheck()`. The
repository pattern puts that query behind a method with a name, defined once,
tested once, and injected where it is needed. Entity Repository supplies the base
classes (such as a node repository with common queries like `findAll()`) and the
service pattern to build on. It has **no dependencies, no routes, no permissions
and no configuration UI**.

You wire it up in code: declare a service with `parent:
entity_repository.repository.node`, set the `$bundles` property to constrain
results to your bundle, and add the domain queries you actually need — or, for the
simple case, use the base class directly and call `setBundles()`/`setVocabularies()`
from the service definition without writing a repository class at all. An
**entity_repository_example** submodule ships a worked example of the shape.

One thing to be deliberate about: centralising queries is a chance to get
`accessCheck(TRUE)` right in one place — and equally a chance to get it wrong in
one place everything then inherits. Decide per method whether it returns *what
the current user may see* or *what exists*, and make that distinction explicit in
the method name.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and optionally the example submodule).

There is **no configuration page** — this module is used entirely from code, by
extending its base classes as shown in the module's own README.

## Where it lives in the admin menu

Nowhere. Entity Repository adds no admin pages, permissions or settings. It is a
service‑layer library that other custom modules build on.
