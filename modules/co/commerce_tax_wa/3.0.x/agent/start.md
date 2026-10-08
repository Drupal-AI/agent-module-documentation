<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_tax_wa — agent start

Adds **Washington State (US) destination-based sales tax** to Drupal Commerce. Ships one
Commerce **tax-type plugin** (`WaTax`) and one **tax-rate resolver** service that looks the
rate up live from the Washington State Department of Revenue (DOR) address-rate web service,
falling back to an admin-configured default rate when the service errors. Depends only on
`commerce:commerce_tax (^3.0)`. Core `^10 || ^11`. Version **3.0.0-alpha1** (alpha /
minimally maintained per drupal.org; under active development).

No routes, no controllers, no permissions file, no cron/queue, no `.install`/update hooks,
no templates, no JS. The whole module is the two classes below plus config schema.

## Files
- `src/Plugin/Commerce/TaxType/WaTax.php` — the tax-type plugin.
- `src/Resolver/WaTaxRateResolver.php` — the rate resolver (DOR lookup).
- `commerce_tax_wa.services.yml` — registers the resolver service.
- `config/schema/commerce_tax_wa.schema.yml` — config schema for the tax-type config entity.

## Tax-type plugin — `WaTax`
`#[CommerceTaxType(id: "commerce_tax_wa", label: "Washington State Tax Service")]`, extends
`LocalTaxTypeBase`, implements `RemoteTaxTypeInterface`. You add it as a **tax type** at
**Admin → Commerce → Configuration → Tax types** (`/admin/commerce/config/tax-types`).

- `buildZones()` — one zone `wa`, display label **"WA Sales Tax"**, territory
  `{country_code: US, administrative_area: WA}`. Its single default rate `tax_wa` uses the
  configured `label` and `percentage` (percentage effective `start_date` `2008-01-01`).
- `applies($order)` — true when the order's store id is in the configured `commerce_stores`
  **and** the store address matches, **or** the store has matching tax registrations.
  (PHP precedence: `(in_array(store_id, commerce_stores) && matchesAddress) || matchesRegistrations`.)
- `apply($order)` — per order item: resolves the customer profile, resolves rates for the
  `wa` zone (via the resolver, below), and — only for items whose variation bundle is in the
  configured `product_variation_types` — adds a `tax` **Adjustment** (label from the zone,
  amount = `percentage->calculateTaxAmount(unit_price, prices_include_tax)` × quantity,
  rounded if configured). Includes `LocalTaxTypeBase` tax-inclusive/exempt negation handling.
- Config form fields (`buildConfigurationForm` / `submitConfigurationForm`):
  - **label** ("Default Wa Locality ID and Name") — required text, e.g. `Seattle - 1726`.
  - **percentage** — `commerce_number`, shown ×100 with a `%` suffix, stored as a fraction
    (default `0.101`). This is the **fallback** rate used when the DOR lookup fails.
  - **product_variation_types** — required multi-select of `commerce_product_variation_type`
    (which variations get taxed → lets you mix taxable / non-taxable).
  - **commerce_stores** — required multi-select of `commerce_store` (which stores this applies to).
  - Config keys (schema): `display_label`, `round`, `territories`, `label`, `percentage`,
    `product_variation_types` (sequence), `commerce_stores` (sequence).

## Rate resolver — `WaTaxRateResolver`
Service `commerce_tax_wa.wa_tax_rate_resolver`, class
`Drupal\commerce_tax_wa\Resolver\WaTaxRateResolver`, ctor arg `@http_client`, tagged
`commerce_tax.tax_rate_resolver` **priority 600** (runs ahead of Commerce Tax's default
resolver). Implements `TaxRateResolverInterface`.

`resolve(TaxZone $zone, OrderItemInterface $order_item, ProfileInterface $customer_profile)`:
- Only acts when the zone territory is `US` / `WA`; otherwise returns nothing.
- Starts from the zone's default rate (the configured fallback).
- Reads the **customer profile address** (`address_line1`, `address_line2`, `locality`,
  `postal_code`) and does an HTTPS **GET** to the **fixed** DOR endpoint
  `https://webgis.dor.wa.gov/webapi/addressrates.aspx?output=xml` with the address, city and
  ZIP appended as `urlencode()`d query params (`addr`, `city`, `zip`). The host is hardcoded;
  it is a public service with **no API key/credentials**. Uses the core `http_client`
  (Guzzle) with default TLS verification.
- On HTTP 200, parses the XML (`SimpleXMLElement`) and builds a `TaxRate` from the response:
  `id` = `loccode`, `label` = rate `name` + `loccode`, `percentage` = `rate` attribute
  (`start_date` `2000-01-01`) — i.e. the live combined state+local destination rate.
- On a Guzzle `RequestException`, logs a warning (`commerce_tax_wa` channel) via
  `watchdog_exception` and returns the configured **fallback** rate, so checkout still
  computes a tax.

## Mechanism summary
The tax rate is computed **server-side** from the order's WA address against the fixed WA DOR
HTTPS lookup — the client never supplies a rate or amount. Because WA is destination-based
(hundreds of local rates), a flat Commerce tax rate won't do; this resolver fetches the
current rate per address, and the admin `percentage` is only the offline fallback.

## Gotchas
- **alpha1**, minimally maintained — pin/test before production.
- The live rate depends on outbound HTTPS reachability to `webgis.dor.wa.gov`; when it errors
  every taxed item uses the single configured fallback `percentage`, so keep that realistic.
- `commerce_stores` and `product_variation_types` are **required** on the form; if the store
  or a variation type isn't selected the tax won't apply.
- Known upstream typo: `defaultConfiguration()` seeds the key `product_type_variations`, but
  every consumer uses `product_variation_types` — the form's required field masks it, but the
  intended empty default isn't seeded.

## See also
- `../usage.md` — one-paragraph orientation.
- `../human-docs/` — click-through install & configuration guide for humans.
