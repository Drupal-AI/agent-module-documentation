<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Legacy gallery block

`src/Plugin/Block/CommerceGalleryBlock.php` —
`@Block(id = "commerce_gallery", admin_label = "Commerce Gallery (Legacy)",
category = "Commerce")`, extends `BlockBase implements ContainerFactoryPluginInterface`. The
simpler, older block: a column-chunked grid of variation images with links to the parent product.
No lightbox, no theming controls, no JS (CSS-only library `commerce_gallery/gallery`).

Injected services (`create()`): `entity_type.manager`, `file_url_generator`, `entity_field.manager`.

## Access

Overrides `access()`:
`return AccessResult::allowedIfHasPermission($account, 'access content');` — visible to anyone with
the standard "access content" permission (granted to anonymous by default). This only gates block
visibility; the underlying query is still access-checked and status-filtered, so it exposes only
publicly viewable published variations.

## build()

Config: `heading_text`, `no_of_images` (0 = unlimited), `no_of_columns` (1–4, default 4). Query on
`commerce_product_variation`: `->accessCheck(TRUE)->condition('status', 1)->sort('variation_id',
'DESC')`, optional `range(0, no_of_images)`. For each variation and each `image`-type field, builds
a raw item stdClass (`fid`, `filename`, `uri`, `title`, `sku`, `price__number`,
`price__currency_code`, `product_id`). Items are chunked into `no_of_columns` columns with
`array_chunk`. Loads the default store's currency symbol via `commerce_store::loadDefault()` →
`commerce_currency`.

Returns `#theme => 'commerce_gallery'` with `#gallery_data` (chunked columns), `#heading_text`,
`#related_data` (currency symbol), library `commerce_gallery/gallery`. `#cache`: tag
`commerce_product_variation_list`, context `languages`. `getCacheMaxAge()` returns **0**.

`getImageFields($bundle)` — same helper as the advanced block: all fields of type `image`.

## Template (`templates/commerce-gallery.html.twig`)

Renders `.c__gallery-container` with columns of `.c__image-item`, each an `<a>` to
`entity.commerce_product.canonical` (by `product.product_id`) wrapping `<img src="{{ file_url(product.uri) }}"
alt="{{ product.title }}">` and title/SKU/price (`price__number` formatted with `number_format`,
prefixed by the store currency symbol). All values are Twig-escaped. No config schema is declared
for this block's keys (`heading_text`, `no_of_images`, `no_of_columns`).
