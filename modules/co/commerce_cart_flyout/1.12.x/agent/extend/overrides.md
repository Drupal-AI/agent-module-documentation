# Architecture, overrides, and theming points

This module is mostly a front-end layer over Commerce Cart API. Here is what it replaces and the seams
you can hook into.

## What it replaces / alters

- **Cart block class** — `commerce_cart_flyout_block_alter()` sets
  `$info['commerce_cart']['class'] = CartBlock::class` and `provider = 'commerce_cart_flyout'`, so the
  standard Commerce cart block renders as the flyout.
- **Server-side add-to-cart message** — `src/CommerceCartFlyoutServiceProvider.php` (a
  `ServiceProviderBase::alter()`) re-classes the `commerce_cart.cart_subscriber` service to
  `src/EventSubscriber/CartEventSubscriber.php` and injects `current_route_match`. That subclass
  overrides `displayAddToCartMessage()` to **skip** Commerce's "added to cart" status message when the
  current route has the `_cart_api` requirement (the flyout surfaces cart state client-side instead).

## The `_cart_api` requirement trick

In `AddToCart::viewElements()` the formatter calls
`$this->routeMatch->getRouteObject()->setRequirement('_cart_api', 'true')` at render time. This makes
the current route look like a Cart API route so that (a) the module's serializer normalizers run for
the response, and (b) the cart subscriber above suppresses the duplicate server message. It mutates
the in-memory route object for the request only.

## PreparedAttribute normalizer

`src/Normalizer/PreparedAttributeNormalizer.php` (service
`commerce_cart_flyout.normalizer.prepared_attribute`, tag `normalizer`, priority 10) normalizes
`Drupal\commerce_product\PreparedAttribute` objects: it loads the attribute value entities, and for
`commerce_product_rendered_attribute` element types attaches rendered markup (`->rendered`) so the JS
can show swatches. Used when the formatter serializes `attributeOptions`.

## JavaScript (Backbone) libraries

Defined in `commerce_cart_flyout.libraries.yml`:

- `flyout` → `js/module.js`, `js/models/CartBlock.js`, `js/views/CartBlock.js`,
  `js/views/CartOffcanvas.js` + `css/module.css`; depends on core jQuery, once, Drupal,
  drupalSettings, internal Backbone + Underscore.
- `add_to_cart` → `js/add-to-cart.js`, `js/models/AddToCart.js`, `js/views/AddToCart.js` +
  `css/add-to-cart.css`; also depends on `commerce_cart_flyout/flyout`.

The `.es6.js` sources are the authored versions; the `.js` files are the compiled output actually
loaded.

## Theme hooks / template overrides (theming seam)

`commerce_cart_flyout_theme()` registers these hooks (all `render element: elements`), each with a
Twig template in `templates/` you can override in your theme:

| Theme hook | Template |
|---|---|
| `commerce_cart_flyout_block` | flyout cart block wrapper |
| `commerce_cart_flyout_block_icon` | cart icon |
| `commerce_cart_flyout_offcanvas` | offcanvas panel |
| `commerce_cart_flyout_offcanvas_contents` | offcanvas contents |
| `commerce_cart_flyout_offcanvas_contents_items` | offcanvas line items |
| `commerce_cart_flyout_add_to_cart_button` | add-to-cart button |
| `commerce_cart_flyout_add_to_cart_variation_select` | variation selector |
| `commerce_cart_flyout_add_to_cart_attributes_select` / `_radios` / `_rendered` | attribute widgets |

These templates are rendered to strings server-side and handed to the Backbone views via
`drupalSettings` (`cartFlyout.templates` and `addToCart` / `theme`), so overriding the Twig changes
the client-rendered markup.
