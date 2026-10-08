# Route Condition — manual setup guide

**Route Condition** (`route_condition`) adds a single Drupal condition plugin (id
`route`) that evaluates to true or false based on the **name of the active route**.
It is the route-name counterpart to core's "Pages" condition: where "Pages" matches
URL path patterns, Route Condition matches machine route names such as
`entity.node.canonical`, `user.login`, or `system.404`.

Why bother with route names? Because they are stable. A URL path can change when an
editor edits an alias, but the route name behind it does not — so a block placed
"only on node pages" keeps working. Route names are also more precise: you can target
*all* entity canonical pages, or *only* the login form, without wrestling with regex
path patterns.

Because it is an ordinary condition plugin, it shows up wherever Drupal uses
conditions: the **Visibility** tab when you place or edit a block, the Context
module, or any code that uses the condition plugin manager. It supports two operators
per line — a `*` wildcard (so `entity.*.canonical` matches every entity's canonical
view route) and a leading `~` tilde to exclude a route — and it honours the standard
"Negate the condition" checkbox. There is no settings form of its own, no
permissions, and no Drush.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Route Condition has **no admin page of its own**. You use it inside another
feature's condition UI — most commonly the block placement form at **Structure →
Block layout** (`/admin/structure/block`), under the block's **Visibility → Route**
tab.

## How to use it (block visibility)

1. Go to **Structure → Block layout** and place or edit a block.
2. Open the **Visibility → Route** vertical tab.
3. Enter one route name per line. Save.

The rules you can write:

| Line | Meaning |
|---|---|
| `entity.node.canonical` | Exact match — this route only. |
| `entity.*.canonical` | The `*` is a wildcard; this matches every entity's canonical page route. |
| `~user.login` | A leading `~` **excludes** this route. |

A few behaviours to keep in mind:

- Matching is **case-insensitive**, and empty lines are ignored.
- If you leave the box **empty**, the condition matches **everywhere**.
- Lines are checked in order and the **first match wins**.
- The standard **Negate the condition** checkbox flips the whole result — so you can,
  for example, show a block *everywhere except* a set of routes.

The result is stored in the block's own configuration, for example:

```yaml
# block.block.<block_id>
visibility:
  route:
    id: route
    negate: false
    routes: |-
      entity.node.canonical
      entity.*.canonical
```

Read it back with `drush cget block.block.<id> visibility.route`.

Because it is a standard condition plugin, developers can also use it
programmatically via the `plugin.manager.condition` service with plugin id `route`,
or drive Context module reactions by active route name.
