# Commerce Cart Flyout — agent index

Replaces Commerce's cart block with a Backbone off-canvas flyout cart and adds a client-side
Add-to-Cart form formatter, both driven by Commerce Cart API. No admin settings page
(`configure` null), no permissions, one block setting. Requires `commerce_cart`,
`commerce_product`, `commerce_cart_api`.

- **Place the flyout block, the `use_quantity_count` setting, and apply the
  `commerce_cart_flyout_add_to_cart` formatter** → [configure/setup.md](configure/setup.md)
- **What it overrides/replaces: block_alter, service provider + cart subscriber, the `_cart_api`
  requirement trick, normalizer, JS libraries & theme hooks (for theming/extension)** →
  [extend/overrides.md](extend/overrides.md)

Key facts:
- `CartBlock` (`@Block "commerce_cart_flyout"`) renders `<div class="cart-flyout">` + attaches
  `commerce_cart_flyout/flyout` and `drupalSettings.cartFlyout`. `hook_block_alter()` also points the
  core `commerce_cart` block at this class. Hidden on the `commerce_checkout.form` route by design.
- Formatter `commerce_cart_flyout_add_to_cart` (product `variations` field) → `drupalSettings.addToCart`.
- Only config: `use_quantity_count` bool (schema `block.settings.commerce_cart_flyout`).
