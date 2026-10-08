<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout flows & panes

Source: `src/Plugin/Commerce/CheckoutFlow/*`, `src/Plugin/Commerce/CheckoutPane/*`, `templates/`,
`components/`, `commerce_donation_flow.module` (`hook_theme`).

## Checkout flows

- **`donation_checkout_flow` — `DonationCheckoutFlow`** (extends `CheckoutFlowWithPanesBase`).
  Donation-only flow. Steps: `donation` → `dedication` → `billing` → `payment` → (core `complete`),
  all with `has_sidebar = FALSE`. Highlights:
  - `getSteps()` appends the formatted donation amount to the **payment** button label
    (`Donate $X`, `/mo` when recurring).
  - `buildForm()` calls `$this->order->recalculateTotalPrice()` (server-side total), sets
    `autocomplete=off`, builds step **summaries** for completed steps, adds a per-step CSS class, and
    optionally renders a configured **offline donation link** (`#type => url`) on the donation step.
  - `redirectToStep()` / `getStepUrl()` / `submitForm()` reroute all navigation through
    `donation_controller_formPage`, propagating `donate_return`.
  - `buildConfigurationForm()` exposes `offline_link_title` + `offline_link_url` (schema:
    `commerce_checkout.commerce_checkout_flow.plugin.donation_checkout_flow`).
  - `panesToSummarize()` / `buildSummaries()` build the review-style summary via `PaneSummaryData`
    value objects; `#theme => commerce_donation_flow_summary_container`.
- **`donation_multistep_flow` — `MultistepWithDonation`** (extends `CheckoutFlowWithPanesBase`).
  For sites where a donation is an optional add-on in a normal store: standard
  login/order_information steps plus `donation`, `dedication`, `review`.

`PaneSummaryData` — readonly value object (`index`, `label`, `Url`, `panes[]`); constructor
`TypeError`s unless every pane implements `CheckoutPaneInterface`.

## Checkout panes

- **`DonationItemPaneBase`** (shared base). `getDonationItem()` finds the single `donation`-bundle
  order item (throws `\LengthException` if more than one). `buildPaneForm()` renders the order item's
  entity form for the pane's form mode; `validatePaneForm()` rebuilds the item from submitted values
  and runs the form-display field validation; `submitPaneForm()` saves the item (throws
  `MissingDonationItemException` if none in form state). **`buildDonationItem()` is where the unit
  price is (re)set server-side** from `field_donation_amount->first()->toPrice()`, the title is
  composed from gift type, and `field_recurring_begins` is set to +1 month for recurring gifts.
- **`DonationCheckoutPane`** (`commerce_donation_pane`, step `donation`). Uses form mode `donation`;
  AJAX-swaps the amount widget when gift type changes (`ajaxAmountUpdate`); requires JS to progress
  (adds `js-show`); when `commerce_recurring` is present, exposes a configurable monthly-giving
  message.
- **`MemorialCheckoutPane`** (`commerce_memorial_pane`, step `dedication`). Uses form mode
  `memorial`; **visible only** when `field_designated == 1` on the donation item — collects honoree
  and (optionally) recipient-notification fields.
- **`AddDonationPane`** (`commerce_donation_add_pane`). For the multistep flow only (hidden inside
  `donation_checkout_flow`). A single "add a donation" checkbox that adds/removes a zero-price
  `donation` order item on the order.
- **`ThankYouPane`** (`donation_thank_you`, step `complete`). Renders a thank-you with donor first
  name (from the billing profile address), the formatted amount, "every month" for recurring, and
  "in honor of @name". All dynamic text is emitted via `html_tag #value` (core `Xss::filterAdmin`)
  or `t()` placeholders. On build it removes the order id from the cart session.

## Templates & SDC components

`hook_theme()` registers `block__commerce_donation_flow_quick`, `commerce_donation_flow_summary`,
`commerce_donation_flow_summary_container`, and pane theme hooks. Twig templates in `templates/`
delegate to Single-Directory Components under `components/` (`panes/donation`, `fieldsets/dedication`,
`fieldsets/notification`, `summaries/summary_container`). Two behaviors: `donation.js` toggles the
memorial pane / relabels the Continue button off the "dedicate" checkbox; `notification.js` toggles
the recipient fieldset off the "notify" checkbox. All template output is rendered form
elements/render arrays (auto-escaped); no `|raw`.
