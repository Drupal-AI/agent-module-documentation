<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Syncart is a custom cart module in the Synapse package.

---

Syncart is a **vendor-specific (Synapse) custom Commerce cart module** — part of a supplier's e-commerce
suite (paired with `syncabinet` for profile/auth), extending Drupal Commerce cart/checkout/order with that
vendor's customizations, using Commerce Cart, Checkout, Order and Commerce Checkout Link. Its public description
is minimal ("Custom syncart").

Use it only within the Synapse/syncart stack it belongs to. It is an e-commerce/custom module; because it is
vendor-specific and lightly documented publicly and it touches the **cart/checkout/order** flow (and pairs with
an auth module), **review its actual behaviour in context** — especially cart ownership, checkout and any
order/price handling — before relying on it. It layers on Commerce's own access; consult the vendor's
documentation for configuration.

---

- Provide vendor Synapse cart handling.
- Extend Commerce cart/checkout/order.
- Pair with syncabinet (profile/auth).
- Use Commerce Cart/Checkout/Order.
- Serve the vendor e-commerce suite.
- Be vendor-specific.
- REVIEW cart/checkout/order behaviour in context.
- Check cart ownership + price/order handling.
- Have minimal public documentation.
- Layer on Commerce's own access.
- Consult vendor documentation.
- Handle vendor cart.
- Extend the cart.
- Configure per vendor.
- Handle checkout.
- Review in context.
- Handle the suite.
- Manage carts.
- Verify behaviour.
- Provide vendor cart handling.
