<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Pickup API (commerce_shipping_pickup_api) — agent index

Framework for **pickup-point / parcel-machine shipping methods** in Drupal Commerce. Ships no real
carrier: a provider module extends the base pickup shipping method, renders a pickup-point picker at
checkout, and the framework writes the customer's chosen point into the shipment's shipping profile
address. Version **1.0.3**. Core `^8.7.7 || ^9 || ^10 || ^11`.

Depends on `commerce`, `commerce_checkout`, `commerce_shipping`, `profile` (info.yml). No routing,
no permissions, no config schema, no hooks except one field-widget alter. All UI lives inside the
Commerce checkout form.

## What it provides

- **Checkout pane** `pickup_capable_shipping_information` (`PickupCapableShippingInformation`,
  extends commerce_shipping's `ShippingInformation`) — the "Shipping information" pane whose summary
  reads *Supports pickup*. Adds a *Needs address from customer* toggle (`pickup_need_address`) plus
  `require_shipping_profile` / `auto_recalculate`.
- **Inline form** `pickup_profile` (`PickupProfile`, extends `EntityInlineFormBase`) — builds the
  provider's picker element (`pickup_dealer`) and, on submit, stores the raw selection into the
  profile's `pickup_location_data` data key, then calls the plugin's `populateProfile()`.
- **Shipping method base classes** in `Plugin/Commerce/ShippingMethod/`: `PickupShipping` (concrete,
  throws if the two required methods aren't overridden) and `PickupShippingMethodBase` (`abstract`).
  Both add a single `pickup` shipping service with a configurable flat rate label/description/amount.
- **Interface** `PickupShippingInterface` — the contract provider plugins implement
  (`buildFormElement()`, `populateProfile()`, optional `validateForm()`).
- **Service decorator** `commerce_shipping_pickup_api.profile_field_copy.decorator`
  (`ProfileFieldCopyWithoutPickup`) — decorates `commerce_shipping.profile_field_copy` to disable
  "billing same as shipping" copy when a pickup method is selected.
- **Hook** `hook_field_widget_single_element_form_alter` (in `.module`) — on the `pickup` profile
  scope, relabels the address field and hides name/organization/address_line2.
- **Optional config** `config/optional/…checkout_flow.pickup.yml` — a ready-made `pickup` checkout
  flow wired with the pickup pane.
- **Submodules** (sample providers): `commerce_shipping_pickup_demo` (two hard-coded dealers, select
  list) and `commerce_shipping_pickup_store` (single preset in-store address).

## Solution docs

- Implementing a provider: interface contract, the two selection patterns (list vs. online
  selector), address handoff → [plugins/pickup-method.md](plugins/pickup-method.md)
- How the pane + inline form + decorator wire together at checkout (data flow, config keys, AJAX,
  `pickup_location_data`) → [architecture/checkout.md](architecture/checkout.md)
