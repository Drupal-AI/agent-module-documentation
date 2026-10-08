<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout wiring & data flow

No custom routes or permissions exist; everything runs inside the Commerce checkout form
(`multistep_default`). The moving parts:

## The pane — `PickupCapableShippingInformation`

`src/Plugin/Commerce/CheckoutPane/PickupCapableShippingInformation.php`, id
`pickup_capable_shipping_information`, extends commerce_shipping's `ShippingInformation`. It is
`final`. Config keys (`defaultConfiguration()`), on top of the parent's:

- `pickup_need_address` (bool) — when on, the customer first enters a start address; the pane then
  shows the provider picker alongside it, wires AJAX ("Recalculate shipping", address-select) and a
  wrapper for refresh. When off, the provider picker simply replaces the shipping-profile form.
- `require_shipping_profile` (bool) — hide shipping cost until a full address (country/locality/
  postal_code/address_line1) is entered; enforced by `canCalculateRates()`. Only meaningful with
  `pickup_need_address`.
- `auto_recalculate` (bool) — recalculate on address change; only meaningful with
  `require_shipping_profile`. `submitConfigurationForm()` down-forces both flags off unless their
  parent flag is set.

`buildConfigurationSummary()` prepends *Supports pickup* and reports the *Needs address from
customer* value. `isPickupSelected()` decides whether the current shipment uses a pickup method by
`str_contains(..., 'pickup')` on (in order) the submitted shipping-method value, the stored
shipment's plugin id, or the default rate id — so the `pickup_` id prefix is load-bearing.

## Two profiles

- The regular **shipping profile** (inline form `customer_profile`, scope `pickup`) collects the
  *start* address. `commerce_shipping_pickup_api_field_widget_single_element_form_alter()` (in
  `.module`) fires for `#profile_scope == 'pickup'` and hides name/organization/address_line2 and
  relabels the field ("…an address near you where we can look for pickup points").
- The **pickup profile** (inline form `pickup_profile`, scope `shipping`) holds the actual selected
  point. When `pickup_need_address` is on, both exist (start address + picker); when off, the pickup
  profile replaces the shipping profile and `form_state['shipping_profile']` is set to `NULL`.

`getShippingProfile($isPickup)` returns a fresh unsaved profile (uid 0) when switching between a
pickup and non-pickup selection so stale `pickup_location_data` / address doesn't leak across the
switch.

## The inline form — `PickupProfile`

`src/Plugin/Commerce/InlineForm/PickupProfile.php`, id `pickup_profile`.

- `buildInlineForm()` walks form → pane → order → shipment to find the selected shipping method
  plugin (or, on first display with no shipment, loads it from the default rate's shipping method).
  If it implements `PickupShippingInterface`, it calls `buildFormElement($this->entity,
  $start_address|NULL)` and mounts the result as the `pickup_dealer` element.
- `validateInlineForm()` calls the plugin's `validateForm()`, but skips it when the triggering
  element is a `#recalculate` (no point chosen yet).
- `submitInlineForm()` does the handoff:
  ```php
  $values = NestedArray::getValue($form_state->getValues(), $inline_form['#parents']);
  $profile->setData('pickup_location_data', $values['pickup_dealer']);
  $profile->unsetData('address_book_profile_id');   // never save a pickup point to the address book
  $profile->unsetData('copy_to_address_book');
  $this->shippingMethod->populateProfile($profile); // provider writes the real address
  $profile->save();
  ```
  `submitPaneForm()` then sets this profile on each shipment (`$shipment->setShippingProfile($profile)`)
  and saves.

## Billing-copy decorator

`ProfileFieldCopyWithoutPickup` (`commerce_shipping_pickup_api.services.yml`) decorates
`commerce_shipping.profile_field_copy`. `supportsForm()` returns `FALSE` (disables "billing same as
shipping") whenever any shipment's method id contains `pickup`, so the pickup point is never copied
into billing; otherwise it delegates to the inner service.

## Ready-made checkout flow

`config/optional/commerce_checkout.commerce_checkout_flow.pickup.yml` defines a `pickup` checkout
flow (`multistep_default`) with the `pickup_capable_shipping_information` pane already placed in the
`order_information` step. Install it or add the pane to your own flow.
