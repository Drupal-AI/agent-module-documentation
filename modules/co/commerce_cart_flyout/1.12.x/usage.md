Commerce Cart Flyout replaces Drupal Commerce's default cart block with a JavaScript (Backbone) off-canvas "flyout" cart, and provides a client-side Add to Cart form formatter, both driven by the Commerce Cart API REST endpoints.

---

The module is a front-end reskin of Commerce's cart interactions. `hook_block_alter()` swaps the `commerce_cart` block plugin's class for its own `CartBlock` (`@Block id "commerce_cart_flyout"` is also registered), which renders an empty `<div class="cart-flyout">`, attaches the `commerce_cart_flyout/flyout` library, and passes Twig-rendered templates (icon, block, offcanvas, offcanvas contents/items) plus the cart page URL and icon into `drupalSettings.cartFlyout`; the Backbone views then build the live cart UI and talk to the `commerce_cart_api` endpoints. A field formatter, `commerce_cart_flyout_add_to_cart` (applicable to a product's `variations` field), renders a client-side add-to-cart form: it normalizes the product's enabled variations, injected fields, and prepared attributes into `drupalSettings.addToCart` and attaches the `add_to_cart` library. To feed the JS, it force-sets a `_cart_api` route requirement so the module's normalizers run, and a custom `PreparedAttributeNormalizer` expands attribute values (with optional rendered markup). A `ServiceProvider` + subscriber (`CartEventSubscriber`) suppress Commerce's server-side "added to cart" status message on `_cart_api` routes (the flyout shows it client-side). The only stored configuration is one block setting, `use_quantity_count` (schema `block.settings.commerce_cart_flyout`), toggling item-count vs summed-quantity display. Requires Commerce, Commerce Product, and Commerce Cart API; there is no admin settings page (`configure` null) and no permissions of its own. `CartBlock::blockAccess()` deliberately hides the flyout on the checkout route so the order can't be modified outside checkout.

---

- Give a Commerce store an off-canvas slide-in cart instead of the default cart block.
- Show a cart icon with a live item count that updates via AJAX as items are added.
- Toggle between counting distinct items and summing item quantities (`use_quantity_count`).
- Provide an in-page (no full reload) Add to Cart experience on product pages.
- Let shoppers pick product variation attributes (select/radios/rendered swatches) client-side.
- Render add-to-cart forms driven by the Commerce Cart API REST endpoints.
- Display an offcanvas cart contents list with per-item details rendered from Twig templates.
- Override the flyout markup by overriding the module's Twig templates in a theme.
- Suppress Commerce's default "added to cart" message and show cart state in the flyout instead.
- Keep the cart accessible from any page via a header cart block.
- Prevent cart modification on the checkout page (the flyout is access-denied there by design).
- Show rendered attribute swatches (e.g. color images) in the add-to-cart selector.
- Update cart totals and item counts without navigating away from the current page.
- Build a modern SPA-like cart UX on a Commerce site using Backbone views.
- Reuse the add-to-cart formatter on a product's variations field per view mode.
- Serve variation "injected fields" (price, images) that update as attributes change.
- Provide a mobile-friendly slide-out cart panel.
- Integrate the cart block into a custom theme header with your own icon/templates.
- Drive add-to-cart normalization through a custom prepared-attribute normalizer.
- Offer a drop-in cart replacement with no configuration beyond placing the block.
