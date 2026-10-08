<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Zones — agent index

Defines reusable **territorial zones** (groupings of countries, subdivisions, and postal codes) as
Drupal **config entities**, and ships Commerce **condition plugins** that match an order's billing or
shipping address against selected zones. The zone-building widget and the matching engine are both
provided by the `address` module / `commerceguys/addressing` library — this module wraps them in a
persistent, admin-managed entity plus Commerce integration.

Version **1.0.2**. Core `^10 || ^11`. Depends on `address:address` and `commerce:commerce`
(the composer.json `description` field — "currency exchange rates / converter" — is a copy/paste error;
the module is about geographic zones). Two submodules: `commerce_zones_shipping`, `commerce_zones_example`.
No controllers, no custom routes file, no services, no JS, no libraries, no Drush commands, no `.install`.

## The entity: `commerce_zone`

`src/Entity/Zone.php` — `@ConfigEntityType(id = "commerce_zone")`, `config_prefix = "commerce_zone"`,
`admin_permission = "administer commerce_zone"`. `config_export`: `id`, `label`, `description`,
`configuration`, `status`. Route provider is core `AdminHtmlRouteProvider`, so all its routes are
**admin routes gated by the entity's `admin_permission`**.

- `links`: `add-form`, `edit-form`, `delete-form`, `collection` all under
  `/admin/commerce/config/commerce-zones…`.
- `configuration` holds the addressing zone definition: `configuration['territories']` is a sequence of
  `address_zone_territory` items (`country_code`, optional `administrative_area`, optional
  `included_postal_codes` / `excluded_postal_codes` — the postal fields are **regular-expression
  patterns**, e.g. `/(31)[0-9]{3}/`). Schema: `config/schema/commerce_zones.schema.yml`.
- `getZone()` builds a `CommerceGuys\Addressing\Zone\Zone` from `id` + `label` + `configuration`.
- `match(AddressItem $address)` → delegates to that library object's `match()` (server-side geographic
  match; returns bool). This is the module's core primitive.
- `ZoneListBuilder` (collection page) renders label / machine name / description columns.
- Forms: `ZoneForm` (add/edit — label textfield, required description textarea, machine_name, an
  `address_zone` form element for `configuration`, and an enabled/disabled `status` radios) and
  `ZoneDeleteForm` (standard confirm-delete).

## Permission (`commerce_zones.permissions.yml`)

- `administer commerce_zone` — `restrict access: true`. The only permission; gates every zone route
  (add/edit/delete/list) via the entity `admin_permission`. There are no customer-facing or anonymous
  routes in this module.

Menu link `entity.commerce_zone.collection` ("Zones") sits under `commerce.store_configuration`
(`commerce_zones.links.menu.yml`); action link "Add Zone" on the collection
(`commerce_zones.links.action.yml`).

## Condition plugins (how zones are consumed)

`BaseZoneAddress` (`src/Plugin/Commerce/Condition/BaseZoneAddress.php`) is the shared base
(`ConditionBase`). Config: `zones` (multiple `commerce_zone` ids, via `commerce_entity_select`) + `negate`.
`evaluateAddress()`: if no zones configured → returns TRUE; otherwise `loadMultiple()` the selected zones
and returns on the **first** `$zone->match($address)` — `!negate` on a match, `negate` if none match.

Concrete conditions (all `category = Customer`, `weight = 10`):
- `billing_address_zone` — `BillingZoneAddress`, entity_type `commerce_order`; matches the order's
  billing profile address. (in the base module.)
- `order_shipping_address_zone` — `commerce_zones_shipping`, entity_type `commerce_order`; matches the
  order's collected `shipping` profile address.
- `shipping_address_zone` — `commerce_zones_shipping`, entity_type `commerce_shipment`; matches the
  shipment's shipping profile address.

Each returns FALSE early when the relevant profile/address is missing. These plug into any Commerce
feature that supports conditions (promotions, shipping methods, payment gateways, etc.). The kernel test
`tests/Kernel/ZonesConditionTest.php` exercises them against Commerce **promotions**.

## Submodules

- `commerce_zones_shipping` — adds the two shipping conditions above; deps `commerce_zones` +
  `commerce_shipping`.
- `commerce_zones_example` — installs six ready-made example zones as config
  (`config/install/commerce_zones.commerce_zone.*`: `eu`, `eea`, `efta`, `safta`, `midwest_usa` [US
  states by `administrative_area`], `osijek_county` [HR by `included_postal_codes` regex]). Learning
  aid; not for production.

## Notes / gotchas

- README says the module "does not handle tax zones" — it targets shipping/billing address matching and
  any condition-supporting Commerce entity; tax integration is not provided.
- Matching is purely server-side over stored order/profile address data; postal-code patterns are
  admin-authored regexes stored in config.
- `data.json` `subcategories` = "Shipping rate calculation" is only one use; the module is a generic
  zone/condition primitive, not itself a shipping-rate calculator.
