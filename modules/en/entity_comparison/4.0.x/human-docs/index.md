# Entity Comparison — manual setup guide

**Entity Comparison** (`entity_comparison`) lets your visitors build a personal
"compare these" list from any content entity bundle — products, plans, courses,
devices, property listings — and view the chosen items side by side in a table at
`/compare/{id}`. It is the classic "add to compare" feature you see on shopping
and catalogue sites, and it works for nodes, taxonomy terms, media, or any other
content entity type.

You define one or more **comparisons** through the admin UI. Each comparison
targets a specific entity type and bundle, sets the text of the *add* and *remove*
links, and can cap how many items a visitor may add (to keep the table readable).
Saving a comparison automatically scaffolds everything it needs: a dedicated **view
mode** (so you choose exactly which fields appear in the table and in what order),
an add/remove link you can drop into any view mode, a Views field, two ready‑made
blocks, and its own permission. You can run several independent comparison lists
on one site — laptops and phones, say — each with its own page and permission.

Comparison lists live entirely in the visitor's **session** — nothing is stored
per user in the database — so each browser has its own list and it clears when the
session ends. This means anonymous visitors can compare items without an account.
The module has no other module dependencies. Developers can add or rewrite rows
via `hook_entity_comparison_rows_alter()`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a comparison, choose which
   fields it shows, place the add/remove link, and grant the permission.

## Where it lives in the admin menu

Manage comparisons at **Structure → Entity comparison**
(`/admin/structure/entity_comparison`). Each comparison's fields are chosen from
the target bundle's **Manage display** tab (in the view mode named after the
comparison), and its add/remove links are placed via Manage display, Views, or
Block layout.
