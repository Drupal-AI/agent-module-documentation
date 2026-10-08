# CacheRefs — manual setup guide

**CacheRefs** (`cacherefs`) keeps referenced content from going stale. When you save a
node that points at other nodes through entity-reference fields, CacheRefs invalidates
the cache tags of those referenced nodes, so any page displaying them re-renders with
the fresh relationship. It fires on node insert, update, and delete.

This fills a gap Drupal's default cache tags can sometimes leave: when a page's
display depends on a node that references it (or that it references), core's own cache
tags may not cover the relationship, and the page can keep showing outdated
information until caches are cleared manually. CacheRefs closes that gap
automatically. It only looks at entity-reference fields whose machine name starts with
`field_`, and invalidates the `node:<id>` cache tag of each referenced node.

It is a pure **Performance / cache-correctness** module — it changes when cached pages
are rebuilt, not who can see them. Best of all, there's nothing to set up beyond
enabling it: as the module's own help says, "Install the module and it does the rest."
There is no settings form, no routes, and no permissions.

The module works on Drupal 8, 9, and 10.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — CacheRefs has no settings form, routes, or permissions. Its effect is
automatic once the module is enabled.

## How to use it

Enable the module and you're done. From then on, whenever a node is created, updated,
or deleted, the cache tags of the nodes it references through `field_`-prefixed
entity-reference fields are invalidated, so pages showing those referenced nodes stay
current without any manual cache clears.
