<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion cart (trinion_cart) — agent index

**Session/user shopping cart, coupons and checkout built on trinion_tp `zakaz_klienta` order nodes.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends:** views, trinion_tp
- **Permissions:** `administer trinion_cart configuration`, `trinion_cart cart cuponi`

**Routes:** settings `/admin/config/system/trinion-store`; cart AJAX `/cart/add/{nid}`, `/cart/fast-checkout/{nid}`, `/cart/delete/{nid}`, `/cart/clear`, `/cart/recalculate`, coupon `/cart/coupon/{apply,remove,activate}`, checkout `/cart/checkout`, `/cart/success`. **Access checkers:** add_to_cart_one (bundle check), remove_from_cart (cart-membership), cart_empty. **View:** `tcart`.

**Security:** cart mutation routes (`/cart/clear`, `/cart/coupon/*`, `/cart/recalculate`, `/cart/success`) are gated only by `_permission: access content`; add-to-cart has no permission, only a bundle-type access check — so anonymous users can create/modify their OWN cart order nodes, set arbitrary quantities and apply coupons (by title) via URL params. Carts are scoped by uid/session; no cross-user IDOR observed. Admin/settings route is properly gated.

See [api/cart-routes.md](api/cart-routes.md).
