<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# synhelper — services

Declared in `synhelper.services.yml`. All are `@internal` helpers for Synapse/Commerce sites.

## synhelper.content_exporter — `Service\ContentExporter`
Args: `@entity_type.manager`. Exports content entities to a plain array keyed by UUID.
- `exportAll($entity_type_id, $bundle = '')`: entity query with `accessCheck(TRUE)`, restricted by bundle;
  taxonomy terms are ordered root-first. Rejects non-content entity types.
- `export(ContentEntityInterface $entity)`: serializes fields, skipping id/langcode/uid/created/changed;
  maps entity_reference target ids to UUIDs, image fields to filename, path fields to alias; collapses
  single-value/single-property items. Special handling for `commerce_*`, `commerce_product`,
  `commerce_product_variation`, `commerce_product_attribute_value` and `taxonomy_term`.

## synhelper.content_importer — `Service\ContentImporter`
Args: `@entity_type.manager`. Inverse of the exporter; upserts entities by UUID.
- `onInstall($path, $content)` / `importAll($entity_type_id, $bundle)`: reads
  `<contentPath>/<entity_type>[.<bundle>].yml` (`buildFilepath()`), decodes YAML, calls `importEntity()`.
- `importEntity($entity_type_id, array $values)`: loads existing entity by UUID or creates one; resolves
  reference UUIDs back to ids; `ensureFile()` copies a named image from `<contentPath>/files/<filename>` into
  `public://`; `ensureStore()` creates a default Commerce store if none exists. Runs from install/CLI, not the
  web front end.

## synhelper.yandex_ecommerce — `Service\YandexEcommerceBuilder`
Args: `@config.factory`. Builds Yandex Ecommerce dataLayer payloads from Commerce entities.
- `isEnabled()` / `isEventEnabled($event)` / `isDebugEnabled()`: read `synhelper.settings` (`ya-ecommerce`,
  `ya-ecommerce-events`, `debug`). Default event set: impressions, click, detail, add, remove, purchase.
- `buildSettings()`: the `drupalSettings.synhelper.ecommerce` payload attached in `hook_page_attachments()`.
- `buildProductFromVariation()/buildProductFromProduct()/buildProductFromOrderItem()`: product data (id, name,
  category `field_catalog`, brand `field_tx_brand`, variant, price, quantity).
- `buildPurchase(OrderInterface $order)`: `currencyCode`, `actionField` (order number, revenue, shipping),
  `products`. Falls back to `RUB` when no total price.
Consumed by `synhelper.module` hooks `page_attachments`, `library_info_alter`, `syncart_variation_alter`.

## synhelper.contact_message_normalizer — `Service\ContactMessageNormalizer`
Args: `@email.validator`. Fills empty base fields on a `contact_message` before save; never overwrites filled
values. Called from `hook_contact_message_presave()` (via `Hook\ContactMessagePresave`).
- `normalize(MessageInterface $entity)`: mail → name → subject → message.
- Mail from `field_email`, the single email-typed field, or `field_contact` (validated with the injected
  email validator). Name from `field_name` or the mail local-part. Subject from the contact form label or a
  translatable fallback. Message from `field_message`/`field_details`/`field_comment`/`field_description` or a
  `-` placeholder. Bundle-agnostic (no hard-coded bundle machine names).

## Utility\AjaxResult (`src/Utility/AjaxResult.php`)
Static AJAX helpers: `ajax()` returns an `AjaxResponse` with an `HtmlCommand`; `button()` / `select()` build
render-array elements with `#ajax` callbacks. `Controller\AjaxResult` is a deprecated empty subclass kept for
BC.
