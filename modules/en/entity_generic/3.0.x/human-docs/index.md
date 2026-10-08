# Entity Generic — manual setup guide

**Entity Generic** (`entity_generic`) is a **developer/framework module**: a set of
extra, reusable building blocks for Drupal's core Entity system. It provides base
classes, traits, and helper utilities that reduce the boilerplate you'd otherwise
write when defining your own custom content entity types.

If you build custom entities regularly, you know how much repetitive scaffolding
each one needs. This module aims to factor that out into shared, reusable pieces you
extend from, so a new entity type takes less code. It builds on the contributed
**Entity API** module (`entity`) and supports Drupal 9, 10, and 11.

**Please note:** the maintainers describe these features as **experimental and not
for production use** — the work is in progress. Treat it as a toolkit to explore in
development rather than something to depend on for a live site.

There is **no UI, no admin page, and no configuration** — it's consumed entirely
from module code. It provides its own permissions for the entity operations its
helpers support, but there's nothing to configure through a form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in Entity
   API, and enable the module.

There is **no configuration page** — this is a code library for developers, not a
settings form.

## How to use it

Use it from your own custom module: extend the base classes and traits it provides
when defining a custom content entity type, so you write less scaffolding. Because
it's experimental, pin it carefully and test in development before relying on it.
