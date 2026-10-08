<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Tracking — agent index

Adds a small self-service **order-tracking form** to a Drupal Commerce store: a visitor enters an
**order number** and the **email used on the order**, and the form reports (via AJAX) a configured
message plus a friendly **label mapped from the shipment's workflow state**. Depends on
`commerce_shipping`. Version **1.0.3**; core `^8||^9||^10||^11`; package Commerce (contrib).

Note the name: this module does **not** store or show a carrier tracking number or tracking URL. It
surfaces the shipment's **workflow state** (e.g. `draft`, `ready`, `shipped`) translated to a
site-defined label. Tracking numbers, if any, live on the `commerce_shipment` entity itself and are
not read by this module.

## What it provides

- **Block** `commerce_shipping_tracking_block` (`src/Plugin/Block/CommerceShippingTrackingBlock.php`) —
  renders the lookup form via the form builder. Place it with Block Layout. Admin label / category:
  "Commerce Shipping Tracking".
- **Lookup form** `CommerceShippingTrackingForm` (`src/Form/CommerceShippingTrackingForm.php`, form id
  `commerce_shipping_tracking_block`) — two inputs (`order_number` textfield, `email` email) and a
  submit that fires an AJAX callback `::getShipmentInfo`. Themed by `commerce_shipping_tracking`
  (`templates/commerce-shipping-tracking.html.twig`).
- **Settings form** `Settings` (`src/Form/Settings.php`, `ConfigFormBase`) — edits
  `commerce_shipping_tracking.settings`.
- **Standalone route** for the form as a full page (see routes below).

## Routes (`commerce_shipping_tracking.routing.yml`)

- `commerce_shipping_tracking.settings` — `/admin/commerce/config/shipping_tracking`, the config form,
  requires permission `access commerce shipping tracking settings`. This is also the `configure` link
  and appears in the admin menu under Commerce » Configuration » Shipping as **Order Tracking Settings**
  (`links.menu.yml` / `links.task.yml`).
- `commerce_shipping_tracking.admin` — `/commerce_shipping_tracking`, renders the same lookup form as a
  page, requires `_permission: 'access content'` (i.e. effectively public). The lookup form (whether on
  this route or in the block) is a public, unauthenticated endpoint by design; it is gated only by the
  submitted values (see lookup logic).

## Permission (`commerce_shipping_tracking.permissions.yml`)

- `access commerce shipping tracking settings` — access the configuration page. (No restrict-access
  flag; it only reaches the admin settings form.)

## Configuration object `commerce_shipping_tracking.settings`

Keys (`config/install/…settings.yml`, schema `config/schema/…schema.yml`, all `type: text`):

- `shipping_states` — a newline-delimited map of `machine_name|Label` lines
  (e.g. `draft|Preparing...`), parsed by `getStateMessages()` (`explode(PHP_EOL)` then `explode('|')`).
- `state_message` — message shown on a successful lookup (into `.success-message`).
- `error_message` — message shown when the lookup fails (into `.error-message`).

Config translation is provided (`…config_translation.yml`).

## Lookup logic (`getShipmentInfo` AJAX callback)

1. Requires both `order_number` and `email` to be non-empty (else returns `error_message`).
2. `getOrder()` loads a `commerce_order` by `order_number` (`loadByProperties`).
3. `getShippingState()` loads the first `commerce_shipment` for that order and returns its
   `getState()->value`; returns NULL when the order has no shipment.
4. A state label is returned **only** when: an order exists, `$order->mail->value === $email` (the
   submitted email equals the order's own email), and a shipment state exists. Otherwise the configured
   `error_message` is returned — the same message for "not found" and "email mismatch".
5. On success it emits `state_message` into `.success-message` and
   `state_messages[<shipment state machine name>]` into `.result-state` via `HtmlCommand`.

The returned strings (`state_message`, `error_message`, the mapped state label) are the
**administrator-entered config values**; the submitted order number and email are not reflected back.

## Trust / data notes

- The tracking-form inputs are **customer/visitor-supplied**; the state labels and messages are
  **administrator-entered** (behind the settings permission).
- The lookup returns only a mapped shipment-state label and a fixed message, keyed on the order number
  **plus** the matching order email — not the full order or shipment.

## No-op / minor

- `validateForm`/`submitForm` on both forms are empty (the lookup is entirely AJAX;
  `Settings::submitForm` writes config directly). `Settings::buildForm` calls
  `$form_state->setRebuild(TRUE)`.
- `hook_help` (settings/help page) and `hook_theme` are the only `.module` hooks. No `.install`, no
  Drush, no services file, no JS assets.
