<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML Starter — setup & install behavior

## What enabling the module does
1. Requires the full dependency stack first (Commerce/commerce_product, Paragraphs, CSHS, TVI, Image Effects, Colorbox, Field Group, Metatag, Responsive Image, Focal Point). Core `^11 || ^12`.
2. `config/install/*` provisions: `commerce_product` type `product`, variation type `variation`, vocabularies `catalog`/`brand`/`product_options`, paragraph type `product_param`, product fields (image, gallery, article, short, title, price prefix, related products/category, metatag, attach, tx options/brand, paragraph, rf_product), variation fields (`field_oldprice`, `field_stock`), image styles and responsive image styles, form/view displays.
3. `config/optional/*` adds catalog/brand/product views, catalog/product/related blocks, a RUB currency, term view/form displays and product/brand/catalog/options pathauto patterns (installed only when their providers are present).

## Install hook side effects (`cmlstarter.install`)
- Creates a **default commerce_store** only if `loadDefault()` returns none. Language `ru` → "Example Store", RUB, Moscow address; otherwise "US Store", USD, Greenville SC address. Store mail is `admin@example.com` — change it post-install. Throws `\LogicException` if the `commerce_store` storage/entity is unavailable.
- Imports `product_options` **taxonomy terms** from `config/content/<lang>/taxonomy_term.product_options.yml` via `_cmlstarter_get_terms()` (parsed with `Symfony\Component\Yaml\Yaml`, keyed by UUID). Throws `InvalidArgumentException` if the language file is missing/unreadable, `UnexpectedValueException` on malformed data.

## Catalog term pages
`RouteSubscriber::alterRoutes()` swaps the `_controller` of `entity.taxonomy_term.canonical` for `TaxonomyTermController::render`, which renders an embedded `product` view by term bundle:
- `catalog` → view `product`, display `embed`
- `brand` → view `product`, display `embed_1`
- `product_options` → view `product`, display `embed_2`
- any other bundle → normal `full` term render.

The route keeps its original access requirements (view access on the term); only the controller changes. To substitute your own controller, implement `hook_cmlstarter_taxonomy_route(&$controller)` — the module runs `$this->moduleHandler->alter('cmlstarter_taxonomy_route', $controller)` before setting it.

## Typical post-install tasks
- Update store name/mail/currency/address for production.
- Adjust the generated product fields and image styles.
- Extend the shipped `product`/`catalog`/`brand` views (facets, sorting, exposed filters).
- Localize by installing with the `ru` site language for the RU/RUB store defaults.
