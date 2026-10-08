# Backend Utils (butils) — manual setup guide

**Backend Utils** (`butils`) is a developer utility library. It bundles a large
collection of frequently reused backend helper functions into one service and a
Twig extension, so your own code and templates can call them instead of you
rewriting the same snippets on every project. It is aimed at developers — there is
no admin UI, no settings page, and no user-facing feature.

The helpers are grouped by topic across roughly thirty traits, all reached
through a single service: arrays (nested lookups by dotted path), CSV load and
write, timezone-aware date conversion, entity helpers (get-or-create, dereference
a value by path, build and render in a view mode, count words), field helpers,
file, image style, media, menu, paragraphs, redirects, SQL, state, string,
taxonomy, safe HTML truncation, URI, user, Views, JSON/JSON:API, and XML. It also
adds a `json_metadata` field type for storing arbitrary JSON on an entity, a Twig
extension exposing helpers to templates, and a `node_save` hook that fires on
every node insert and update so other modules can react to node saves uniformly.

Because it is a code-level dependency, it has no routes, no permissions, and no
request-facing surface — the helpers only ever act on data your own code passes
in. It targets Drupal 10.1 and 11.

This guide is written for a **human** getting the module in place. If you want a
terse, token-cheap reference for an AI coding agent — including the full trait and
method map — read the sibling [`agent/`](../agent/start.md) docs (see especially
[`agent/api/traits.md`](../agent/api/traits.md)).

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Backend Utils has no admin pages, no configuration form, and no
permissions. It is installed to be used from code, not clicked.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. From your own module or theme code, call the service:

   ```php
   $butils = \Drupal::service('butils');
   // or type-hint Drupal\butils\BUtils in a service that receives it injected.
   ```

3. Use the grouped helpers — for example `arrayMap()` for nested array lookups,
   `loadCsv()` / `writeCsv()` for CSV, `toEntity()` and `deref()` for entities,
   or the `json_metadata` field to store arbitrary JSON on an entity.
4. In Twig templates, the bundled `butils.twig_extension` exposes helpers so you
   can call them directly in your templates.

See [`agent/api/traits.md`](../agent/api/traits.md) for the full list of traits
and method names.
