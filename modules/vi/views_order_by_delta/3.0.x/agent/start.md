<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Order By Delta (views_order_by_delta) — agent index

Adds one **Views sort handler** that orders results by a multi-value **entity reference** field's
`delta` (the stored position an editor dragged each value into). Depends only on core `views`. Core
requirement `^8.9 || ^9 || ^10 || ^11`. **Release is 3.0.0-alpha2 — alpha.** No routes, permissions,
config, config schema, or Drush.

## The problem it solves

Views can join to a multi-value field and list the referenced entities, but through a **relationship**
its only sorts are the *referenced entity's* own properties (title, created, id). Its native
`field:delta` sort, used across a relationship, returns rows that `distinct`/`pure distinct` cannot
de-duplicate. This module registers a clean per-field "Order by delta" sort on the entity's base table
that adds `ORDER BY delta` only when the field's table is already joined by the relationship.

## What you'd do → where

- **Add the sort to a view / understand how the handler and its Views-data registration work** →
  [plugins/order-by-delta.md](plugins/order-by-delta.md)

## Key facts (real machine names)

- Whole module is three files: `views_order_by_delta.views.inc` (`hook_views_data()` registration),
  `src/Plugin/views/sort/OrderByDelta.php` (the sort plugin), `views_order_by_delta.module`
  (`hook_help()` only).
- Sort plugin id: **`order_by_delta`** (`@ViewsSort`), class
  `Drupal\views_order_by_delta\Plugin\views\sort\OrderByDelta` extends
  `SortPluginBase`. `usesGroupBy()` returns `FALSE`.
- Registration: for every entity type with a `views_data` handler, each **`entity_reference`** field
  storage whose dedicated data table (`getDedicatedDataTableName()`) has a `delta` column gets a Views
  field keyed `{data_table}__views_order_by_delta` on the entity's **base table**, with
  `title = "Order by delta (using {field})"`, `real field = delta`, `sort.id = order_by_delta`.
- **Scope is `entity_reference` only** — plain multi-value text fields and
  `entity_reference_revisions` (Paragraphs) are NOT registered.
- In a view: add a **relationship** on the reference field (the join to `{data_table}`), then add the
  **sort criterion** "Order by delta (using {field})"; the handler no-ops (adds no ORDER BY) if that
  table is not joined, so the sort is only meaningful with the relationship present.
- Motivating use case (per the maintainer): fixing delta ordering for **Config Pages** referenced
  items, and taxonomy-term → node slideshow ordering.
