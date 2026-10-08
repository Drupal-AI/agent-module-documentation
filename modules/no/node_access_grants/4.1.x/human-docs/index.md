# Node Access Grants — manual setup guide

**Node Access Grants** (`node_access_grants`) is a **developer library**, not a
point-and-click feature. It modernises how custom modules plug into Drupal's node
access grants system. Traditionally you'd implement two procedural hooks —
`hook_node_grants()` and `hook_node_access_records()` — to define which users can
see or edit which nodes. This module lets you express the same logic as a proper
**service class** instead, so bespoke access rules can be written in an
object-oriented, service-oriented style that fits modern Drupal.

It's important to be clear about what this module does and doesn't do.
**Enabling it on its own changes nothing** — there is no UI, no settings form, no
routes, and no permissions. Its value appears only when *another* module you
write depends on it and provides a tagged service. It improves the *ergonomics*
of writing grants; it does not change their *semantics*. Everything that is hard
about node access is still true: grants are **OR-combined across modules** (any
module granting `view` wins), a **node access rebuild** is required after you
change policy — and listings and search results will be wrong until that rebuild
finishes — and mistakes tend to produce **silent over-disclosure**, so grants
code needs tests written specifically to assert what must *not* be visible.

Use it when you are building a custom access module and want cleaner code. If an
existing policy-level module already fits your needs (for example RAC/ADVA,
Access Policy, or Group), prefer that — Node Access Grants is a building block,
not a replacement for a finished access solution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form,
routes, or permissions. It is used from code, described in "How to use it" below.

## How to use it

Node Access Grants defines a single interface,
`NodeAccessGrantsInterface`, that your own module implements. Instead of writing
the two node-access hooks:

1. Make **`node_access_grants`** a dependency of your custom module.
2. Create a service in your module that **implements `NodeAccessGrantsInterface`**
   (covering the logic that would otherwise live in `hook_node_grants()` and
   `hook_node_access_records()`).
3. **Tag that service** with `node_access_grants` so the module picks it up.

After changing any access logic, **rebuild node access permissions** (for example
via **Reports → Status report**, or `drush php-eval 'node_access_rebuild();'`),
and write tests that assert nodes which must stay hidden are in fact hidden.
