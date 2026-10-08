<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Custom Checkout Message (commerce_custom_checkout_message) — agent index

One **Commerce checkout pane** that renders an admin-authored, token-aware message at a step of a
Commerce checkout flow. Package `Commerce`. Version **3.0.1** (dir `3.x`). License GPL-2.0-or-later.
Core `^10.3 || ^11`.

- **The pane plugin, its config storage/schema, the message widget, tokens, and how to enable/place it** →
  [plugins/checkout-pane.md](plugins/checkout-pane.md)

## What it actually is

- A single plugin: `CustomCheckoutMessage` (`@CommerceCheckoutPane` id **`custom_checkout_message`**,
  label *"Custom checkout message"*, display_label *"Message"*), in
  `src/Plugin/Commerce/CheckoutPane/CustomCheckoutMessage.php`, extending
  `CheckoutPaneBase` from `commerce_checkout`.
- **Dependencies:** `commerce` (`^3`, `>=3`) and `commerce_checkout`. No other Drupal deps.
  Composer requires only `drupal/commerce:^3`.
- **Provides:** the one pane plugin only. **No** routes, permissions, services, controllers,
  forms of its own, entities, hooks, install file, `config/install`, Drush, JS, or CSS.
- `default_step = "_disabled"` and `wrapper_element = "container"` — the pane is shipped disabled;
  an admin must enable it and drag it onto a step per checkout flow.

## Mechanism (from source)

- **Configuration lives in the checkout flow config entity**, not a standalone config object.
  `defaultConfiguration()` returns `message => ['value' => '', 'format' => 'plain_text']`.
- **Config form** (`buildConfigurationForm()`): a `#type => 'text_format'` element (title *Message*,
  `#required`) plus a `token_tree_link` helper. `submitConfigurationForm()` stores the submitted
  `['value','format']` array into `$this->configuration['message']`.
- **Render** (`buildPaneForm()`): runs `$this->token->replace($value, ['commerce_order' => $order])`
  then outputs it. **Admin summary** (`buildConfigurationSummary()`): token-replaced, `strip_tags`,
  truncated to 100 chars, prefixed with the format name.
- **Schema:** `config/schema/commerce_custom_checkout_message.schema.yml` extends
  `commerce_checkout_pane_configuration` with `message: { type: text_format, translatable: true }`.
- Injected services: `entity_type.manager` (via base) and core `token`.

## Configure / operate

Enable the module, then at **`/admin/commerce/config/checkout-flows`** edit a flow, move the
**Message** pane from *Disabled* onto a step, and set its message. See
[plugins/checkout-pane.md](plugins/checkout-pane.md) for the config-array shape and a token example.
