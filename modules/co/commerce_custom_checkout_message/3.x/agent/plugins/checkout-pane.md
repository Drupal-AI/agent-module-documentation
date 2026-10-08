<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout pane: `custom_checkout_message`

Single plugin `CustomCheckoutMessage` in
`src/Plugin/Commerce/CheckoutPane/CustomCheckoutMessage.php`, a Commerce Checkout Pane that shows a
configurable message inside a checkout flow. Extends
`Drupal\commerce_checkout\Plugin\Commerce\CheckoutPane\CheckoutPaneBase`.

## Plugin definition (annotation)

```
@CommerceCheckoutPane(
  id = "custom_checkout_message",
  label = @Translation("Custom checkout message"),
  display_label = @Translation("Message"),
  default_step = "_disabled",
  wrapper_element = "container",
)
```

- `default_step = "_disabled"` → not shown until an admin places it on a step.
- Pane plugins are discovered by the `commerce_checkout` pane manager; this module registers no
  route/service — Commerce owns the discovery and the admin UI.

## Install / enable

1. `drush en commerce_custom_checkout_message` (pulls in `commerce` + `commerce_checkout`).
2. Go to **`/admin/commerce/config/checkout-flows`**, edit a checkout flow.
3. Drag the **Message** pane out of *Disabled* onto a step (e.g. *Order information*, *Review*,
   *Complete*). Repeat per flow — configuration is per checkout flow.
4. Click the pane's *Edit* to set the message body and text format.

## Configuration storage

There is **no standalone config object** and no `config/install`. The pane's configuration is
embedded in the **checkout flow config entity** (`commerce_checkout.commerce_checkout_flow.*`) under
that flow's `panes.custom_checkout_message` mapping.

- `defaultConfiguration()`:
  ```php
  ['message' => ['value' => '', 'format' => 'plain_text']] + parent::defaultConfiguration()
  ```
- Schema (`config/schema/commerce_custom_checkout_message.schema.yml`):
  ```yaml
  commerce_checkout.commerce_checkout_pane.custom_checkout_message:
    type: commerce_checkout_pane_configuration
    mapping:
      message:
        type: text_format
        label: 'Custom Checkout Message'
        translatable: true
  ```
  It extends Commerce's base `commerce_checkout_pane_configuration` (which carries `step_id`,
  `weight`), adding a single `text_format` value → the message is `{ value, format }` and
  translatable.

## Config form (admin edit)

`buildConfigurationForm()`:

- `message`: `#type => 'text_format'`, `#title` *Message*, `#description` *"Provide a custom message
  in checkout flow."*, `#default_value` = stored value, `#format` = stored format, `#required = TRUE`.
- `token_help`: `#theme => 'token_tree_link'` — advertises available tokens.

`submitConfigurationForm()`: when there are no form errors, reads
`$form_state->getValue($form['#parents'])['message']` and assigns the whole `{value, format}` array
to `$this->configuration['message']`. Commerce persists it into the checkout flow entity.

## Rendering on the checkout page

`buildPaneForm()`:

```php
$message = $this->token->replace($this->configuration['message']['value'], [
  'commerce_order' => $this->order,
]);
$pane_form['message'] = ['#markup' => Markup::create($message)];
```

- Tokens are resolved with the **current order** as `commerce_order` context, so tokens such as
  `[commerce_order:order_number]`, `[commerce_order:total_price]`, `[commerce_order:mail]`, etc.
  interpolate live order data.
- The pane wrapper is a `container` (`wrapper_element`), so the markup is emitted inline at the
  pane's position on the step.

## Admin summary

`buildConfigurationSummary()` returns a string: `Format: <format><br />` followed by the
token-replaced message passed through `strip_tags()` and `Unicode::truncate(..., 100, FALSE, TRUE)`
— a short plain-text preview shown on the checkout-flow config screen.

## Services

Constructor/`create()` inject `entity_type.manager` (required by `CheckoutPaneBase`) and core
`token` (`$this->token`). Nothing else.

## Tokens example

Set the message body (Full HTML) to:

```
<p>Thanks, your order <strong>[commerce_order:order_number]</strong> totals
[commerce_order:total_price].</p>
```

Place the pane on the *Complete* step to echo the confirmed order back to the customer.

## What it does NOT provide

No permissions, no menu links, no routes, no `.module`/`.install`, no controllers, no JS/CSS
libraries, no submodules, no Drush. Access to configure it is governed entirely by Commerce's
checkout-flow admin permission on `/admin/commerce/config/checkout-flows`.
