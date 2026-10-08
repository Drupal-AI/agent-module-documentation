<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Coupon After Order creates a single-use Commerce promotion coupon when an order reaches a configured workflow transition and e-mails the code to the customer.

---

Coupon After Order is a Drupal Commerce add-on that generates a reward coupon after a purchase. An
event subscriber listens on the order workflow (the `place` transition by default, configurable) and,
when an order transitions, finds the first enabled promotion flagged with the module's "Create coupon
after order" base field (optionally gated by a per-promotion minimal order price), generates a random
single-use coupon code for that promotion, and — if enabled — sends a tokenized, translatable e-mail to
the order's e-mail address. It ships a settings form at `/admin/commerce/config/coupon_after_order`
(guarded by the `administer coupon_after_order configuration` permission), two base fields on the
promotion entity, a config object with schema, and two events (`coupon_after_order.coupon_before_create`,
`coupon_after_order.coupon_created`) plus a reusable `coupon_after_order.controller` service so other
modules can alter the coupon or drive the generation/mail logic themselves (for example, to embed the
coupon in the order receipt e-mail instead of a separate message).

---

- Reward customers with a coupon automatically after they place an order.
- Fire coupon generation on the Commerce order `place` transition out of the box.
- Change the trigger to any order-workflow transition (e.g. `fulfill`, `complete`) via config.
- Flag a specific promotion as the coupon source with the "Create coupon after order" checkbox.
- Require a minimum order total before a coupon is issued, per promotion.
- Restrict the reward to matching stores, order types, currency and start/end dates (via the promotion).
- Generate a random 10-character alphanumeric coupon code for the promotion.
- Issue coupons capped at a single use (`usage_limit` = 1).
- Send the coupon to the customer in a separate, tokenized e-mail.
- Customize the e-mail subject and body with `commerce_order`, `commerce_promotion` and
  `commerce_promotion_coupon` tokens.
- Translate the coupon e-mail subject/body and promotion description per language.
- Suppress the e-mail and handle delivery yourself by unchecking "Send e-mail after generating".
- Leave the transition blank to invoke the generation logic entirely from your own code.
- Alter the coupon before it is saved via the `coupon_after_order.coupon_before_create` event.
- React after a coupon is created via the `coupon_after_order.coupon_created` event.
- Call `coupon_after_order.controller` service to generate/send coupons from a custom subscriber.
- Embed the generated coupon inside the order receipt e-mail instead of a standalone message.
- Run coupon delivery after Commerce's order receipt so the invoice arrives first.
- Detect the customer's preferred language for the e-mail, falling back to the site language.
- Reorder promotions by weight so the intended one is picked first for the reward.
- Restrict configuration access to trusted store administrators via the module permission.
- Build a "spend X, get a discount next time" loyalty loop for a Commerce store.
