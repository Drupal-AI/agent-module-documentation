<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Implementing a pickup provider

A provider module ("Commerce Shipping Pickup Your-Service") declares one Commerce shipping method
plugin per service and implements `PickupShippingInterface`
(`src/PickupShippingInterface.php`). Naming convention (README): plugin id starts with `pickup_`,
then a country code, then the service name — e.g. `pickup_ch_parcelpoint`. The `pickup_` prefix is
required: the pane/decorator detect pickup methods with `str_contains($plugin_id, 'pickup')`.

## Base classes

Two bases in `Plugin/Commerce/ShippingMethod/`, both extending Commerce's `ShippingMethodBase` and
implementing `PickupShippingInterface`, both defining a single `pickup` shipping service and the
flat-rate config form (`rate_label`, `rate_description`, `rate_amount`):

- `PickupShippingMethodBase` (**abstract**) — `buildFormElement()` and `populateProfile()` are
  abstract; `validateForm()` is a no-op you may override. Preferred base for new providers.
- `PickupShipping` (concrete) — identical, but the three interface methods `throw \Exception` unless
  you override them. Extend this only when you cannot use the abstract base.

`calculateRates()` returns one `ShippingRate` built from `rate_amount`/`rate_description` — pickup
rate is a fixed flat rate, independent of the chosen point. Override it for distance/weight logic.

## Interface contract (`PickupShippingInterface`)

```php
public function buildFormElement(ProfileInterface $profile, array $start_address = NULL): array;
public function populateProfile(ProfileInterface $profile): void;
public function validateForm(array &$form, FormStateInterface $form_state): void; // optional
```

- **`buildFormElement($profile, $start_address)`** returns the render array for the pickup-point
  picker. It is injected into the inline form as the `pickup_dealer` element.
  - `$start_address`: the customer's start address (from the shipping profile) when the pane's
    *Needs address from customer* setting is on; `[]` if that address is incomplete; `NULL` if the
    setting is off. Use it to fetch nearby points.
  - If a map selector already captured a point, it can submit a truthy `known_location` value; the
    framework detects it, skips re-asking for a start address, and merges it into `$start_address`
    (passed through verbatim — you handle its contents).
- **`populateProfile($profile)`** reads back what the user selected and writes the real pickup
  address onto the profile. The framework has already stored the submitted `pickup_dealer` values
  into `$profile->getData('pickup_location_data')` before calling this. Always set `country_code`
  (required for a Commerce address); the rest is up to you:

  ```php
  $data = $profile->getData('pickup_location_data');
  $profile->set('address', [
    'country_code' => 'CH',
    'organization' => $data['organization'],
    'address_line1' => $data['address_line1'],
    'address_line3' => $data['id'],
  ]);
  ```
- **`validateForm()`** (optional) runs inside the inline form's validate, but is skipped during
  "Recalculate shipping" (no point selected yet). Use `$form_state->setErrorByName(...)`.

## Two selection patterns

1. **List** — the service exposes a fixed set of points. Return a `select` in `buildFormElement()`
   keyed by an id; `pickup_location_data` becomes that id, and `populateProfile()` looks the address
   up. See `commerce_shipping_pickup_demo` (`PickupDemoShipping`): a `select` over two hard-coded
   `$dealers`, `populateProfile()` does `$profile->set('address', $this->dealers[$id])`.
2. **Online / map selector** — embed a widget (e.g. an `iframe`) plus `hidden`/`textfield` elements
   that the selector fills with the chosen point's id, name and address. `pickup_location_data`
   becomes that whole array. `commerce_shipping_pickup_store` (`PickupStoreShipping`) is a minimal
   variant: a single admin-configured `address` config value rendered read-only, submitted via a
   `hidden` element and copied to the profile.

## Registration

```yaml
# your_module.info.yml
dependencies:
  - commerce_shipping_pickup_api:commerce_shipping_pickup_api
```

```php
/**
 * @CommerceShippingMethod(
 *   id = "pickup_ch_yourservice",
 *   label = @Translation("Pickup shipping - Your Service"),
 * )
 */
class PickupYourServiceShipping extends PickupShippingMethodBase { /* two methods */ }
```

Then create a `commerce_shipping_method` config entity selecting this plugin, and add the
`pickup_capable_shipping_information` pane to the checkout flow. Set the pane's *Needs address from
customer* according to whether your `buildFormElement()` needs a start address.
