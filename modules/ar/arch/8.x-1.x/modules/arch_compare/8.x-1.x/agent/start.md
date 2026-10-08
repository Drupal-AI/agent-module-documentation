<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Compare (arch_compare) — agent index

Side-by-side **product comparison** for Arch. Package `Arch`. Depends on `arch_product`. Core
`^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x` (installed `8.x-1.0-alpha26`).
Uses `field_group` for grouping compared fields. One permission, config object + schema.

## How it works (from source)

- **Opt-in per product type** — `arch_compare_form_product_type_edit_form_alter()` adds a
  *Comparable* checkbox (third-party setting `arch_compare.comparable`) to the product-type form.
- **Compare action field** — `hook_entity_extra_field_info()` exposes a `compare_item` display
  component on comparable bundles; `hook_entity_view()` renders it as `#theme => 'compare_item'`
  (a checkbox with `data-pid` / `data-title` / `data-url`) and attaches `arch_compare/compare_item`.
- **Block** — `Plugin/Block/CompareBlock` + `#theme => 'compare_block'`: the running selection and a
  link to the compare page.
- **Client-side selection** — JS libraries (`assets/js/compare-*.js`): `compare_storage`,
  `compare_selectors`, `compare_item`, `compare_block`, `compare_products`. Selection lives in the
  browser, passed to the page as `?products[]=…`.

## Routes & permission

- `arch_compare.compare_page` — `GET /compare-products` (`Controller\CompareController::page`),
  `_permission: 'access content'`. Reads `products` from the query, trims to `limit` (redirecting if
  over), keeps only ids whose bundle is comparable, requires ≥2, and renders `#theme =>
  'compare_page'`. Caches per url + product cache tags.
- `arch_compare.compare.config` — `/admin/store/settings/compare` (`Form\CompareConfigForm`),
  `_permission: 'administer compare'` (menu under *Store settings*).

## Config

- Object **`arch_compare.settings`** (schema `arch_compare.schema.yml`): `limit` (int, default `2`),
  `view_mode` (default `compare`), `compare_selection_preservation_time` (int). Install default in
  `config/install/arch_compare.settings.yml`. Also ships view mode `product.compare`.

## Rendering (`arch_compare.module`)

- `template_preprocess_compare_page()` + `_arch_compare_product_build_table_rows()` build a
  `#type => table`: header = product titles; rows grouped by `field_group` groups
  (`_arch_compare_get_product_group_structure()` → `field_group_info_groups()`); each field rendered
  via `$product->get($field_name)->first()->view($view_mode)`. Rows get `same-values` /
  `different-values` / `empty-values` / `empty-group` classes.

## Theme hooks

`compare_item`, `compare_page`, `compare_block` (templates in `templates/`).
