<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Cart Dialog (commerce_cart_dialog) — agent index

**Renders the Commerce cart in a modal / off-canvas dialog with Ajax update/remove, via a dedicated `/cart/dialog` route and a cart block.**

- **Version:** 1.2.x
- **Core:** ^9 || ^10 || ^11 · **Package:** Commerce (contrib) · **Configure:** `commerce_cart_dialog.settings` (`/admin/commerce/config/ccd`, perm `access commerce administration pages`)
- **Dependencies:** commerce:commerce_cart
- **Routes:** `commerce_cart_dialog.page` `/cart/dialog` (`_access: 'TRUE'`, controller extends Commerce `CartController::cartPage()`); settings route (admin-gated).
- **Pieces:** `CartDialogController`, `DialogSettingsHelper` (tagged `render.main_content_renderer`), `Ajax/OpenDialogByPathCommand`, `Plugin/Block/CartDialogBlock`, `hook_form_alter()` adds `use-ajax-submit`/dialog-reload to cart update & remove buttons.
- **Security:** the `_access: 'TRUE'` `/cart/dialog` route mirrors core Commerce's public cart page — it takes **no order/cart ID** and calls `parent::cartPage()`, which resolves the **current** session/user's carts through the cart provider. No IDOR (no other-user cart is addressable) and no mutation beyond standard session-scoped cart operations. Settings form is admin-permission gated.

See [configure/settings.md](configure/settings.md)
