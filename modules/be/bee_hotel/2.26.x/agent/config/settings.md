<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel — install, config, routes, permissions

## Install & enable

```bash
composer require drupal/bee_hotel
drush en bee_hotel -y
```

Pulls a large stack: `bat`, `bat_api`, `bee`, `commerce` (+ `commerce_product`,
`commerce_store`, `commerce_account_balance`, `commerce_invoice`), `currencyapi`,
`core_event_dispatcher`, and the always-on submodules `beehotel_pricealterator` +
`beehotel_utils`. Front-end date picking needs the **Litepicker** JS library installed at
`/libraries/litepicker/litepicker.js` (see `bee_hotel.libraries.yml`, library
`beehotel-litepicker`). For a turnkey demo, enable `beehotel_samplehotel`.

A bookable **unit** is a node bundle configured with BEE (`bee` third-party settings:
`bookable`, `payment`) that has a `field_product` reference to a Commerce product and a
`field_accept_reservations` field.

## Config object `beehotel.settings`

Schema `config/schema/bee_hotel.schema.yml`; install defaults `config/install/beehotel.settings.yml`.
Managed by `Form\BeeHotelSettingsForm` at **`/admin/beehotel/settings`** (route
`beehotel.admin_settings`, permission `configure beehotel settings`).

Keys under the `beehotel:` mapping:

| Key | Default | Meaning |
|---|---|---|
| `off_value` | `0` | Reservations OFF site-wide (booking form returns early with a warning). |
| `off_text` | `''` | Message shown when reservations are off. |
| `setup_mode` | `1` | SETUP mode flag. |
| `calendar_from` | `'0'` | Accept reservations starting N days out. |
| `book_this_unit_header` | `Book` | Booking-form title; `<ct-label>` / `<title>` are special tokens. |
| `book_this_unit_submit` | `Book` | Submit button label. |
| `book_this_unit_position` | `top` | Where the form renders. |
| `units_search_header` / `_submit` / `_position` | `Search` / `Search` / `none` | Search form labels/placement. |
| `chain_chart` | `null` | Price-chain chart type. |
| `guestmessages.balance_cash_subtract` | — | Amount subtracted from cash balance token. |
| `guestmessages.smartceiling` | — | Smart-ceiling rounding toggle. |
| `dateandtime.default_checkin_time` | `'15:00'` | Default check-in time. |
| `dateandtime.default_checkout_time` | `'10:00'` | Default check-out time. |

Top-level (not in schema `beehotel` map) install keys also present:
`unit_reservation_form_disabled` (disables the booking form) and `reservation_paused_1`.

## Routes (`bee_hotel.routing.yml`)

| Route | Path | Access | Purpose |
|---|---|---|---|
| `beehotel.admin` | `/admin/beehotel` | `configure beehotel settings` | Admin menu block. |
| `beehotel.admin_settings` | `/admin/beehotel/settings` | `configure beehotel settings` | Settings form. |
| `bee_hotel.node.book_this_unit` | `/node/{node}/book-this-unit` | custom `_bee_hotel_book_this_unit_access` | Booking form. |
| `bee_hotel.node.related_product` | `/node/{node}/product` | `configure beehotel settings` | Related product controller. |
| `beehotel.unit_search` | `/us` | `access content` | Search form. |
| `beehotel.search_result` | `/u` | `access content` | Search results. |
| `entity.commerce_order.guest_messages` | `/admin/commerce/orders/{commerce_order}/guest-messages` | `_invoice_order_access` | Guest-messages tab on an order. |
| `beehotel.guest_messages.mail.preview` | `/admin/beehotel/guestmessages/mail/preview/{node}/{commerce_order}` | `configure beehotel settings` | Mail preview. |
| `beehotel.yaml_reader.content` | `/admin/beehotel/guestmessages/tokens` | `configure beehotel settings` | Token YAML reader. |

## Permissions (`bee_hotel.permissions.yml`)

- `configure beehotel settings` — manage all Bee Hotel configuration (admin).
- `create bee_hotel book_this_unit` — book units.
- Dynamic permissions from `BeeHotelPermissions::permissions` (`permission_callbacks`).

## Services (`bee_hotel.services.yml`, selected)

- `bee_hotel.saleprice_resolver` (`SalepriceResolver`) — tagged `commerce_price.price_resolver`,
  priority **601**.
- `access_check.bee_hotel.book-this-unit` (`BeeHotelBookThisUnitAccessCheck`) — the
  `_bee_hotel_book_this_unit_access` check.
- `bee_hotel.booking_subscriber` (`BatBookingEventSubscriber`) — reacts to
  `bat_booking` delete events.
- `bee_hotel.beehotelbat`, `bee_hotel.event`, `bee_hotel.order`,
  `bee_hotel.unit_status_from_order`, `bee_hotel.parameter_generator`,
  `bee_hotel.breadcrumb_builder` (priority 9999), `bee_hotel.logger`.
- Guest messaging: `beehotel.guest_message_tokens`, `beehotel.guest_message_hooks`.

The booking→cart→checkout→payment flow itself is handled by **Drupal Commerce**; Bee Hotel adds
the unit search, price resolution and booking-record creation, and delegates payment to Commerce
gateways. See [../api/booking-and-pricing.md](../api/booking-and-pricing.md).
