<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynCommerce endpoints

All handled by `Drupal\syncommerce\Controller\SyncommerceController`. All four routes require `_permission: 'access content'`.

## GET `/syncommerce/products`
`build()` — renders the themed `syncommerce_product` page that hosts the JS editing app.

## POST `/syncommerce/products_list`
`list()` — body JSON `{ filters: { page, max, status, article?, name?, catalog? } }`. Returns `{ products, catalog, attributes }`. Products are queried from `commerce_product` (type `product`) with `LIKE` filters on article/title and an `IN` on catalog terms.

## POST `/syncommerce/updateProduct`
`updateProduct()` — body `{ id, title, article, catalog, status }`. Loads the `commerce_product`, sets title/`field_article`/`field_catalog`/status and saves. **Mutating.**

## POST `/syncommerce/updateVariation`
`updateVariation()` — body `{ id, price_number, old_price, stock, attributes{}, status }`. Loads the `commerce_product_variation`, sets price/`field_oldprice`/`field_stock`/attribute refs/status and saves. **Mutating.**
