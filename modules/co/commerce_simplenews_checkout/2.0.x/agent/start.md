<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Simplenews Checkout (commerce_simplenews_checkout) — agent index

**A Commerce checkout pane that subscribes the buyer's order email to selected Simplenews newsletters during checkout.**

- **Version:** 2.0.x
- **Core:** ^8 || ^10.2 || ^11
- **Dependencies:** `commerce`, `simplenews`
- **Plugin:** `SimplenewsSubscription` (`@CommerceCheckoutPane`, id `simplenews_subscription`, default step `summary`), extends `CheckoutPaneBase`.
- **Config (per checkout flow):** `newsletters`, `label`, `review`, `review_label`.
- **Runtime:** `submitPaneForm()` loads/creates a Simplenews `Subscriber` for `$this->order->getEmail()` and subscribes it to each checked newsletter.
- **Admin:** managed via the Commerce checkout flow form (`administer commerce_checkout flow`).
- **Legacy:** `.module`/`.install` hold non-executing Drupal 7 procedural code; the D10/11 path is the plugin only.

**Security:** no custom routes or permissions; the pane runs inside Commerce checkout and only ever subscribes the buyer's own order email (no arbitrary-email input). Pane configuration is gated by the Commerce checkout-flow admin permission. See [configure/checkout-pane.md](configure/checkout-pane.md).
