<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Compare — settings, block & opt-in

## Install & enable

```bash
drush en arch_compare -y
```

Depends on `arch_product`. Ships install config `arch_compare.settings` (`limit: '2'`,
`view_mode: compare`) and a `product.compare` view mode
(`config/install/core.entity_view_mode.product.compare.yml`).

## Make a product type comparable

Edit the product type (*Structure → Product types → edit*). Arch Compare adds a **Compare settings**
group with a **Comparable** checkbox (`arch_compare_form_product_type_edit_form_alter`). Checking it
sets the `comparable` third-party setting under the `arch_compare` provider on the `product_type`
config entity; unchecking removes it. Only comparable bundles get the compare checkbox and can appear
on the compare page.

## Settings form (`CompareConfigForm`, `/admin/store/settings/compare`)

Permission **`administer compare`**. Editable config: `arch_compare.settings`.

| Key | Control | Meaning |
|---|---|---|
| `limit` | select 2–10 | Max products in the compare queue / page. Saved as int. |
| `view_mode` | select of `product` view modes | View mode used to render each product column on the compare page. |
| `compare_selection_preservation_time` | select (0 = never expire, 1–7 days in seconds) | How long the browser keeps the selection; passed to JS as `max_age`. |

Schema (`config/schema/arch_compare.schema.yml`): `arch_compare.settings` config_object with
integer `limit`, integer `compare_selection_preservation_time`, string `view_mode`.

## The compare block

Block plugin `arch_compare_products_queue_block` (`CompareBlock`) — place it via *Block layout*.
`getCacheMaxAge()` returns 0 (never cached). `build()` renders `#theme => compare_block` linking to
`arch_compare.compare_page` and attaches library `arch_compare/compare_block` plus
`drupalSettings.arch_compare` = `{limit, max_age, selector: {...}}`. The JS
(`compare-storage.js`, `compare-selectors.js`, `compare-block.js`, `compare-item.js`) maintains the
selection in browser storage and syncs the checkboxes.

## Libraries (`arch_compare.libraries.yml`)

`compare_storage`, `compare_selectors`, `compare_item` (checkbox behaviour, depends on storage +
selectors), `compare_block` (block UI + `compare.css`), `compare_products` (compare-page behaviour).

## Compare page rendering

`CompareController::page()` (route `arch_compare.compare_page`, `/compare-products`, permission
`access content`) reads `products` from the query string, enforces `limit` (redirect if exceeded),
keeps only comparable bundles, requires ≥2 products, and renders `#theme => compare_page`.
`template_preprocess_compare_page()` builds a `#type => table`: for each product it walks the
`compare` view mode's field groups (`field_group_info_groups()`), emitting a group-header row then a
`field-value-row` per field (label + each product's `->view($view_mode)` render array). Rows are
post-classed `same-values`, `different-values` or `empty-values`, and empty groups get `empty-group`.

## Theme hooks

`hook_theme` defines `compare_item` (per-product checkbox), `compare_block` (title/list/link
scaffold) and `compare_page` (the table). Templates live in `templates/`.
