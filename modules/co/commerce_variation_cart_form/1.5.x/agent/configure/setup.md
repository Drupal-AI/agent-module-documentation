# Configuring Commerce Variation Cart Form

There is no settings page. Configuration is spread across three Commerce display forms plus a
per-display third-party setting.

## 1. Show the form on the variation display

Admin → Commerce → Configuration → Product Variation Types → *Manage display* for the
variation type. Set the **"Add to cart form"** field (pseudo-field id
`commerce_variation_cart_form`) to **visible**. It is hidden by default.

Config target: `core.entity_view_display.commerce_product_variation.<type>.<view_mode>`, add a
component keyed `commerce_variation_cart_form`.

### The `combine` third-party setting

On that same display-edit form a checkbox **"Combine order items containing the same product
variation"** appears. It is stored as a third-party setting on the display entity:

```
core.entity_view_display.commerce_product_variation.<type>.<mode>:
  third_party_settings:
    commerce_variation_cart_form:
      combine: true   # or false
```

Read it live:

```bash
drush php:eval '$d=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("commerce_product_variation.default.default"); var_export($d->getThirdPartySetting("commerce_variation_cart_form","combine"));'
```

Set it programmatically:

```php
$d->setThirdPartySetting('commerce_variation_cart_form', 'combine', TRUE)->save();
```

## 2. Choose which order-item fields appear in the form

The form uses the order-item form mode **`variation_cart_form`**
(`commerce_variation_cart_form_entity_type_build()` maps the operation to
`Drupal\commerce_cart\Form\AddToCartForm`). Admin → Commerce → Configuration → Order Item Types
→ *Manage form display* → pick the **"Variation Cart Form"** mode.

- Show only **Quantity** for a qty input, or **hide everything** for a bare "Add to cart"
  button with default quantity 1.

Config target: `core.entity_form_display.commerce_order_item.<type>.variation_cart_form` (the
module ships this optional config for the `default` order item type showing `quantity`, with
the `variation_cart_form` form mode `core.entity_form_mode.commerce_order_item.variation_cart_form`).

## 3. Wire the product display (typical use)

To replace the default single product add-to-cart form with per-variation forms: Product Types
→ *Manage display* → set the **Variations** field to **Rendered entity**, choosing the
variation view mode configured in step 1. Then on the product type **Edit** tab, uncheck
**"Inject product variation fields into the rendered product"** so the forms are not
duplicated.

## Runtime behavior

`hook_commerce_product_variation_view()` only builds the form if the display component is
present. It creates an order item from the variation, passes `combine` from the setting, sets
`#access` to the current user's `access checkout` permission, and marks the variation
unavailable (message) when unpublished.
