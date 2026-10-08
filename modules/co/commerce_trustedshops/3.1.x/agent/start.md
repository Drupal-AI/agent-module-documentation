<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce TrustedShops (commerce_trustedshops) — agent index
**Adds TrustedShops trust badges and post-order review invitations to Drupal Commerce.**

- **version:** 3.1.x
- **core:** ^10 || ^11
- **depends on:** drupal:commerce, drupal:commerce_store
- **entity:** `Shop` config entity (TrustedShops shop, keyed by TSID).
- **plugins:** `TrustedBadgeBlock` (block), `ReviewCollector` (checkout pane); `API\Review` service for invitations.
- **routes:** `/admin/commerce/config/trustedshops[/settings]` (`administer commerce trustedshops`); `/admin/commerce/orders/{commerce_order}/trustedshops/invite_review_confirm` (`InviteReviewForm::access` → `send invite review commerce trustedshops`).
- **permissions:** `administer commerce trustedshops`, `send invite review commerce trustedshops`.
- **Security:** all admin/order routes permission-gated (`_custom_access` on the invite form checks the invite permission + order). No anonymous or mutating public endpoints.

See [configure/setup.md](configure/setup.md)
