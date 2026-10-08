<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Access Grants (node_access_grants) — agent index

Object-oriented wrapper for Drupal's **node access grants** hooks. PHP >= 7.1.
Core requirement `^10 || ^11`. **No routes, permissions, config or UI** — a developer library.

Key facts:
- Whole module: `src/NodeAccessGrantsCollection.php`, `src/NodeAccessGrantsInterface.php`,
  `node_access_grants.services.yml`, `.module`. Enabling it alone changes nothing.
- It improves the **ergonomics** of grants, not their semantics. Everything hard about node access
  remains true:
  - grants are **OR-combined across modules** — another module granting `view` wins;
  - a **node access rebuild** is required after policy changes, and listings/search are wrong
    until it completes;
  - mistakes produce **silent over-disclosure**, so grants code needs tests written specifically
    to assert what must *not* be visible.
- Useful when writing a bespoke access module; not a substitute for one. If a policy-level module
  fits (`rac`/ADVA, `access_policy`, Group), prefer it.

## What you'd do → where

- **Implement grants as a tagged service (the interface, the two methods, the record/grant array
  shapes, and `node_access_rebuild`)** → [api/implement.md](api/implement.md)

## Key facts (real machine names)

- Service: `node_access_grants.collection` (`Drupal\node_access_grants\NodeAccessGrantsCollection`),
  a `service_collector` on tag `node_access_grants`, method `addImplementation`.
- Interface to implement: `Drupal\node_access_grants\NodeAccessGrantsInterface` — methods
  `accessRecords(NodeInterface $node)` (→ `hook_node_access_records`) and
  `grants(AccountInterface $account, $op)` (→ `hook_node_grants`).
- The two hooks live in `node_access_grants.module`; each just forwards to the collection service.
- The collection `array_merge`s the return of every tagged implementation — no priority/dedup logic
  of its own. Tag your service `{ name: node_access_grants }` to be collected.
