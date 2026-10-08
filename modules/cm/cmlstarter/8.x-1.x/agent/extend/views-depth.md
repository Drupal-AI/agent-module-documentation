<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML Starter — product taxonomy depth argument & filter

CML Starter registers a Views argument and filter, both id `taxonomy_index_tid_product_depth`, exposed on `commerce_product_field_data` as *"Product has taxonomy term ID (with depth)"* (see `cmlstarter.views.inc` → `hook_views_data_alter`).

## Why
Core's taxonomy depth handlers rely on the `taxonomy_index` table, which is node-only. These handlers instead build a **subquery against the product reference field's own table** (`commerce_product__<reference_field>`, column `<reference_field>_target_id`) and join `taxonomy_term__parent` to walk the hierarchy — so no taxonomy_index equivalent is needed for products.

## Options
- **Reference field** (`reference_field`, default `field_product_category`): machine name of the entity-reference field on the product type that points at the taxonomy.
- **Depth**: positive matches descendants of the given term; negative matches ancestors; `0` matches the term only.
- **Break phrase / multiple values** (argument): `1+2+3` treats multiple TIDs as OR.

## Handler classes
- Argument: `src/Plugin/views/argument/IndexTidProductDepth.php` (extends core `IndexTidDepth`).
- Filter: `src/Plugin/views/filter/TaxonomyIndexProductTidDepth.php` (extends core `TaxonomyIndexTid`; only the "Is one of" / OR operator).

## Notes
- `hook_views_plugins_argument_validator_alter` retitles `entity:taxonomy_term` to "Taxonomy term ID" and swaps its validator class to taxonomy `TermName`.
- Subquery table/column names come from the admin-set `reference_field` machine name, not from request input.
