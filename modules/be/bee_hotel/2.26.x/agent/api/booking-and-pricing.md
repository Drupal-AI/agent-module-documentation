<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Booking flow, price resolution & guest messaging

## Booking form → cart (`Form\BookThisUnitForm`)

Route `bee_hotel.node.book_this_unit` = `/node/{node}/book-this-unit`.

- `buildForm()` requires the node to be a Bee Hotel unit (`BeeHotelUnit::isThisNodeBeeHotel`),
  aborts early if `beehotel.settings:beehotel.off_value` is set or the unit has no
  `field_product`. Renders a Litepicker **dates** textfield, a **guests** select bounded
  `1..maxOccupancy(node)`, hidden `node`/`pid`/`bid`, and (if enabled) a **check-in time** select
  fed from `beehotel_pricealterator.pricealterator.CheckinTime.settings`.
- `validateForm()` recomputes availability via `BeeHotelUnit::getAvailableUnits()`; if the chosen
  `bid` is not available it redirects back to the node with updated search params. It also enforces
  the bundle's BEE `payment` flag and the node's `field_accept_reservations`.
- `submitForm()` is the state change:
  1. stores the form values in the session under a `qid` (derived from `form_build_id`);
  2. creates a **`bat_booking`** (`type = bee`) with normalised check-in/last-night dates and
     `booking_capacity = guests`;
  3. loads the linked **Commerce product**, picks the first variation whose
     `field_max_occupancy >= guests`, and takes **`$variation->getPrice()`** as `unit_price`
     (price comes from the product variation, **not** from the request);
  4. creates a **`commerce_order_item`** (`type = bee`, `quantity = nights`) with fields
     `field_booking`, `field_node`, `field_checkin`, `field_checkout`,
     `field_order_item_nights` (and `field_checkin_time`);
  5. optionally adds a one-time **late check-in fee** `Adjustment` from the CheckinTime config;
  6. empties then adds the item to the default cart and redirects to `commerce_cart.page`.

From there **Drupal Commerce** owns checkout and payment. Bee Hotel has no payment webhook and
no "mark paid" logic; the `bee_hotel_pane_order_details` checkout pane only prints a
confirmation message.

## Price resolution (`Resolvers\SalepriceResolver`)

Registered as a Commerce `price_resolver` (priority 601). `resolve()`:

- only acts on `bee`-bundle purchasable entities;
- reads the search **`dates`** (POST or session `beehotel_units_search_queries[qid]`) and the
  guest count from the session, plus currency from `BeeHotel::getCurrencyCode()`;
- normalises dates (`Dates::normaliseDatesFromSearchForm`, `Dates::easter`), then calls the
  price-alterator chain via `priceFromPriceAlterators()` →
  `beehotel_pricealterator.alter` service `Alter::alter($data)`;
- returns `new Price($amount, $currency_code)` where `$amount` is the alterator-chain result
  (`bee_hotel_number_format`ed).

`Alter::alter()` loops **per night** over `days`, loads the unit's weekly **base table**
(`PreAlter::baseTable`), fetches enabled alterator plugins from
`plugin.manager.beehotel.pricealterator`, filters by annotation status + UI-enabled, runs each
plugin's `alter($data, $basetable)`, records a per-night stack in the session
(`alterators_current_stack`) and returns the **average** night price as `amount`. So the final
amount is entirely server-computed; the buyer only chooses legitimate inputs (dates, occupancy).

See the price-alterator plugin API in
[../../modules/beehotel_pricealterator/2.26.x/agent/plugins/alterator-api.md](../../modules/beehotel_pricealterator/2.26.x/agent/plugins/alterator-api.md).

## Guest messaging

- **Node type** `guest_message` (config/install) with fields `field_message`, `field_links`,
  `field_attachments`; used to compose post-sale/stay messages to guests.
- **Tokens**: YAML files in `config/guest_messages/*.yml` define tokens such as `room_name`,
  `checkin_time`, `checkout_time`, `guest_name`, `fullbalance`, `balance_cash_euro`,
  `balance_cash_currencies`. `BeeHotelGuestMessageTokens` (service
  `beehotel.guest_message_tokens`) loads and resolves them; `BeeHotelGuestMessageHooks` provides
  the hook glue. `Controller\TokensReader` (`/admin/beehotel/guestmessages/tokens`) renders the
  parsed token files for reference.
- **Mail preview**: `Form\BeeHotelGuestMessagesMail` at
  `/admin/beehotel/guestmessages/mail/preview/{node}/{commerce_order}`, and the order tab
  controller `Controller\GuestMessages` at
  `/admin/commerce/orders/{commerce_order}/guest-messages`.
- Balance tokens integrate with **Commerce Account Balance**; multi-currency amounts use
  **currencyapi**.

## BAT integration helpers

- `Event` (`bee_hotel.event`): reads/writes `bat_event_availability_daily_day_state`
  (`getNightState`, `setNightState`, `typeofOccupacy`), resolves night events.
- `BeeHotelBat` (`bee_hotel.beehotelbat`): unit↔event↔order lookups.
- `BeeHotelOrder` (`bee_hotel.order`): walks BAT event → booking → order-item → order and derives
  check-in/out dates and nights.
- `UnitStatusFromOrderService`: classifies a stay as check-in/check-out/running from dates.
