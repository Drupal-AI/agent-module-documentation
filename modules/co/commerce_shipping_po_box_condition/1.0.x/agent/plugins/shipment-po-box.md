<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugin: `shipment_po_box` — ShipmentPOBox

File: `src/Plugin/Commerce/Condition/ShipmentPOBox.php`
Class: `Drupal\commerce_shipping_po_box_condition\Plugin\Commerce\Condition\ShipmentPOBox`
extends `Drupal\commerce\Plugin\Commerce\Condition\ConditionBase`.

## Annotation

```
@CommerceCondition(
  id = "shipment_po_box",
  label = @Translation("Shipping PO Box"),
  category = @Translation("Customer"),
  entity_type = "commerce_shipment",
  weight = 10,
)
```

Because `entity_type = commerce_shipment`, the condition is offered on shipping methods and is
evaluated against the `commerce_shipment` entity during Commerce Shipping's rate resolution.

## Configuration

- `defaultConfiguration()`: `['negate' => NULL]` merged with the parent defaults.
- `buildConfigurationForm()`: adds a non-editable `#type => item` info line
  ("Checks for the existence of a PO Box in the address.") and a `negate` checkbox titled *Negate*
  ("If checked, the condition succeeds if there is no PO Box.").
- `submitConfigurationForm()`: reads `$form_state->getValue($form['#parents'])` and stores
  `configuration['negate']`.

Config schema is inherited from Commerce's condition plugin base (the module ships no
`config/schema` of its own; `provides_config_schema` in data.json reflects the base-provided schema).

## Evaluation (`evaluate(EntityInterface $entity)`)

1. `assertEntity($entity)` — enforces the annotated entity type.
2. `$shipment->getShippingProfile()` — returns `FALSE` if there is no shipping profile.
3. First `AddressItem` of the profile's `address` field — returns `FALSE` if absent (address not
   yet known). This means the method is treated as "not matched" until an address exists.
4. Two case-insensitive `preg_match` tests against **address line 1 only**
   (`$address->getAddressLine1()`):
   - `/\bP\.?O\.?\s*Box[\d\s]/i` — PO Box with optional dots and spacing, requiring a trailing
     digit or space (so a bare "PO Box" with nothing after does not match).
   - `/\bHC\s*\d*\s*Box[\d\s]/i` — Highway Contract box form.
5. Returns `configuration['negate'] ? !$contains_po_box : $contains_po_box`.

Mechanism notes for integrators:
- Matching runs against **address line 1** (`getAddressLine1()`) using the two English-form
  patterns above; the trailing `[\d\s]` means a digit or space is expected after "Box".
- Matching is purely server-side over the order's stored shipping address; the plugin only
  includes/excludes the shipping method and never changes a rate amount.
