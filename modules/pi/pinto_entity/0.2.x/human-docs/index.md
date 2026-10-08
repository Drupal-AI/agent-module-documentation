# Pinto Entity — manual setup guide

**Pinto Entity** (`pinto_entity`) lets you take over the rendering of **entities**
using [Pinto](https://www.drupal.org/project/pinto) components. Wherever Drupal uses
its standard entity view handler — a node's canonical route, an entity reference
field, a View row, and so on — Pinto Entity can route that rendering through a typed
Pinto component instead of the usual render pipeline. It is for developers who want a
consistent, object-oriented, component-driven approach to how their entities display.

Like the rest of the Pinto family, this is a **developer and theming tool**. It has
no content of its own and no access-control role; entity access continues to be
enforced by Drupal core exactly as before. It simply changes *how* a permitted entity
is built for display, moving that logic into a Pinto component object.

Because it builds on Pinto, it depends on the base `pinto` module and, through it, the
Pinto PHP library. The actual work of adopting it happens in your own code — defining
the components and wiring them to your entity view modes — so keep the official Pinto
documentation at <https://pinto.docs.contrib.social/> nearby.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — Pinto Entity is a code-first developer tool with
no admin settings form. You adopt it by writing Pinto components and wiring them to
your entity displays in code.

## How to use it

At a high level, you build a Pinto component (as you would with the base Pinto
module) and arrange for your entity's rendering to be delegated to it, so the entity's
display is assembled in typed PHP rather than through preprocess hooks and templates.
This applies uniformly across the places Drupal renders entities — routes, entity
reference, and Views. After adding or changing component code, clear the cache
(`drush cr`) so Drupal discovers it. See the [official Pinto Entity documentation](https://www.drupal.org/project/pinto_entity)
for the exact wiring.
