<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce TrustedShops connects a Drupal Commerce store to TrustedShops, showing the Trustbadge and collecting customer reviews.

---

The module introduces a `Shop` config entity (a TrustedShops shop, keyed by TSID) resolved per order/store through chained Shop and order-language resolvers. A `TrustedBadgeBlock` renders the Trustbadge widget, and a `ReviewCollector` checkout pane emits the review-collector snippet on order completion so TrustedShops can gather ratings. The `API\Review` service talks to the TrustedShops REST API to send review invitations; site users with the right permission can also trigger an invitation manually from an order.

Two admin surfaces exist: a settings form and a Shop admin at `/admin/commerce/config/trustedshops` (both gated by `administer commerce trustedshops`), plus a per-order "Send invitation to write a review" form at `/admin/commerce/orders/{commerce_order}/trustedshops/invite_review_confirm` guarded by `InviteReviewForm::access` (which checks the `send invite review commerce trustedshops` permission). Setup: create a Shop entity with your TSID/API credentials, place the Trustbadge block, enable the review-collector pane, and configure automatic or manual review invitations.

---

- Create a TrustedShops Shop config entity with your TSID.
- Store per-shop TrustedShops API credentials.
- Resolve which shop applies to an order via the chain shop resolver.
- Resolve the correct review language via the order-language resolver.
- Place the Trustbadge block in a region/theme.
- Enable the review-collector checkout pane to gather reviews after purchase.
- Configure module behaviour at `/admin/commerce/config/trustedshops/settings`.
- Manage shops under `/admin/commerce/config/trustedshops`.
- Send a review invitation manually from a specific order.
- Automate review invitations for completed orders.
- Grant `administer commerce trustedshops` to store admins.
- Grant `send invite review commerce trustedshops` to reviewers/agents.
- Alter product data sent to TrustedShops via the `AlterProductDataEvent`.
- Provide a multilingual review-invitation flow.
- Show verified-buyer trust signals on the storefront.
- Track which orders have had review invitations sent (bundled view).
- Integrate ratings with a specific commerce store.
- Customise the review-collector template.
- Customise the Trustbadge block template.
- Use resolver services to support multi-store setups.
