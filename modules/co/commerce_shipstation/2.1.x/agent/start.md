<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce ShipStation (commerce_shipstation) — agent index

Integrates **Drupal Commerce** with **ShipStation** (multi-channel order fulfilment) through
ShipStation's **Custom Store** XML API. One HTTP endpoint on your site: ShipStation calls it with
`?action=export` to pull orders as XML, and `?action=shipnotify` to post back tracking + mark the
order fulfilled. No outbound HTTP is made by the module.

- **Package** Commerce (contrib). **Version** 2.1.0-beta3. **Core** `^9.1 || ^10 || ^11`.
  **License** GPL-2.0-or-later.
- **Depends on** `commerce`, `commerce_shipping`, core `image`; composer needs `ext-dom`,
  `ext-simplexml`. No submodules, no permissions of its own, no Drush.
- **Configure** at `commerce_shipstation.shipstation_admin_form`
  (`/admin/commerce/config/shipstation`, permission `administer commerce_shipment`).

## Subdocs

- **[api/endpoint.md](api/endpoint.md)** — the two routes, the `_shipstation_access` auth model,
  and the `export` / `shipnotify` actions (order→XML, inbound tracking + `fulfill` transition).
- **[config/settings.md](config/settings.md)** — the `commerce_shipstation.shipstation_config`
  object and every key, the admin form, the alter hooks and the export event.

## Map (from source)

- **Routes** (`commerce_shipstation.routing.yml`): `/shipstation/drupal-commerce` (current) and
  `/shipstation/api-endpoint` (legacy) → `ShipStationEndpointController::shipStationEndpointRequest`,
  gated by `_shipstation_access: 'TRUE'`; `/admin/commerce/config/shipstation` → the settings form.
- **Access** (`Access\ShipStationAccess` / `ShipStation::access`): allowed for a signed-in user with
  `view any commerce_order`, or when the request's `?SS-UserName`/`?SS-Password` query params match
  the configured store credentials, or when `?auth_key` matches the configured alternate key.
  Credentials are created on the settings form and are separate from the ShipStation account login.
  Serve over **HTTPS** (ShipStation sends the store credentials on each call and the endpoint carries
  order data).
- **Service** `commerce_shipstation.shipstation_service` (`ShipStation`): `exportOrders()`,
  `requestShipNotify()`, `access()`. Logger channel `commerce_shipstation`.
- **XML** built with `ShipStationSimpleXMLElement` (SimpleXML + CDATA helper).
- **Hooks** `hook_commerce_shipstation_export_orders_alter`, `hook_commerce_shipstation_order_xml_alter`.
  **Event** `ShipStationEvents::ORDER_EXPORTED` (`ShipStationOrderExportedEvent`).

Status: 2.1.0-beta3 (beta). Kernel tests exist but `::access` / `ShipStationTest` bodies are
`@todo` stubs.
