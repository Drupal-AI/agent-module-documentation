<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Combine (views_combine) — agent index

Joins two or more Views into a single display by building ONE SQL `UNION` query from
their compiled queries. Unlike a plain UNION, it normalizes columns (pads missing columns
with `NULL`, aligns positions) and order fields, so the constituent views need not already
share a base table or column shape. Add a **Global: Views combine** field to a base view,
point it at another `view:display`, and its rows are unioned in.

- Depends on core `views` only. Core requirement `^10 || ^11`.
- No settings page, no routes, no permissions, no drush, no new plugin types.
- Newest release is **1.0.0-alpha5** (no stable release on the `1.0.x` branch yet).

What you'd do:
- **Combine views / set it up, handler options, caching, styles, limits** → [views/combine.md](views/combine.md)
- **Understand the runtime pipeline (hooks + `ViewsCombiner`), or support a new display style** → [api/extend.md](api/extend.md)

Key facts:
- Registered on the `views` table (`hook_views_data`) under key `views_combine` as a field,
  filter, and sort handler; plugin id `views_combine` for all three.
- Field handler `\Drupal\views_combine\Plugin\views\field\Combine` (`@ViewsField("views_combine")`),
  option `view_id` (the `view:display` to combine) plus `filter_map`/`sort_map`.
- Filter handler `...\filter\Combine` extends `InOperator` — include/exclude combined views;
  expose options `default_views`, `all_views`, `view_labels`.
- Sort handler `...\sort\Combine` — orders rows by the sequence in which views were combined.
- Cache plugin id `combine_tags`, title "Tag based (views combine)"
  (`\Drupal\views_combine\Plugin\views\cache\CombineTags`).
- Style overrides via `hook_views_plugins_style_alter`: `default` and `views_bootstrap_grid`
  gain `CombineStyleTrait`.
- Core class `\Drupal\views_combine\ViewsCombiner` (plain class, instantiated in hooks — not a service).
- Config schema key `views.filter.views_combine` (extends `views.filter.in_operator`).
- Row marker column `_view_id`; normalized order aliases `_order_#`; combine-sort alias `_combine_sort`.
