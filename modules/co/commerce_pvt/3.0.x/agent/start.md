<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Variations Table (`commerce_pvt`) — agent index

Renders **all variations of one Drupal Commerce product as a single Views table** with a per-row
quantity field and one bulk **Add to cart / Update** submit — built for **wholesale-style bulk
ordering**, where a buyer sets quantities across many variations (sizes, packs) and adds them in one
action instead of clicking through each variation page. Version **3.0.1-beta1**, core
`^10.3 || ^11 || ^12`. GPL-2.0-or-later. **No routes, no permissions, no Drush, no admin settings
form** — everything is configured on a Views display and a product's *Manage display*.

Dependencies (info.yml): core `system`, core **`views`**, and Commerce `commerce_product`,
`commerce_order`, `commerce_cart` (all `>= 3`). Composer requires `drupal/commerce:^3`.

> **Hard requirement:** the module needs the Commerce core patch from
> [#3017662](https://www.drupal.org/project/commerce/issues/3017662) (adds an Order **Item** Type
> resolver chain for Commerce 3.x). `composer.json` declares it under `extra.patches`, so the site
> must have `cweagans/composer-patches` + `enable-patching: true`. Without the patch the module's
> classes reference `commerce_order.chain_order_item_type_resolver` and will not resolve.

## How it actually works (server-driven, no custom route)

1. **Extra field + lazy builder.** `CommercePvtHooks::entityExtraFieldInfo()`
   (`src/Hook/CommercePvtHooks.php`) adds a *Product Variations Table* display component to every
   `commerce_product` bundle. When that component is enabled on a product's *Manage display*,
   `commerce_product_view()` → `CommercePvtHooks::commerceProductView()` inserts a placeholdered
   `#lazy_builder` → `LazyBuilders::variationTableForProduct($product_id)` (`src/LazyBuilders.php`).
2. **Embedded view.** The lazy builder calls `views_embed_view('commerce_pvt_form', 'default',
   $product_id)` and wraps it in the `commerce_pvt_contextual_links_wrapper` theme hook (a contextual
   link to edit the view). The default view **`commerce_pvt_form`** ships in
   `config/install/views.view.commerce_pvt_form.yml`: base table `commerce_product_variation_field_data`,
   argument = product id, filters `status = 1` (published) and variation `type = default`, style = table.
3. **The table is a Views form.** The quantity column, subtotal column, summary, and buttons are all
   custom Views handlers that implement `viewsForm()` / `viewsFormSubmit()`, so submitting the table
   runs Commerce cart operations. See [`api/internals.md`](api/internals.md).

## What it provides

Custom Views handlers, registered in `CommercePvtViewsHooks::viewsDataAlter()`
(`src/Hook/CommercePvtViewsHooks.php`) on `commerce_product_variation`:

- **Field** `commerce_pvt_variation_edit_quantity` (`src/Plugin/views/field/EditVariationQuantity.php`)
  — per-row quantity `number` input; the bulk submit adds/updates/removes cart items. Options: combine,
  allow decimal + step, **Use AJAX**, **Enhance widget** (+/- buttons, read-only, debounced update
  delay). This is the core of the module.
- **Field** `commerce_pvt_variation_subtotal` (`src/Plugin/views/field/VariationSubtotal.php`) — shows
  the current cart subtotal for that variation (currency-formatted).
- **Area** `commerce_pvt_table_summary` (`src/Plugin/views/area/TableSummary.php`) — footer line:
  count + total for this product's items in the cart.
- **Area** `commerce_pvt_empty_cart_button` (`src/Plugin/views/area/EmptyCartButton.php`) — removes
  all of this product's variations from the cart.
- **Area** `commerce_pvt_goto_cart_button` (`src/Plugin/views/area/GoToCartButton.php`) — redirects to
  `commerce_cart.page` (AJAX `RedirectCommand` when AJAX is on).
- **Block** `pvt_table_summary_block` (`src/Plugin/Block/PvtTableSummaryBlock.php`, admin label
  *Commerce PVT summary*) — same count/total summary as a placeable block; expected machine name
  `commercepvtsummary`. Config schema in `config/schema/commerce_pvt.schema.yml`.
- **AJAX refresher** `commerce_pvt.refresh_page_elements_helper` (`src/RefreshPageElementsHelper.php`)
  — the shared AJAX callback rebuilds the form, status messages, the `commerce_cart` block, and the
  summary block after a cart change.
- **Alter hooks** (`commerce_pvt.api.php`): `hook_commerce_pvt_view_area_table_summary_markup_alter()`
  and (from the block) `hook_commerce_pvt_table_summary_block_markup_alter()` — both module- and
  theme-level, for customising the summary markup.
- **Assets:** library `commerce_pvt/enhanced-widget` (`js/enhanced-widget.js`, `css/enhanced-widget.css`;
  jQuery + `core/once` + `core/drupal.debounce`), two Twig templates.

Shared plumbing lives in `src/Traits/CommercePVTCommonTrait.php` (cart provider/manager, current store,
chain order-type + order-**item**-type resolvers, currency formatter; helpers `getOrderItemFromCart()`,
`getOrderType()`, and the static AJAX callback `updatePageElements()`).

## Price / cart integrity

Prices, subtotals and totals are always read from Commerce order items / variation prices server-side
(`OrderItem::getTotalPrice()`, `ProductVariation::getPrice()`); the request only supplies **quantities**.
Add/update/remove go through `commerce_cart.cart_manager`, so the client cannot influence pricing. Cart
mutations are standard FAPI (Views) form submissions (CSRF-protected). Summary markup is built with
`FormattableMarkup`/`t()` (placeholder-escaped).

## Docs in this set

- [`api/internals.md`](api/internals.md) — the Views form lifecycle, each handler's submit logic, the
  enhanced-widget JS, and the AJAX refresh helper.
- [`configure/table.md`](configure/table.md) — enabling the table on a product, and the
  `commerce_pvt_form` view / handler options.
- [`usage.md`](../usage.md), [`human-docs/`](../human-docs/index.md) — prose overview and install guide.
