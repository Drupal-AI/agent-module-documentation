<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Title HTML for Commerce (commerce_title_html) — agent index

Submodule of **title_html**. Extends HTML titles to three Commerce entity types:
`commerce_product`, `commerce_product_variation`, `commerce_store`. Package **@fields**.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir **2.x** (installed 2.1.3).
Declared dependency: **`title_html:title_html`**; functionally also needs **commerce_product** and
**commerce_store** (field storages enforce them).

## What it provides (from source)

All logic is procedural in `commerce_title_html.module`, plus three config-entity classes. **No
routes, no permissions, no services, no settings form, no Drush.**

- **Config entities** (`src/Entity/`, all `ConfigEntityBase`, admin permission
  `administer site configuration`, keys `id` + `html_title_field`):
  `product_type_settings` (`CommerceProductTypeSettings`),
  `product_variation_type_settings` (`CommerceProductVariationTypeSettings`),
  `store_type_settings` (`CommerceStoreTypeSettings`). Each `::load($id)` returns an existing
  entity or an in-memory blank one.
- **Config schema** (`config/schema/commerce_title_html.schema.yml`): defines
  `commerce_product_type_settings.*` and `commerce_product_variation_type_settings.*` (the
  `store_type_settings` schema is absent).
- **Field storages** (`config/install/`): `commerce_product.title_html`,
  `commerce_product_variation.title_html`, `commerce_store.title_html` — each `text_long`,
  cardinality 1, translatable.
- **Entity map:** `commerce_title_html_commerce_entity_info()` maps each entity type to its
  bundle-entity type and settings-entity class.

## How it works (from source)

- **Enable/disable per bundle:** `commerce_title_html_form_alter()` (on the bundle edit form,
  operation `edit`) adds an *Enable Title HTML Field* checkbox;
  `commerce_title_html_content_type_form_submit()` calls the parent module's
  `CopyTitle::createTitleHtmlField($entity_type, $bundle)` / `deleteTitleHtmlField()`, sets the
  `text_textarea` widget on the default form display, removes the plain title component, batch-runs
  `CopyTitle::copyTitles` (format `title`), and stores the field name on the settings entity.
- **Render sink (per entity type):** `commerce_title_html_preprocess_field__commerce_product__title`,
  `…__commerce_product_variation__title`, `…__commerce_store__title` each set
  `content['#context']['value'] = Markup::create(check_markup($field->value, $field->format))` with
  template `{{ value }}` — identical to the parent's node-title mechanism, filtered by the field's
  text format.
- **Plain-text sync:** `commerce_title_html_entity_presave()` writes a
  `html_entity_decode(strip_tags($value))` copy back onto the entity — `setName()` for
  `commerce_store`, `setTitle()` for product/variation — so storefront metadata and admin lists
  stay plain.
- **Cleanup:** `commerce_title_html_field_config_delete()` clears the settings entity's
  `html_title_field` if the field is deleted.

## Solution docs

- Per-type enablement, config entities, field storages, and the render mechanism →
  [fields/commerce-titles.md](fields/commerce-titles.md)
- Shared text-format selection and the `title` format → see the parent module docs
  (`../../2.x/agent/config/settings.md`). This submodule reuses `title_html.settings` and
  `CopyTitle`.
