# Configure the `glossify_commerce_product` filter

Enable on a text format at `/admin/config/content/formats` → tick **"Glossify: Tooltips with commerce
product"** → set options. Stored in `filter.format.<format>` →
`filters.glossify_commerce_product.settings`. **Note:** unlike the node/taxonomy filters, the keys are
**not prefixed**.

## Settings keys (schema `filter_settings.glossify_commerce_product`)

| Key | Default | Meaning |
|---|---|---|
| `case_sensitivity` | `true` | Case-sensitive matching. |
| `first_only` | `false` | Link only first occurrence per field. |
| `ignore_tags` | `""` | Comma-separated tags to skip. |
| `glossify_type` | `tooltips` | `tooltips` \| `links` \| `tooltips_links` (**required**). |
| `tooltip_truncate` | `false` | Truncate tooltip to 300 chars. |
| `bundles` | `NULL` | Source product types — **required when enabled**. `;`-joined type-id string. |
| `urlpattern` | `/product/[id]` | Link URL; `[id]` → product id. |
| `synonyms_field` | `""` | Text (plain) field on products whose values also match. |

`bundles` is checkboxes persisted as a semicolon-joined string; empty selection fails validation when
the filter is on.

## Term source (`process()`)

Queries `commerce_product_field_data` (alias `cpfd`): `status = 1`, `type IN (selected)`, current
`langcode`, left-joined to `commerce_product__body` (alias `cpb`) for tooltip text. Query tag
`glossify_commerce_product_tooltip` (`hook_query_glossify_commerce_product_tooltip_alter()`). Cache
tags `commerce_product:<id>` are added.

## Configure via drush (example)

```php
$f = \Drupal\filter\Entity\FilterFormat::load('basic_html');
$f->setFilterConfig('glossify_commerce_product', [
  'status' => TRUE,
  'settings' => [
    'glossify_type' => 'links',
    'bundles' => 'default',                 // ;-joined product type ids
    'urlpattern' => '/product/[id]',
    'case_sensitivity' => FALSE,
  ],
]);
$f->save();
```

Read back: `drush cget filter.format.basic_html filters.glossify_commerce_product`.
