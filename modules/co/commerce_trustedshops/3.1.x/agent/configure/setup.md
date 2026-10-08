<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_trustedshops — setup

## Shop entity
`Shop` is a config entity representing a TrustedShops shop (TSID + credentials). Create/manage under `/admin/commerce/config/trustedshops` (permission `administer commerce trustedshops`). A `DefaultShopResolver` (chained via `ChainShopResolver`) picks the shop for a given order/store.

## Settings
`/admin/commerce/config/trustedshops/settings` — `SettingsForm`, permission `administer commerce trustedshops`.

## Trustbadge block
`Plugin/Block/TrustedBadgeBlock` renders `block--commerce-trustedshops-trustedbadge.html.twig` with the resolved TSID. Place it via Block Layout.

## Review collector pane
`Plugin/Commerce/CheckoutPane/ReviewCollector` outputs the review-collector snippet (`commerce-trustedshops-review-collector.html.twig`) on checkout completion. The order language is chosen by `DefaultOrderLanguageResolver` (chained).

## Review invitations
- Service `API\Review` calls the TrustedShops REST API.
- Manual: `/admin/commerce/orders/{commerce_order}/trustedshops/invite_review_confirm` (`InviteReviewForm`), access via `InviteReviewForm::access` which requires `send invite review commerce trustedshops`.
- Product payload can be altered by subscribing to `TrustedShopsEvents` / `AlterProductDataEvent`.

## Views
`views.view.trustedshops` (installed) exposes an order field/link (`OrderLinkInviteReview`) to send invitations from listings.
