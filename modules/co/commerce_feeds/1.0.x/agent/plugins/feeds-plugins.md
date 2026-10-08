<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds plugins provided by Commerce Feeds

The module does not *define* any plugin type; it *implements* Feeds plugin types
(`@FeedsProcessor`, `@FeedsTarget`). They surface inside the Feeds feed-type UI/config.

## Processor

| id | title | entity_type | base class |
|---|---|---|---|
| `entity:commerce_product` | Product | `commerce_product` | `Drupal\feeds\Feeds\Processor\EntityProcessorBase` |

`ProductProcessor` is an empty subclass — it inherits all create/update/expire behaviour
from Feeds' generic entity processor, just bound to the `commerce_product` entity type.
Its `processor_configuration` is the standard Feeds entity-processor config (e.g.
`values.type` = product-type/bundle machine name, `update_existing`, `expire`,
`skip_hash_check`, `authorize`, `owner_feed_author`). There is a `@todo set default store`
in the source — no default store is auto-assigned, so map/set the store yourself if your
product type requires one.

## Field targets

All three implement `ConfigurableTargetInterface` (each has a per-target settings form).

### `commerce_feeds_price` — for `commerce_price` fields
- Maps one property: **`number`** (the amount).
- Config: **`currency_code`** (a `select` of all `commerce_currency` config entities).
  `defaultConfiguration()` auto-selects the code only when exactly one currency exists.
- At import, `prepareValue()` sets `values['currency_code']` from config, so every imported
  amount is stored with the chosen currency. Summary shows `Currency: <code>`.

### `commerce_feeds_physical_measurement` — for `physical_measurement` fields
- Maps one property: **`number`**.
- Config: **`unit`** (`select`); options come from the field's `measurement_type` setting
  (`MeasurementType::getUnitClass(...)::getLabels()`); default is that class's base unit.
- `prepareValue()` stamps `values['unit']`. Requires `drupal/physical`.

### `commerce_feeds_physical_dimensions` — for `physical_dimensions` fields
- Maps three properties: **`length`**, **`width`**, **`height`**.
- Config: **`unit`** (`select` of `LengthUnit::getLabels()`); default `LengthUnit::getBaseUnit()`.
- `prepareValue()` stamps a single shared `values['unit']` for all three. Requires `drupal/physical`.

A target only appears in the mapping UI if the destination product type actually has a
field of the matching `field_types`. Standard Feeds core targets (text, entity reference,
etc.) still apply to ordinary product fields (title, SKU, body, attributes).

## Implementing more

There is nothing to subclass here — to add mappers for other Commerce/physical field types
you write your own `@FeedsTarget` plugin in your module, following the same pattern
(`prepareTarget()` to declare properties, `prepareValue()` to stamp fixed config).
