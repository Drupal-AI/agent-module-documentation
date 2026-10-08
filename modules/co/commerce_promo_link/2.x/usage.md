<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Promo Link turns a Drupal Commerce promotion coupon code into a shareable URL (`/commerce/promotion/{code}`) that automatically applies the coupon to the visitor's cart.

---

Commerce Promo Link is a small Drupal Commerce add-on (depends on `commerce_promotion`) that lets marketing share a single link instead of asking customers to type a coupon code at checkout. Visiting `/commerce/promotion/{code}` validates the coupon (it must exist, be enabled, be inside its usage limits and its start/end date window) and stores the code in the visitor's private tempstore, showing a confirmation message and redirecting to the front page — or to a `?destination` the request supplies. An order event subscriber then writes that one coupon onto the draft cart order the next time the visitor triggers an add-to-cart, cart, node or product page presave, so the discount appears without any manual entry. Only a single coupon is supported per link and it replaces any other coupon on the order. A bundled `promo_link_only` Commerce condition lets a store restrict a promotion so it can be redeemed only when it arrived through one of these links. There is no admin settings form, no new permission and no config to export.

---

- Share a one-click discount link in an email campaign so recipients get the coupon applied automatically.
- Post a promo link on social media that pre-loads a coupon into the cart.
- Add a `?destination=/node/2` to a promo link so the visitor lands on a specific landing page after the coupon is stored.
- Print a QR code that resolves to `/commerce/promotion/SUMMER10` for an in-store or event promotion.
- Give affiliates or influencers a unique coupon link to distribute.
- Drive traffic to a campaign page while silently queuing the discount for checkout.
- Reduce checkout friction by removing the "enter coupon code" step for linked customers.
- Attach the link to a newsletter "claim your discount" button.
- Use the `promo_link_only` condition to make a promotion redeemable ONLY via the shared link (not by typing the code on the coupon form).
- Run a link-gated flash sale where the discount only reaches people who received the URL.
- Combine with Commerce promotion usage limits so a link-delivered coupon still respects per-code and per-promotion caps.
- Keep coupon start/end dates authoritative — the link refuses codes outside their active window.
- Let a returning customer re-open a saved promo link to re-queue the coupon.
- Localize campaigns by pointing each region's link at a different coupon code.
- Layer with Commerce's normal coupon/condition rules, which still evaluate when the discount is applied to the order.
- Show a friendly "coupon will be applied during checkout" message when the link is used.
- Warn the visitor at order presave if the queued coupon later expired before it could be applied.
- Test a promotion by hitting its `/commerce/promotion/{code}` URL directly during QA.
- Support both anonymous and authenticated shoppers (the coupon is carried through login when applied after items are in the cart).
- Replace bespoke "coupon in the URL" glue code with a maintained contrib module.
