<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, admin form, hooks & events

## Settings form

`Form\ShipStationAdminForm` (a `ConfigFormBase`, id `shipstation_admin_form`) at
**`/admin/commerce/config/shipstation`**, permission **`administer commerce_shipment`**. Editable
config object: **`commerce_shipstation.shipstation_config`**. The module ships **no** `config/install`
defaults and **no** `config/schema` — the object is created only when the form is first saved (until
then the endpoint returns 503). If no shipping-method plugin exists, the form shows a notice and
renders nothing else. The form also prints a status notice to migrate the Custom Store URL from
`/shipstation/api-endpoint` to `/shipstation/drupal-commerce`.

## Config keys (`commerce_shipstation.shipstation_config`)

| Key | Widget | Meaning |
|-----|--------|---------|
| `commerce_shipstation_username` | textfield (required) | Store username the endpoint checks against `?SS-UserName`. NOT your ShipStation login. |
| `commerce_shipstation_password` | password (required on first save) | Store password checked against `?SS-Password`. Re-save leaves it unchanged if blank. |
| `commerce_shipstation_alternate_auth` | textfield | Optional `auth_key` accepted as `?auth_key` (for CGI-PHP servers). |
| `commerce_shipstation_logging` | checkbox | Log each endpoint request + export summary to the `commerce_shipstation` logger (watchdog). |
| `commerce_shipstation_reload` | checkbox | Export **all** matching orders, ignoring the start/end date window. |
| `commerce_shipstation_export_paging` | select (20/50/75/100/150) | Orders per page in the export. |
| `commerce_shipstation_export_status` | multi-select (required) | Which order `state`s are exported (options from every `commerce_order` workflow's states). |
| `commerce_shipstation_exposed_shipping_methods` | checkboxes (required) | Only orders using one of these shipping-method plugins are exported. |
| `commerce_shipstation_billing_phone_number_field` | select | Customer-profile field used for the BillTo phone (`none` to skip). |
| `commerce_shipstation_shipping_phone_number_field` | select | Customer-profile field used for the ShipTo phone (`none`). |
| `commerce_shipstation_order_notes_field` | select | `commerce_order` field mapped to `InternalNotes` (`none`). |
| `commerce_shipstation_customer_notes_field` | select | Shipping-profile field mapped to `CustomerNotes` (`none`). |
| `commerce_shipstation_product_images_field` | select | Product/variation image field; its `thumbnail` image style URL becomes `ImageUrl` (`none`). |

Field-select options are built by `loadFieldOptions()` over config fields (values stored as
`entity_type.field_name`, e.g. `commerce_order.field_notes`). `submitForm()` skips writing the
password when the field is left blank, so an existing password survives an edit.

## ShipStation-side setup (from README)

Add a ShipStation **Custom Store**, URL = `https://[domain]/shipstation/drupal-commerce`, enter the
username/password from the form. Recommended status mapping ("Fulfillment, with validation"):
Awaiting Payment → `validation`, Awaiting Shipment → `fulfillment`, Shipped → `complete`, Cancelled →
`canceled`, On-Hold → *null*. A custom order workflow must define a **`fulfill`** transition (invoked
by `shipnotify`).

## Extension points

- **Hooks** (invoked via `module_handler->alter`, no `.api.php` shipped):
  - `hook_commerce_shipstation_export_orders_alter(array &$orders, array $context)` — filter the
    exported order list; `$context` has `start_date`, `end_date`, `page`, `page_size`.
  - `hook_commerce_shipstation_order_xml_alter(\SimpleXMLElement &$order_xml, OrderInterface $order)`
    — mutate a single order's export XML.
- **Event**: `ShipStationEvents::ORDER_EXPORTED` (`'commerce_shipstation.order_exported'`),
  `Event\ShipStationOrderExportedEvent` with `getOrder()`, dispatched once per exported order.
- **Service**: `commerce_shipstation.shipstation_service` (`ShipStation`) — export/shipnotify/access
  logic; injectable for custom callers.

## Dependencies

`commerce`, `commerce_shipping`, and core `image` (info.yml). Composer also requires `ext-dom` and
`ext-simplexml` and `drupal/commerce ^2.40 || ^3`, `drupal/commerce_shipping ^2.11`. No Drush
commands, no permissions defined by this module (it reuses `administer commerce_shipment` and
`view any commerce_order`).
