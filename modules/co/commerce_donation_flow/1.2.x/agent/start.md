<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Donation Flow (commerce_donation_flow) — agent index

Adapts **Drupal Commerce** for **donations** instead of product sales. A donor picks or types an
**amount** (arbitrary by design), optionally switches one-time vs. monthly, optionally dedicates the
gift (in honor/memory of someone), and goes to payment — without cart/product UX. The amount becomes
a **`donation` order item** on a normal Commerce order; payment runs through whatever Commerce
gateway you pair. Version **1.2.0**. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version dir `1.2.x`.

## Dependencies

Drupal modules (`.info.yml`): `commerce:commerce_order`, `commerce:commerce_price`,
`commerce:commerce_payment`, `commerce:commerce_checkout`. No external PHP libraries; `composer.json`
only declares the four Commerce submodule requirements. Soft-detects `commerce_recurring` (enables
monthly-giving messaging) and `field_group` via `module_handler`.

## What it provides (from source)

- **`donation` order item type** (`config/optional/commerce_order_item.donation`) carrying the
  donation fields: `field_donation_amount` (commerce_price), `field_gift_type` (single/recurring),
  `field_designated` (bool, "dedicate this gift"), `field_designation_type` (list: honor/memorial),
  `field_honoree_first/last`, `field_recipient_first_name/last_name`, `field_card_email`,
  `field_message`, `field_notify`, `field_monthly`, `field_recurring_begins`. Three form modes
  (default/donation/memorial) and matching view modes/displays are shipped.
- **Routes + `DonationController`** — `/donate`, `/donate/{commerce_order}/{step}`,
  `/donate/{amount}/now` (quick), settings page. See [routes/routes-and-controller.md](routes/routes-and-controller.md).
- **Two checkout flows** — `donation_checkout_flow` (`DonationCheckoutFlow`, donation-only) and
  `donation_multistep_flow` (`MultistepWithDonation`, donation added to a normal store) — plus five
  **checkout panes** (donation, memorial/dedication, add-donation, thank-you, and a shared base).
  See [checkout/flows-and-panes.md](checkout/flows-and-panes.md).
- **`NewOrder` service** (`commerce_donation_flow.new_order`) that mints a draft order with a
  zero-price donation item; **`DonationLevelWidget`** AJAX price widget (preset levels + custom
  amount, one-time/monthly toggle); **`DonationSummaryFormatter`**. See
  [order/donation-item-and-widget.md](order/donation-item-and-widget.md).
- **Three blocks** — `commerce_donation_flow_link` (Donate link), `commerce_donation_flow_quick`
  (preset quick-donation amount links), `back_site_block` (Back to Site). See
  [blocks/blocks.md](blocks/blocks.md).
- **Permissions** (`.permissions.yml`): `make donation`, `view any donation complete`
  (restrict access). **Settings** `commerce_donation_flow.settings` (`DonationSettingsForm`,
  `admin/commerce/config/donation-settings`, permission `administer commerce_order_type`) chooses
  the /donate vs /cart routing model and wires order/item types and flows. **Config schema** for
  widget/block/flow/pane/settings. **`CartCheckoutRouteSubscriber`** denies core /cart & /checkout
  when the site is in "donate route only" mode. No `.install`; one hook: `hook_theme`.

## Amount & value flow (important)

The visitor sets the amount — that is by design. Server-side it is constrained: the custom-amount
widget element is `#type => number, #min => 5` (core validates min server-side); preset levels are
`preg_replace('/\D/','',...)` (digits only); the quick route requires `amount: \d+` (non-negative
integers). The order-item unit price is (re)built **server-side** from `field_donation_amount` in
`DonationItemPaneBase::buildDonationItem()` on every pane submit, and the order total is recalculated
in `DonationCheckoutFlow::buildForm()`. No money moves until the payment step, which the gateway
handles.
