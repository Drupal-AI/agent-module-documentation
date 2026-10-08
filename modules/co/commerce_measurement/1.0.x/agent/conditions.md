<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_measurement — condition plugins

All three classes live in `src/Plugin/Commerce/Condition/`.

## MeasurementBaseCondition (abstract)

`extends \Drupal\commerce\Plugin\Commerce\Condition\ConditionBase implements ContainerFactoryPluginInterface`.

Injected services (via `create()`): `entity_type.manager`, `entity_field.manager`. From the entity
type manager it grabs `commerce_product_variation_type` storage.

`defaultConfiguration()` → `['measurements' => []] + parent`.

### getFields()
Loads **every** `commerce_product_variation_type`, calls
`entityFieldManager->getFieldDefinitions('commerce_product_variation', $bundle)`, and keeps every
field whose type is `physical_measurement`, mapped as
`[$field->getName() => ['measurement_type' => $field->getSetting('measurement_type'), 'field_name' => $field->getLabel()]]`.
Result is memoised in `$this->matchedFields`. If no such field exists, the config form shows only an
"There are no physical measurements field available" item.

### buildConfigurationForm()
Renders an AJAX-wrapped table (`measurements.items`) with columns Measurement / Field name /
Operator / Value / Operations. Per row:
- `measurement_type` — hidden, value = the field's measurement type (also shown via `#suffix`).
- `field_name` — hidden, value = the field machine name (label shown via `#suffix`).
- `operator` — select of `getComparisonOperators()`.
- `value` — a **`physical_measurement`** element scoped to that field's `#measurement_type`
  (number + unit).
- `remove` — submit button (AJAX) that drops the row.

An "Add measurement" select + submit adds a row from the fields not yet used. Note (rendered in the
form): "If you combine multiple measurement fields, operator between these measurements fields is
always AND". Add/remove go through the static `changeMeasurements()` submit handler (mutates the
`measurements` form-state store and `setRebuild()`), with `ajaxCallback()` returning the rebuilt
wrapper subtree.

### submitConfigurationForm()
Reads `$form_state->getValue($form['#parents'])`, drops the `actions` sub-array and each row's
`remove` button, and stores the cleaned rows in `$this->configuration['measurements']`.

### evaluateMeasurement($order_item_measurement, $values)
1. `$order_item_measurement = $order_item_measurement->convert($values['value']['unit'])` — convert
   the measured value into the condition's unit.
2. Build the threshold: `toMeasurement($measurement_type, $values['value'])` →
   `new (MeasurementType::getClass($type))($value['number'], $value['unit'])`.
3. `match ($values['operator'])`: `>=`→`greaterThanOrEqual`, `>`→`greaterThan`, `<=`→`lessThanOrEqual`,
   `<`→`lessThan`, `==`→`equals`; anything else throws `InvalidArgumentException`.

All comparisons are `physical\Measurement` value-object comparisons (exact, unit-aware). The plugin
returns a boolean only — it never sets a price, quantity, or adjustment.

## OrderItemMeasurement — `order_item_measurement`

`entity_type: commerce_order_item`. `evaluate()`:
- Asserts entity, gets the order item's `getPurchasedEntity()`.
- Returns `FALSE` if config is empty **or** there is no purchased entity.
- For each configured row: returns `FALSE` if the variation lacks the field or the field is empty;
  otherwise reads `->first()->toMeasurement()` and runs `evaluateMeasurement`. Any failing row →
  `FALSE`. All rows pass → `TRUE` (AND semantics).

## OrderItemTotalMeasurement — `order_total_measurement`

`entity_type: commerce_order`. `evaluate()`:
- Asserts entity, gets `$order->getItems()`; returns `FALSE` if config or items are empty.
- Builds a per-field running total: for each order item and each configured field, reads the
  variation measurement, `->multiply($order_item->getQuantity())`, and `->add()`s it into the
  running total for that field.
- Then runs `evaluateMeasurement` on each field's total against its row values; any failing field →
  `FALSE`, all pass → `TRUE`.
