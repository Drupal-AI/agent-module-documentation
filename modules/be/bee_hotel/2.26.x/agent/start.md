<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel (bee_hotel) — agent index

Direct hotel/B&B **booking suite** on **BAT** (reservation/PMS) + **BEE** + **Drupal Commerce**.
Bookable *unit* nodes carry a linked Commerce product; guests search availability and reserve for
N occupants; per-night price is computed **server-side** by a Commerce price resolver running a
chain of **Price Alterator** plugins over a weekly base-price table. Version **2.26.4**.
Core `^9.4 || ^10.2 || ^11`. License GPL-2.0-or-later. Config object **`beehotel.settings`**,
settings route **`beehotel.admin_settings`** (`/admin/beehotel/settings`).

Dependencies (info.yml): `bat`, `bat_api`, `bee`, `beehotel_pricealterator`, `beehotel_utils`,
`commerce_account_balance`, `commerce_product`, `commerce_store`, `currencyapi`,
`core_event_dispatcher`. Composer also pulls `commerce`, `commerce_invoice`,
`beehotel_pricealterators`, `beehotel_vertical`.

## What the core module provides (from source)

- **Booking form** `BookThisUnitForm` (route `bee_hotel.node.book_this_unit`,
  `/node/{node}/book-this-unit`) — creates a `bat_booking` + a `commerce_order_item` and adds it
  to the Commerce cart. Access via custom check `BeeHotelBookThisUnitAccessCheck` (allows anyone
  when the node bundle's BEE settings mark it `bookable`).
- **Unit search** form `UnitsSearch` at `/us` and result controller `SearchResult` at `/u`
  (`access content`); block `UnitsSearchBlock`.
- **Price resolver** `Resolvers\SalepriceResolver` — a Commerce `price_resolver`
  (priority **601**) that computes the sale price from the price-alterator chain; the client
  supplies only dates + guest count, never an amount.
- **Commerce checkout pane** `Plugin\Commerce\CheckoutPane\OrderDetailsPane`
  (id `bee_hotel_pane_order_details`) — static confirmation message.
- **Guest messaging** — `BeeHotelGuestMessageTokens` / `BeeHotelGuestMessageHooks`, a
  `guest_message` node type (config/install), token YAMLs in `config/guest_messages/`, controllers
  `GuestMessages` and `TokensReader`, mail-preview form `BeeHotelGuestMessagesMail`.
- **BAT glue** services `bee_hotel.beehotelbat` (`BeeHotelBat`), `bee_hotel.event` (`Event`),
  `bee_hotel.order` (`BeeHotelOrder`), `UnitStatusFromOrderService`, subscriber
  `BatBookingEventSubscriber`, breadcrumb builder, `Logger` (writes `bee_hotel_log`).
- **Permissions** (`bee_hotel.permissions.yml` + `BeeHotelPermissions::permissions`):
  `configure beehotel settings`, `create bee_hotel book_this_unit`, plus dynamic per-bundle perms.
- **Config schema** `beehotel.settings` (config/schema) with install defaults.
- Front-end uses the **Litepicker** JS library (`/libraries/litepicker/`).

## Solution docs

- Core config, routes, permissions, the booking→cart flow and Commerce integration →
  [config/settings.md](config/settings.md)
- Booking form, price resolution and the guest-messaging system →
  [api/booking-and-pricing.md](api/booking-and-pricing.md)

## Submodules (each documented under `modules/<sub>/2.26.x/`)

- **beehotel_utils** — dependency-free utility services (`Dates`, `BeeHotel`, `BeeHotelUnit`,
  `BeeHotelCommerce`) used by everything → [modules/beehotel_utils/2.26.x/agent/start.md](../modules/beehotel_utils/2.26.x/agent/start.md)
- **beehotel_pricealterator** — the Price Alterator **plugin type** + manager, base plugins
  (`GetSeason`, `PriceFromBaseTable`), weekly base-price table, alterator admin →
  [modules/beehotel_pricealterator/2.26.x/agent/start.md](../modules/beehotel_pricealterator/2.26.x/agent/start.md)
- **beehotel_pricealterators** — the concrete alterator plugins (Occupants, ConsecutiveNights,
  GlobalSlider, SpecialNights, DaysBeforeCheckin, CheckinTime, OneNightOnly, SaturdayNightOnly,
  SundayCheckin) + `special_night` content type →
  [modules/beehotel_pricealterators/2.26.x/agent/start.md](../modules/beehotel_pricealterators/2.26.x/agent/start.md)
- **beehotel_vertical** — vertical availability calendar (units × days) with AJAX state toggles →
  [modules/beehotel_vertical/2.26.x/agent/start.md](../modules/beehotel_vertical/2.26.x/agent/start.md)
- **beehotel_happening_today** — daily arrivals/departures report + cron email →
  [modules/beehotel_happening_today/2.26.x/agent/start.md](../modules/beehotel_happening_today/2.26.x/agent/start.md)
- **beehotel_ical** — iCal (`.ics`) availability export + settings →
  [modules/beehotel_ical/2.26.x/agent/start.md](../modules/beehotel_ical/2.26.x/agent/start.md)
- **beehotel_event** — BAT-event maintenance (cron purge of old events) →
  [modules/beehotel_event/2.26.x/agent/start.md](../modules/beehotel_event/2.26.x/agent/start.md)
- **beehotel_addtocart** — programmatic add-to-cart helper/route →
  [modules/beehotel_addtocart/2.26.x/agent/start.md](../modules/beehotel_addtocart/2.26.x/agent/start.md)
- **beehotel_sps** — *(deprecated)* store-wide price slider →
  [modules/beehotel_sps/2.26.x/agent/start.md](../modules/beehotel_sps/2.26.x/agent/start.md)
- **beehotel_samplehotel** — one-step demo-hotel installer →
  [modules/beehotel_samplehotel/2.26.x/agent/start.md](../modules/beehotel_samplehotel/2.26.x/agent/start.md)
- **beehotel_upgrade** — cross-release upgrade fixes →
  [modules/beehotel_upgrade/2.26.x/agent/start.md](../modules/beehotel_upgrade/2.26.x/agent/start.md)
