<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipping method — `printful_shipping`

`src/Plugin/Commerce/ShippingMethod/PrintfulShipping.php` —
`@CommerceShippingMethod(id = "printful_shipping", label = "Printful dropshipping")`, extends
`ShippingMethodBase`, uses `commerce_currency_resolver`'s `CommerceCurrencyResolverAmountTrait` and
`OrderItemsTrait`.

## Live rate calculation

`calculateRates(ShipmentInterface $shipment)`:
1. Returns `[]` if the shipping profile has no address.
2. `OrderItemsTrait::getRequestData($shipment)` builds `recipient` + `items` (see
   [order-fulfillment.md](order-fulfillment.md)) and resolves the matching `printful_store`; its api
   key is applied via `pf->setConnectionInfo()`.
3. `Printful::shippingRates($request_data)` → POST `shipping/rates`.
4. Each returned option becomes a `ShippingRate` (id, name, `Price(rate, currency)`); prices are
   converted to the current display currency when `commerce_currency_resolver` says so. Rates are
   sorted ascending by price.
5. Printful API errors are caught and logged to the `commerce_printful` channel; rates come back
   empty on failure.

## Config

The plugin's configuration form is the currency-resolver form minus `default_package_type`. Add the
method under **Commerce → Configuration → Shipping methods** and attach it to shippable variation
types. Only shipments using this method are later pushed to Printful for fulfillment.
