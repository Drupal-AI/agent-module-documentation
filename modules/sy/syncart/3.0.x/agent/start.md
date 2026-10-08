<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncart (syncart) — agent index

Vendor (Synapse) custom Drupal Commerce cart. Provides a JSON/AJAX cart, a cookie-based
favorites page, donation mode, a settings form, an admin order-number-sequence reset page,
and an admin-generated hashed checkout link. Core requirement `^11 || ^12`. Package: Synapse.
License GPL-2.0-or-later. No composer.json / no external libraries.

## Dependencies
- `commerce:commerce_cart`, `commerce:commerce_checkout`, `commerce:commerce_order`.
- Optionally installs `commerce_checkout_link` (update hook `syncart_update_8201`).

## What it provides
- **Routes/controllers** (`syncart.routing.yml`):
  - `CartApiController` — `/api/cart-load[/{cid}]` (`loadCart`), `/syncart/cart` (`cart`), `/syncart/debug` (admin).
  - `CartController` — `/cart/add-item`, `/cart/add-items`, `/cart/set-variation-quantity`,
    `/cart/set-order-item-quantity`, `/cart/set-item-note`, `/cart/remove-cart-item`,
    `/cart/refresh-stock`, `/syncart/checkout`, `/cart-repeat-order/{commerce_order}`.
  - `FavoriteController` — `/favorites` (cookie-driven wishlist).
  - `AdminController` — `/admin/config/syncart/administer`, `/admin/config/syncart/flush_sequence/{number_pattern_id}` (perm `administer commerce_order`).
  - `CheckoutLinkController` — `/admin/commerce/orders/{commerce_order}/checkout-link` (admin) and
    `/cart/checkout-link/{commerce_order}/{timestamp}/{hash}` (hashed resume link).
  - Settings form at `/admin/config/syncart` (perm `administer site configuration`).
- **Services** (`syncart.services.yml`): `syncart.cart` (`SynCartService`), `syncart.render`
  (`SynRenderService`), `syncart.checkout` (`CheckoutLink`), `syncart.admin` (`AdminService`),
  `syncart.product` (`ProductService`), `syncart.install` (`InstallService`).
- **Plugins**: `Plugin\Block\CartBlock`; `Plugin\Commerce\CheckoutPane\SyncartFinalize`.
- **Hooks** (`src/Hook/*`, wired from `syncart.module`): theme, presave (order/product/variation),
  page/product/receipt/title preprocess, page attachments, login/variation/checkout form alters.
- **Events**: `CheckoutLinkEvent` / `CommerceCheckoutLinkEvents::CHECKOUT_LINK_REDIRECT`;
  `EventSubscriber\OrderCompleteSubscriber` (receipt on completion).
- **Config**: `syncart.settings` (no config/schema shipped); install/optional/additional/settings
  YAML provisioning customer profile + user fields, product `field_stock`, image style, checkout flow,
  and per-language (en/es/kk/ru) order views.
- No permissions.yml (top-level module defines none); no Drush commands.

## Submodules (documented separately)
- `syncart_order_status` — order-status taxonomy + orders board. See `../../modules/syncart_order_status/3.0.x/agent/start.md`.
- `syncart_pos` — POS terminal cookie + order type. See `../../modules/syncart_pos/3.0.x/agent/start.md`.
- `syncart_product_feature` — paragraph product features + order processor. See `../../modules/syncart_product_feature/3.0.x/agent/start.md`.

## Solution docs
- Settings & install: [config/settings.md](config/settings.md)
- Cart/favorites/checkout-link endpoints: [api/cart-endpoints.md](api/cart-endpoints.md)
- Services (render/cart/checkout-link/admin): [services/services.md](services/services.md)
