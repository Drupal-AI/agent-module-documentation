# Set up the flyout cart and add-to-cart formatter

No admin settings page (`configure` null). Setup is: place the cart block and set the add-to-cart
formatter on the product display.

## 1. The cart flyout block

Source: `src/Plugin/Block/CartBlock.php` (`@Block id "commerce_cart_flyout"`, category "Commerce").

- On install, `hook_block_alter()` (`commerce_cart_flyout.module`) rewrites the core `commerce_cart`
  block plugin to use this class, so an existing placed cart block becomes the flyout automatically.
  You can also place the "Cart Flyout" block via Block layout (`/admin/structure/block`).
- `build()` returns `<div class="cart-flyout"></div>`, attaches library
  `commerce_cart_flyout/flyout`, and sets `drupalSettings.cartFlyout` with: `use_quantity_count`,
  Twig-rendered `templates` (icon, block, offcanvas, offcanvas_contents, offcanvas_contents_items),
  the cart page `url` (`commerce_cart.page`), and the cart `icon` URL (from the `commerce` module's
  `icons/ffffff/cart.png`). The Backbone JS then renders the live UI.
- **Access:** `blockAccess()` returns allowed unless the current route is `commerce_checkout.form` —
  the flyout is intentionally hidden on checkout so the order can't be edited outside checkout. Cache
  context `route` is added.

### The one setting: `use_quantity_count`

Block config form (`blockForm`) exposes a single checkbox:

| Setting | Default | Meaning |
|---|---|---|
| `use_quantity_count` | `FALSE` | OFF = count of distinct items in cart. ON = sum of all item quantities. |

Stored in the block's `settings` (schema `block.settings.commerce_cart_flyout`, key
`use_quantity_count`). Passed straight into `drupalSettings.cartFlyout.use_quantity_count`.

## 2. The Add to Cart formatter

Source: `src/Plugin/Field/FieldFormatter/AddToCart.php`
(`@FieldFormatter id "commerce_cart_flyout_add_to_cart"`).

- Applicable only to a **`commerce_product` entity's `variations`** entity-reference field
  (`isApplicable()` checks module `commerce_cart`, entity type, field name `variations`).
- Set it on the product's display: *Commerce → Configuration → Product types → [type] → Manage
  display*, set **Variations** format to **"Flyout add to cart form"**. (A `post_update` hook,
  `commerce_cart_flyout_post_update_update_add_to_cart_formatter`, auto-migrates existing
  `commerce_add_to_cart` formatters to this one on update.)
- It renders `<div data-product=… data-view-mode=… data-langcode=…>` and populates
  `drupalSettings.addToCart[<product uuid>]` with `defaultVariation`, normalized `variations`,
  `injectedFields`, the purchased-entity widget `type`, and (for attribute widgets)
  `attributeOptions` with normalized + rendered prepared attributes. Attaches
  `commerce_cart_flyout/add_to_cart` and the relevant theme templates.

There are no other configuration surfaces; everything else is JS behaviour and Twig template
overrides (see [../extend/overrides.md](../extend/overrides.md)).
