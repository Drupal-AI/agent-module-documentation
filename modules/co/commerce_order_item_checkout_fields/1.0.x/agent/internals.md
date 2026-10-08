<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Item Fields — internals

## Pane plugin: `order_item_fields`

`src/Plugin/Commerce/CheckoutPane/OrderItemFields.php`, extends
`Drupal\commerce_checkout\Plugin\Commerce\CheckoutPane\CheckoutPaneBase`.

```php
#[CommerceCheckoutPane(
  id: "order_item_fields",
  label: new TranslatableMarkup("Order item fields"),
  admin_description: ...,
  wrapper_element: "fieldset",
  deriver: OrderItemFieldsDeriver::class,
)]
```

A **derived** plugin: the base id `order_item_fields` is never placed directly — you place a
derivative `order_item_fields:<order_item_type>`. `getOrderItemTypeId()` reads
`$this->pluginDefinition['order_item_type']`.

Injected services (`create()`): `current_user`, `entity_display.repository`,
`commerce_order_item_checkout_fields.excluded_field_type_resolver`, and the
`logger.channel.commerce_order_item_checkout_fields` logger.

`defaultConfiguration()`: `form_display_mode => 'default'`, `require_complete => FALSE`.

## Deriver: `OrderItemFieldsDeriver`

`src/Plugin/Derivative/OrderItemFieldsDeriver.php`. Iterates
`entity_type.bundle.info`→`getBundleInfo('commerce_order_item')` and creates one derivative
per bundle that has qualifying fields (`getApplicableFieldDefinitions($bundle)` non-empty).
Each derivative carries `order_item_type`, per-bundle `label`/`display_label`/
`admin_description`, and cache tags `commerce_order_item_type_list` + `entity_field_info`.

Because the checkout-pane plugin manager caches definitions **without cache tags**, freshness
is additionally forced by clearing that manager's cache from `field_config` and
`commerce_order_item_type` insert/update/delete hooks in the `.module` file
(`_commerce_order_item_checkout_fields_invalidate_panes()`).

## Excluded-type resolver

`src/Resolver/ExcludedFieldTypeResolver.php` (interface
`ExcludedFieldTypeResolverInterface`, aliased as a service). Default excluded set:
`file`, `image`, `entity_reference_revisions`, run through
`hook_commerce_order_item_checkout_fields_excluded_types_alter()`.

`getApplicableFieldDefinitions($bundle)` returns, keyed by field name, only definitions that
are **`FieldConfigInterface`** (user-added configurable fields — this alone drops every base
field such as `quantity`, `unit_price`, `purchased_entity`, `total_price`) **and** whose type
is not excluded. Skipped incompatible fields are logged once per bundle at debug level.

## Which fields become editable (allow-list)

`getFormDisplay()` builds `EntityFormDisplay::collectRenderDisplay($order_item, $mode)`
(falls back to the default display if `$mode` does not exist), then **removes every component**
that is not both:
1. in `getApplicableFieldDefinitions()` (configurable, non-excluded), and
2. `$order_item->get($name)->access('edit', $currentUser)` (per-field edit access).

So the rendered/stored set is: chosen form display mode ∩ user-added configurable fields ∩
per-field edit access. Base price/quantity fields are never in it.

## Storage paths (chosen per order item from its quantity)

`getMatchingOrderItems()` returns the order's items whose bundle matches this derivative.
Non-integer quantities are skipped with a customer warning. For each item `unit_count = (int)
quantity`, `use_path_b = (unit_count === 1)`.

- **Path B (quantity == 1)** — `buildPaneForm()` renders one fieldset against the real order
  item; `submitPaneForm()` calls `extractFormValues($order_item, …)` then `$order_item->save()`
  (value at delta 0).
- **Path A (quantity > 1, combined)** — one fieldset per product. Each slot is rendered from a
  throwaway `createDuplicate()` clone holding only that product's delta (`prepareEntity()`).
  `cropMultiValueWidgets()` strips the "Add another item" button and delta rows > 0 so each
  slot collects exactly one value per field. On submit, values are collected per delta from
  per-product clones and assembled into `$order_item->set($field_name, $field_values)` (delta
  == product index), then saved.

`#parents` namespaces each delta under `order_item_<id>/<delta>` so widget state never collides
across deltas, items, or panes on the same step.

## Validation

`validatePaneForm()`: skips non-integer quantities; enforces **form integrity** — the count of
submitted delta groups must equal the current quantity (else `setError`, no partial save);
runs `extractFormValues()` + `validateFormValues()` per delta (Path A uses per-product clones
so field constraint validators run per product). When `require_complete` is on (Path A only),
each non-empty-optional field is additionally required per product (skipping fields already
required at field level to avoid duplicate errors).

## Summary (review step)

`buildPaneSummary()` renders stored values with the view builder, reusing the form display mode
id as the view mode (falls back to default). Path B renders each non-empty field; Path A
renders one fieldset per product, each field rendered from a single-value clone of that delta.
Values go through field formatters (escaped on render).

## Cardinality helper + requirements

`OrderItemFields::findLimitedCardinalityFields($bundle, $mode)` (static): applicable fields
present in the render display whose storage cardinality is not
`CARDINALITY_UNLIMITED`. Used by the pane-config validation warning and by
`hook_requirements()` (`.install`, runtime phase → status-report warning). At checkout,
`warnInsufficientCardinality()` logs a warning if a field's cardinality is below the actual
cart quantity on a combined item.

## Cart lifecycle

`src/EventSubscriber/CartQuantitySubscriber.php` subscribes to
`CartEvents::CART_ORDER_ITEM_UPDATE` (`commerce_cart.order_item.update`). On a **quantity
decrease** it slices each applicable field's values to the new `unit_count`
(`array_slice(..., 0, $unit_count)`) and saves the item, trimming orphaned deltas. Increases
need no action (new slots are prompted next visit). Saving the item does not re-dispatch the
cart event, so no recursion.

## Extending

There is no plugin *type* of its own — `order_item_fields` is a plugin of Commerce's existing
`commerce_checkout_pane` type. The only hook provided is the excluded-types alter
(`commerce_order_item_checkout_fields.api.php`). To customise further, subclass
`OrderItemFields` or write your own `CheckoutPaneBase` plugin.
