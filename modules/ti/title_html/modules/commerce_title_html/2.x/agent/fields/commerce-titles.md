<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Title HTML for Commerce — per-type titles and render mechanism

Everything is in `commerce_title_html.module` plus three config-entity classes in `src/Entity/`.
The submodule reuses the parent module's `Drupal\title_html\CopyTitle` helpers and the shared
`title_html.settings:title_text_format` (and the bundled `title` text format).

## Supported entity types

`commerce_title_html_commerce_entity_info()` returns the map:

| entity type | bundle entity type | settings entity class |
|---|---|---|
| `commerce_product` | `commerce_product_type` | `CommerceProductTypeSettings` |
| `commerce_product_variation` | `commerce_product_variation_type` | `CommerceProductVariationTypeSettings` |
| `commerce_store` | `commerce_store_type` | `CommerceStoreTypeSettings` |

## Config entities (per-bundle on/off state)

Each is a `ConfigEntityBase` (`admin_permission: administer site configuration`, `config_export`
= `id`, `html_title_field`). `::load($id)` returns the stored entity or a transient blank one so
callers never get NULL. Config prefixes: `product_type_settings`, `product_variation_type_settings`,
`store_type_settings`. Schema for the first two is in
`config/schema/commerce_title_html.schema.yml`; the store one has no schema entry.

## Enabling on a bundle

`commerce_title_html_form_alter()` fires on any `EntityFormInterface` whose entity type is one of
the three bundle-entity types and operation is `edit`. It adds a **Title HTML Settings** details
group with **Enable Title HTML Field** (default from the settings entity's `html_title_field`) and
prepends `commerce_title_html_content_type_form_submit()`.

On submit, when the toggle changes:

- **Enable:** `CopyTitle::createTitleHtmlField($entity_type, $bundle)` creates the per-bundle
  `title_html` FieldConfig (from the shipped `commerce_*.title_html` storage; `required`,
  `allowed_formats: ['title']`). Then set form-display widget `text_textarea` (weight 0), remove
  the plain `title` component from the form display, remove `title_html` from default/teaser view
  displays, batch `CopyTitle::copyTitles($entity_type, $bundle, 'title')`, and save
  `settings_entity->html_title_field = 'title_html'`.
- **Disable:** `CopyTitle::deleteTitleHtmlField($entity_type, $bundle)` and clear the settings
  entity's `html_title_field`.

`commerce_title_html_field_config_delete()` clears the settings entity if the field is deleted
directly.

## Field storages (`config/install/`)

`field.storage.commerce_product.title_html`,
`field.storage.commerce_product_variation.title_html`,
`field.storage.commerce_store.title_html` — all `type: text_long`, `module: text`, cardinality 1,
translatable, `persist_with_no_fields: true`, enforced-dependency on `commerce_title_html`.

## Render sink

Three preprocess hooks, one per entity type
(`commerce_title_html_preprocess_field__commerce_product__title`,
`…__commerce_product_variation__title`, `…__commerce_store__title`). Each loads the matching
settings entity, and if `html_title_field` is set, replaces every title item with:

```php
$item['content']['#context']['value'] = Markup::create(check_markup($field->value, $field->format));
$item['content']['#template'] = '{{ value }}';
```

So the rendered title is the `title_html` field value run through the text-format filter pipeline,
using the field item's stored format (locked to `title_text_format` by the widget; the copy batch
stores `title`). This is the same mechanism as the parent node-title preprocess.

## Plain-text synchronisation

`commerce_title_html_entity_presave()` runs for the three entity types when the settings entity
has a `html_title_field`. It writes `html_entity_decode(strip_tags($value))` back onto the entity:
`setName()` for `commerce_store`, `setTitle()` otherwise. So the real product title / store name —
used in admin lists, order line items, cart summaries, and page metadata — stays plain text while
the product/store page renders the formatted markup.

## What it does not provide

No settings form (configuration is the per-bundle toggle + the parent's shared text-format
selection), no permissions, no services, no routes, no Drush commands, no CKEditor plugin of its
own (it reuses the parent's widget/format).
