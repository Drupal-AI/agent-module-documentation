<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Downloadable product (arch_downloadable_product) — agent index

Arch submodule that sells **digital goods**: a per-product-type "Downloadable" flag adds a private
file field to the `product` entity and serves those files only to verified purchasers via signed
per-user URLs. Package *Arch product*. Depends on **`arch`**, **`arch_product`**, core **`file`**.
No permissions, no config schema, no Drush. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later.

- **Entitlement, the download route, URL signing, and the field formatter** →
  [api/downloads.md](api/downloads.md)
- **The `product_file` field + "Product download" formatter** → [fields/product-file.md](fields/product-file.md)

## What it provides (from source)

- **Product-type toggle** — `arch_downloadable_product_form_alter()` adds an *is_downloadable*
  checkbox (third-party setting `arch_downloadable_product.is_downloadable`) to
  `product_type_add_form` / `product_type_edit_form`. `hook_entity_insert/update` then calls
  `_arch_downloadable_product_add_file_field()` / `_remove_file_field()` to create or delete a
  `product_file` file field (storage: `uri_scheme => private`, `cardinality => -1`, widget
  `file_generic`, display `arch_downloadable_product`).
- **Routes** (`arch_downloadable_product.routing.yml`):
  - `arch_downloadable_product.download` — `/product/{product_id}/{file_uuid}/{user_uuid}`,
    `_custom_access: ProductDownloadController::downloadAccess`. Serves the file as a
    `BinaryFileResponse` after re-checking entitlement + the `pdtok` token.
  - `arch_downloadable_product.user.purchased_files` — `/user/{user}/downloads`
    (`PurchasedFiles::fileList`, access `PurchasedFiles::fileListAccess` = `$user->access('view')`),
    a "My files" user-page task tab.
- **Services** (`*.services.yml`): `download_url_builder` (`DownloadUrlBuilder`, injected
  `@private_key`), `downloadable_product.access` (`ProductFileAccess`), and a
  `RouteSubscriber` that disables the `product_file` field-config delete form.
- **Field formatter** — `ProductDownloadFormatter` (id `arch_downloadable_product`, on `file` fields
  named `product_file`), extends `DescriptionAwareFileFormatterBase`; renders a download link only
  when `ProductFileAccess::check()` passes for the current user.

## Entitlement model (server-side)

`ProductFileAccess` (`downloadable_product.access`) answers "may this user get this file":
`productHasFile()` confirms the file is referenced by the product's `product_file`, and
`customerHasProduct()` runs a `select('arch_order')` join to `order__line_items` requiring an order
with `uid = current`, `status = 'completed'`, containing the product. `DownloadUrlBuilder::getToken()`
adds an HMAC (`Crypt::hmacBase64`, site `private_key` + hash salt, first 8 chars) over
`pid:fid:email`, passed as the `pdtok` query arg and re-verified in `checkByIdsWithToken()`.
`downloadAccess()` additionally forbids anonymous users and requires the route's `{user_uuid}` to
equal the current user's own UUID.
