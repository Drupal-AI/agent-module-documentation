# Commerce checkout order fields — the checkout pane plugin

## Plugin: `order_fields`

`src/Plugin/Commerce/CheckoutPane/OrderFields.php`, extends
`Drupal\commerce_checkout\Plugin\Commerce\CheckoutPane\CheckoutPaneBase`.

```php
#[CommerceCheckoutPane(
  id: "order_fields",
  label: @Translation("Order fields"),
  deriver: OrderFieldsPaneDeriver::class,
)]
```

(Shipped as an annotation `@CommerceCheckoutPane` in the source.) It is a **derived** plugin:
the base id `order_fields` is never used directly — you place a derivative
`order_fields:<form_mode>`.

## Deriver: `OrderFieldsPaneDeriver`

`src/Plugin/Derivative/OrderFieldsPaneDeriver.php`. Uses `entity_display.repository` to list
`getFormModes('commerce_order')`, **removes `default`**, and creates one derivative per
remaining form mode:

```php
foreach ($form_modes as $form_mode_id => $info) {
  $this->derivatives[$form_mode_id] = [
    'label' => sprintf('Order fields: %s', $info['label']),
  ] + $base_plugin_definition;
}
```

So enabling the shipped "Checkout" form mode yields the pane **`order_fields:checkout`**
labelled "Order fields: Checkout". Add another order form mode and you get another pane
derivative for it. The derivative id (`checkout`) is also the form/view display mode the
pane renders — `getDerivativeId()`.

## Configuration + summary

`defaultConfiguration()`: `wrapper_element => 'container'`, `display_label => <plugin label>`.
`buildConfigurationForm()` adds a `wrapper_element` radios (Container/Fieldset) and a
`display_label` textfield (visible only when Fieldset is chosen). Config schema:
`commerce_checkout.commerce_checkout_pane.order_fields:*` (keys `wrapper_element`,
`display_label`).

## Runtime behaviour

- `buildPaneForm()` → `EntityFormDisplay::collectRenderDisplay($order, <derivative_id>)`,
  removes the `coupons` component, then `->buildForm($order, $pane_form, $form_state)`.
- `validatePaneForm()` / `submitPaneForm()` → `extractFormValues()` (+ `validateFormValues()`)
  so the fields are written back onto the order entity and saved with it.
- `buildPaneSummary()` → renders each non-empty component on the review step using the
  view-display mode whose id matches the form mode (falls back to default).
- Helpers: `getWrapperElement()`, `getDisplayLabel()`.

## Extending

There is no `*.api.php` and no plugin *type* of its own — `order_fields` is a plugin of
Commerce's existing `commerce_checkout_pane` type. To customise, subclass `OrderFields` (or
write your own `CheckoutPaneBase` plugin) rather than looking for a hook.
