<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_measurement — agent start

Project name is **"Commerce Measurement Condition"**. Adds **Drupal Commerce condition plugins**
that evaluate the **physical measurement fields** (weight, volume, area, length, temperature — any
`physical_measurement` field type from the **physical** module) carried by purchased **product
variations**. It does **not** support the `physical_dimensions` (dimension) field type. Version
**1.0.3**. Core `^10.3 || ^11`. Package: Commerce (Contrib).

Pure condition provider: **no** routing, controllers, services, permissions, hooks, config schema,
`.install`/`.module`, forms exposed to customers, JS, or templates. It ships two `#[CommerceCondition]`
plugins plus an abstract base. Conditions return a **boolean** and never touch price, quantity, or
order totals — Commerce Core calls them only to decide whether a promotion / shipping method /
payment gateway (or any condition-aware entity) *applies*.

Depends on `commerce:commerce` and `physical:physical`. **No configuration page** — the conditions
are used inside the Conditions section of other Commerce entities' forms.

## The two conditions

- **`order_item_measurement`** (`OrderItemMeasurement`, entity type `commerce_order_item`, category
  Products) — label "Product variation measurements". Evaluates the measurement field(s) of a
  single order item's purchased variation. Returns FALSE if there is no config or no purchased
  entity, or if the field is missing/empty on the variation.
- **`order_total_measurement`** (`OrderItemTotalMeasurement`, entity type `commerce_order`, category
  Products) — label "Total product measurements". Sums, per configured field, each order item's
  variation measurement `->multiply($quantity)` and compares the **order-wide total** against the
  threshold.

Both extend `MeasurementBaseCondition`, which supplies the admin form, submit handling, and shared
evaluation. See [conditions.md](conditions.md) for the plugin internals, form/AJAX flow, and the
server-side evaluation path.

## How evaluation works (summary)

Admin config is a `measurements` array; each row = `{measurement_type, field_name, operator, value:{number, unit}}`.
`MeasurementBaseCondition::evaluateMeasurement()` converts the order-item measurement to the
condition's unit, builds the threshold via `physical\MeasurementType::getClass()`, and compares with
`greaterThanOrEqual` / `greaterThan` / `lessThanOrEqual` / `lessThan` / `equals` for operators
`>= > <= < ==`. Multiple rows are combined with **AND**. All values are read server-side from admin
config (the threshold) and from the variation's field (the measured value); the customer's only
input is the order quantity, which only scales the *total* condition.

## Source map

- `src/Plugin/Commerce/Condition/MeasurementBaseCondition.php` — abstract base: `buildConfigurationForm`
  (AJAX add/remove rows, `physical_measurement` value widget), `submitConfigurationForm`,
  `evaluateMeasurement`, `toMeasurement`, `getFields` (scans all `commerce_product_variation` bundles
  for `physical_measurement` fields).
- `src/Plugin/Commerce/Condition/OrderItemMeasurement.php` — per-order-item condition.
- `src/Plugin/Commerce/Condition/OrderItemTotalMeasurement.php` — order-total condition.
