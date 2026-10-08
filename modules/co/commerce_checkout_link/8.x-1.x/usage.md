<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Checkout Link makes it possible to share a link to an order with a user so they can complete checkout.

---

Commerce Checkout Link generates a shareable link to a Drupal Commerce order — so a store can send a
customer a link that takes them straight to that order's checkout (resume an abandoned cart, complete a
staff-created order, or a guest checkout by email) without requiring a login. It depends on Commerce Order
and Cart.

Use it to share order/checkout links. Its security is implemented correctly: the link carries an **HMAC**
(`Crypt::hmacBase64(timestamp . order_id . changed_time, Settings::getHashSalt())`) — keyed with the site's
**secret hash salt** — that the controller validates with **`hash_equals()`** (constant-time), and it
incorporates a timestamp and (optionally) the order's changed-time so links are scoped/can invalidate. So an
attacker **cannot forge** a valid link for an arbitrary order without the site's hash salt. The one thing to
respect: a valid link grants access to that order's checkout (viewing the cart, entering addresses,
completing payment), so **treat the links as sensitive** — send them over HTTPS to the right recipient only,
and rely on the changed-time invalidation. It has no access-control role beyond the signed link. Configure
the checkout-link behaviour.

---

- Share a link to an order's checkout.
- Let customers resume/complete checkout.
- Support abandoned-cart/guest/staff-created orders.
- Depend on Commerce Order and Cart.
- Sign the link with an HMAC (keyed by the hash salt).
- Validate with hash_equals (constant-time).
- Scope the link with a timestamp/changed-time.
- Prevent forging links (needs the hash salt).
- Treat the links as sensitive.
- Send links over HTTPS to the right recipient.
- Rely on changed-time invalidation.
- Have no access-control role beyond the signed link.
- Configure the checkout-link behaviour.
- Resume checkout via link.
- Handle order links.
- Send checkout links securely.
- Generate signed links.
- Complete orders via link.
- Configure links.
- Share order links.
