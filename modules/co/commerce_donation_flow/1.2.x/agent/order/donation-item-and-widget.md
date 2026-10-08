<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Donation order item, NewOrder service, amount widget & formatter

Source: `src/NewOrder.php`, `src/Plugin/Field/FieldWidget/DonationLevelWidget.php`,
`src/Plugin/Field/FieldFormatter/DonationSummaryFormatter.php`, `config/optional/*`,
`config/schema/commerce_donation_flow.schema.yml`, `config/install/commerce_donation_flow.settings.yml`.

## The `donation` order item type

Shipped as optional config on `commerce_order_item.donation` with fields: `field_donation_amount`
(`commerce_price`), `field_gift_type` (list: single/recurring), `field_designated` (bool),
`field_designation_type` (list: `honor` / `memorial`), `field_honoree_first` / `field_honoree_last`,
`field_recipient_first_name` / `field_recipient_last_name`, `field_card_email`, `field_message`,
`field_notify` (bool), `field_monthly`, `field_recurring_begins` (datetime). Three form modes
(default, donation, memorial) and matching view modes/displays scope which fields each pane shows.

## `NewOrder` service (`commerce_donation_flow.new_order`)

- `get($giftType='single', $orderItemTypeId='donation')` — creates a `draft` order (order type read
  from the item type's `orderType`, else `default`), `cart => TRUE`, owned by the current user and
  current store, then adds a **zero-price** donation item.
- `addDonationItem($order, $price=0, ...)` — builds a `Price($price, <store default currency>)`,
  creates the `donation` order item titled "Donation", sets unit price and gift type, calls
  `prepopulate()`, and adds it to the order.
- `prepopulate($donation)` — for each **query-string** parameter, if the donation item has a field
  `field_<key>` it sets that field from the value. This lets a `/donate?...` link pre-fill donation
  fields (e.g. gift type, message). The donation **amount** it may set this way is always overwritten
  before payment — the donation pane rebuilds the unit price from the widget on submit
  (`DonationItemPaneBase::buildDonationItem`), and the quick route sets the amount explicitly from
  `{amount}`. Only the donation item's own donor-editable fields are reachable.

## `DonationLevelWidget` (`commerce_donation_flow_level_widget`)

AJAX price-field widget for donation levels. Field-type: `commerce_price`.

- Settings (`settingsForm`): preset **single** and **monthly** level amounts (`level_1..level_5`),
  each a `#type => number, #min => 5, #step => 5`; plus a `currency` setting (schema
  `field.widget.settings.commerce_donation_flow_level_widget`).
- `formElement()` renders a `radios` list of preset amounts plus a `custom_amount` option, and a
  custom **`amount`** element `#type => number, #min => 5, #step => 'any'` ("Other Amount"). Core
  validates `#min` server-side, so amounts below 5 (including zero/negative) are rejected on submit.
- `massageFormValues()` — for the custom option, empty is coerced to `0` and the store currency is
  attached; for preset options the value is `preg_replace('/\D/','', ...)` (digits only). So the
  number written to `field_donation_amount` is always non-negative and numeric.
- `init()` clears/recomputes options and default when gift type changes (one-time vs. monthly),
  driving the AJAX swap in `DonationCheckoutPane::ajaxAmountUpdate`.

## `DonationSummaryFormatter` (`commerce_donation_summary_formatter`)

Field formatter for `commerce_price`. Renders "Donating @amount" (or "@amount/mo" when the item's
gift type is recurring) using the current store currency via `CurrencyFormatter`; the amount is
passed through a `t()` placeholder (escaped). Used by the donation/memorial summary view modes.

## Settings config (`commerce_donation_flow.settings`)

Written by `DonationSettingsForm` (see routes doc). Keys: `donation_route` (`donate` / `cart` /
`both`), and per-route `*_item_type`, `*_order_type`, `*_checkout_flow`. Install defaults: donate-only
mode, `donation` item type, `default` order type, `donation_flow` checkout flow. Saving also stamps
the chosen checkout flow (third-party setting) and order-item→order-type association onto the relevant
Commerce entities and rebuilds routes.
