<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basket delivery and Views plugins

## Basket delivery plugins (`src/Plugin/Basket/Delivery/`, `@BasketDelivery`)

All implement `Drupal\basket\Plugins\Delivery\BasketDeliveryInterface`.

- **`novaposhta`** (`NovaPoshtaDelivery`, "NovaPoshta Delivery") — warehouse pickup. `basketFormAlter`
  adds three cascading `select`s: `region` (`getRegions()`), `city` (`getCitis()`), `point`
  (`getPoints()` = warehouses), plus (for order editors with `access novaposhta en` on a node) an
  `enNum` waybill field. Uses `NovaPoshta::jQuerySelectAttached()` for the Chosen/Select2 widget.
  `basketSave` merges the chosen branch into the `novaposhta` table (human-readable `address` +
  serialized `data`) and stores the waybill number via `NovaPoshtaEN::updateOrderEnNum()`;
  `basketLoad`/`basketGetAddress`/`basketDelete` read/remove it. `deliverySumAlter` →
  `NovaPoshtaDeliveryCostTrait::alterDeliveryCost()` computes the API delivery cost / COD fee.
- **`novaposhta2`** (`NovaPoshtaDelivery2`, id `novaposhta2`) — variant delivery plugin.
- **`novaposhta_address`** (`NovaPoshtaDeliveryAddress`, id `novaposhta_address`) — courier-to-address
  variant using settlement/street autocomplete instead of a warehouse select.

`NovaPoshtaDeliveryCostTrait` centralizes cost calculation (sender city, recipient city from
`$_SESSION['novaposhta']['recipientCity']`, weight, cart total) and honors
`config.calculate_delivery_cost` + the COD `payment_ids` setting.

## Views integration

`novaposhta.views.inc` (`hook_views_data` / `_alter` → `NovaposhtaViewsHooks`) exposes the
`novaposhta_en` table. Field plugins (`src/Plugin/views/field/`):
`novaposhta_en_num`, `novaposhta_en_cost`, `novaposhta_en_weight`, `novaposhta_en_address`,
`novaposhta_en_settings` (row actions incl. the print link via `NovaPoshtaView::getPrintLink()`).
Filter `novaposhta_en_date` (`novaposhta_en_date`); wizard `novaposhta_en`. Bundled View
`config/install/views.view.novaposhta.yml` (id `novaposhta`, display `block_1`) is the admin
waybill list; `NovaposhtaHooks::preprocessViewsViewTable` + `ViewsAlter` add the print/bulk column
and `novaposhta_form_views_exposed_form_alter` styles its exposed form.

## Hooks

`src/Hook/NovaposhtaHooks.php` (attribute `#[Hook(...)]`, legacy shims in `novaposhta.module`):
`basket_translate_context_alter`, `cron`, `preprocess_views_view_table`, `theme`
(`novaposhta_en_view`, `novaposhta_en_tracking`), `basket_order_links_alter`,
`basket_noty_twig_tokens_alter`, `basketTemplateTokens_alter`, `basketTokenValue_alter`. Order
screens and token values are built by `src/AdminPages.php` (`loadOrderEN`, `orderLinks`).
The English-order surface (create/edit waybill, recipient, contact person) is
`src/NovaPoshtaEN.php` + `src/Form/NovaPoshtaENForm.php` /
`NovaPoshtaCreateUserForm` / `NovaPoshtaCreateContactPersonForm`.
