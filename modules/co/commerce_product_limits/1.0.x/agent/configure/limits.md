# Configure product quantity limits

No admin settings page (`configure: null`). Limits are configured in two steps: **enable a trait on a
product variation type**, then **set the field value on individual variations**.

## The three entity-trait plugins

`@CommerceEntityTrait` plugins for `commerce_product_variation` (in
`src/Plugin/Commerce/EntityTrait/`):

| Trait id | Label | Field installed (unsigned integer) |
|---|---|---|
| `minimum_order_quantity` | Minimum order quantity | `minimum_order_quantity` |
| `maximum_order_quantity` | Maximum order quantity | `maximum_order_quantity` |
| `step_order_quantity` | Step order quantity | `step_order_quantity` |

Each trait's `buildFieldDefinitions()` creates a `BundleFieldDefinition` of type `integer`
(`unsigned`, number widget). Enabling the trait installs the field on the variation type; disabling
it removes the field.

## Step 1 — enable the trait on a variation type

**UI:** Commerce → Configuration → Product variation types → *Edit* the type → tick **Minimum
quantity** / **Maximum quantity** (the traits) → Save. The trait is recorded in the variation type's
`traits` list and the field is installed.

**Programmatic** (drush php:eval) — mirror what the type form does (install the field via the trait
manager, then add the trait id to the type config):

```php
$tm   = \Drupal::service('plugin.manager.commerce_entity_trait'); // EntityTraitManager
$type = \Drupal::entityTypeManager()->getStorage('commerce_product_variation_type')->load('default');

$trait = $tm->createInstance('maximum_order_quantity');
$tm->installTrait($trait, 'commerce_product_variation', 'default');   // installs the field
$type->setTraits(array_unique(array_merge($type->getTraits(), ['maximum_order_quantity'])));
$type->save();
```

Read which traits are enabled:

```bash
drush cget commerce_product_variation_type.default traits
```

To disable: `$tm->uninstallTrait($trait, ...)` and remove the id from `setTraits()`, then save.

## Step 2 — set the limit on a variation

Once the trait is enabled, each product variation of that type has the field. Set it like any field:

```php
$variation->set('maximum_order_quantity', 4)->save();   // cap at 4 per order
$variation->set('minimum_order_quantity', 2)->save();   // require at least 2
$variation->set('step_order_quantity', 6)->save();      // only multiples of 6
```

An **empty** field value means no limit for that variation.

## How limits are enforced

- **Server side (authoritative):** `Drupal\commerce_product_limits\AvailabilityChecker`
  (`commerce_product_limits.availability_checker`, tagged `commerce_order.availability_checker`).
  `applies()` matches any `commerce_product_variation` order item; `check()` compares the requested
  quantity (adding the quantity of a matching order item already in the cart) against
  `minimum_order_quantity` / `maximum_order_quantity` and returns
  `AvailabilityResult::unavailable("You must order at least @min…" / "You cannot order more than @max…")`
  when violated, blocking the add/update.
- **Client side (convenience):** `commerce_product_limits.module` alters two forms —
  `commerce_order_item_add_to_cart_form` (sets `#min`/`#max`/`#step` and the default quantity to the
  minimum) and `views_form_commerce_cart_form_default` (sets `#min`/`#max`/`#step` on each cart line's
  quantity) — for HTML5 validation only. (`step_order_quantity` is applied as `#step` in both forms;
  it is not separately enforced by the AvailabilityChecker.)

## Gotchas

- Not compatible with **Commerce Cart Flyout** (the cart-form alter targets the core cart view form).
- The install includes an update hook (`commerce_product_limits_update_9001`) that normalises the
  min/max field storage size to `normal` int; no action needed on fresh installs.
