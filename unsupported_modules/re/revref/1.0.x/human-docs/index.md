# Reverse Reference — manual setup guide

**Reverse Reference** (`revref`) fixes a well-known blind spot in Drupal's entity
model. Entity references only point one way: a node that references a taxonomy term
knows about the term, but the term has no built-in way to discover which nodes
reference it. Reverse Reference gives you that missing direction — reliably,
efficiently, and (crucially) with **correct render-cache behaviour**.

It offers several complementary pieces:

- A **lookup service** (`reverse_reference.lookup`) with `findReferencers()` and
  `countReferencers()` methods for use in custom modules, hooks, preprocess
  functions, and Drush scripts. You scope each call by entity type, bundle, and
  optionally which fields to search, and it always returns correct results —
  using its fast index when available and transparently falling back to an
  `entityQuery` when not.
- **Computed field plugins** — add a *reverse entity reference* or *reverse entity
  reference count* field to any entity type without writing code. These integrate
  natively with the Entity API, Views, JSON:API, and the field formatter system.
- An **asynchronous performance index** written to a dedicated database table by a
  queue worker after each entity save, so lookups become a single indexed read
  rather than a full query scan. The index is purely a performance optimisation —
  correctness never depends on it.
- **Events** (`ReverseReferenceChangedEvent`, `ReverseReferenceIndexedEvent`) you
  can subscribe to for secondary work such as search re-indexing, webhooks, or
  audit logging.

Two design choices are worth knowing. First, every lookup call requires you to
pass an explicit `access_check: TRUE` or `access_check: FALSE` — there is no silent
default, so presentation-layer code stays honest about access. Second, during
migrations or bulk imports you can set the `revref.defer_indexing` state flag to
avoid flooding the queue, then run `drush revref:rebuild` once when you are done.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no central settings form**. Its defaults live in
`revref.settings.yml` (most importantly `index_entity_types`, the list of entity
types included in the async index), which you review through your configuration
management workflow. The rest of the setup is done in code and on individual
fields, as described below.

## How to use it

**As a computed field (no code):** on the entity type that should expose its
back-references, go to **Manage fields**, add a *Reverse entity reference* (or
*Reverse entity reference count*) field, and configure which references it should
track. It then behaves like any other field in Views, JSON:API, and Manage
display, with cache tags bubbled correctly to the parent render array.

**From code:** call the lookup service, always passing an explicit access-check
choice:

```php
$lookup = \Drupal::service('reverse_reference.lookup');

// Entities that reference $term, with access checking on (presentation code).
$referencers = $lookup->findReferencers($term, ['access_check' => TRUE]);

// A count, with access checking off (system-level code, documented intent).
$count = $lookup->countReferencers($term, ['access_check' => FALSE]);
```

**During migrations/bulk imports:** set the `revref.defer_indexing` state flag to
suppress queue flooding, then rebuild the index cleanly afterwards:

```bash
drush revref:rebuild
```
