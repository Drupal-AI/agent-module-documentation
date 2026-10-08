<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trinion cart adds a shopping cart, coupon handling and checkout on top of the trinion_tp trading model, storing carts as `zakaz_klienta` order nodes.

---

The cart is resolved per request in `CartController::loadCurrentCart()`: for authenticated users by `uid`, for anonymous visitors by a session id stored in `field_tc_sid`. AJAX routes under `/cart/*` add items (`/cart/add/{nid}`), fast-checkout, delete, clear, recalculate quantities, and apply/remove/activate coupons; a `CheckoutForm` at `/cart/checkout` collects order fields and a success page confirms. Product eligibility, cart membership and empty-cart state are enforced by three custom access checkers (`addToCartOneChecker`, `removeFromCartChecker`, `CartEmptyChecker`). Cart totals, discounts and VAT are computed in `getCartData()`.

Operationally: set the default responsible user and company node on the settings form (`/admin/config/system/trinion-store`, permission `administer trinion_cart configuration`), then expose the add-to-cart and cart views (`tcart`) in your theme. Security note: several mutating cart routes (`/cart/clear`, `/cart/coupon/*`, `/cart/recalculate`, `/cart/success`) are gated only by `access content`, and add-to-cart is gated by a bundle-type check with no permission, so anonymous visitors can create/modify their own cart order nodes and set arbitrary quantities/coupons via URL parameters — carts are scoped by uid/session (no cross-user IDOR observed), but discounts are applied by looking up coupon nodes by title.

---
- Add a product node to the cart with `/cart/add/{nid}` (optional `count`, `harakteristika`).
- Offer a one-click fast checkout with `/cart/fast-checkout/{nid}`.
- Remove a line item from the cart via `/cart/delete/{nid}`.
- Clear the whole cart with `/cart/clear`.
- Recalculate line quantities from posted data with `/cart/recalculate`.
- Apply a coupon by code with `/cart/coupon/apply/{coupon}`.
- Remove an applied coupon with `/cart/coupon/remove/{coupon}`.
- Toggle a coupon's active state with `/cart/coupon/activate/{coupon}/{op}`.
- Drive checkout through the `CheckoutForm` at `/cart/checkout`.
- Show a post-order confirmation at `/cart/success`.
- Configure the default responsible user and company at `/admin/config/system/trinion-store`.
- Render the cart with the bundled `tcart` view (page and block displays).
- Display a mini cart block and add-to-cart info modal via the Twig extension.
- Support anonymous shopping using a session-bound cart.
- Support logged-in shopping using a uid-bound cart.
- Compute totals, discounts and VAT per line automatically.
- Grant the "Coupons (list - view)" permission to manage coupon nodes.
- Apply a dedicated backend theme via the store theme negotiator.
- Trigger cart-related side effects through the event subscriber.
- Localise the storefront using the shipped translations.
