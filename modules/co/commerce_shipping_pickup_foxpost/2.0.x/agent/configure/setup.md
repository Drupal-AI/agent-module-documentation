<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up Foxpost pickup shipping

1. `composer require drupal/commerce_shipping_pickup_foxpost` then `drush en commerce_shipping_pickup_foxpost`.
2. In your checkout flow add the `pickup_capable_shipping_information` pane (labelled *Shipping information*, summary shows *Supports pickup*), or switch to the pre-built `pickup` flow.
3. Add a shipping method in *Commerce → Configuration → Shipping methods* using the **Pickup shipping - Foxpost** (`pickup_hu_foxpost`) plugin.
4. Set *Pickup list refresh frequency* (Disabled / Hourly / Daily / Weekly). The chosen interval is stored in `state` (`commerce_shipping_pickup_foxpost.next_run`) and honoured by `hook_cron`.

## How the catalogue works
- `_commerce_shipping_pickup_foxpost_load()` GETs `https://cdn.foxpost.hu/foxpost_terminals_extended_v3.json` via `\Drupal::httpClient()` and maps each terminal to id/name/address fields.
- `_commerce_shipping_pickup_foxpost_save()` sorts with Hungarian `Collator` and `merge()`s a `serialize()`d `id => label` map into the `commerce_shipping_pickup_foxpost` table.
- `PickupFoxpostShipping::getPickups()` reads and `unserialize()`s that blob; if empty it refreshes on demand.

## Notes
- No config form of its own beyond the shipping-method plugin's cron-interval select.
- On fetch failure it logs to channel `commerce_shipping_pickup_foxpost` and returns an empty list.
