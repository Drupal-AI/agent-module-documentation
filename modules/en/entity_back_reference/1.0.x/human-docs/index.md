# Entity Back Reference — manual setup guide

**Entity Back Reference** (`entity_back_reference`) is a small **developer library**
that answers the question "what points at this entity?" Drupal's entity API makes it
easy to go *forwards* — given an entity, `referencedEntities()` tells you what its
reference fields point to. This module provides the *reverse*: given an entity, it
finds all the other entities whose entity-reference fields point back at it.

For example, imagine a custom block A that has been referenced from a second block
type B and from your *Basic page* content type. With this module you can ask, "which
entities reference block A?" and get back the list of B blocks and Basic page nodes
that include it via a reference field. That is useful for building "referenced by"
panels, running integrity checks, or warning an editor before they delete something
that other content still depends on.

It works by exposing a single service, `entity_back_reference.back_reference_finder`,
with two methods: `getReferencingFieldList()` discovers which reference fields could
target the given entity type/bundle (using Drupal's field map), and
`loadBackReferencedEntities()` loads the entities that actually reference a given
target. Results are cached per field+target within the request to avoid re-querying.

This is a code-only building block: it has **no UI, no admin page, no routes, and no
configuration**, and it defines no permissions. It works on Drupal 9 and 10 and
depends only on core's entity and field APIs.

One thing consuming code must handle: the lookup query runs with access checking
turned off and returns fully loaded entities, so **the caller is responsible for
re-applying entity access** before showing any results to end users. On its own the
module exposes nothing to visitors — this only matters for the code you write on top
of it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — you use it from code by
fetching or injecting its service, as described above. See the module's README for
example code.

## Where it lives in the admin menu

Nowhere — the module adds no admin page, menu item, or settings form. It only
provides the `entity_back_reference.back_reference_finder` service for other modules
and custom code to call.
