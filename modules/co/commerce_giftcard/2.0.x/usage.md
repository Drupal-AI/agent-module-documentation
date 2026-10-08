<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Gift Card adds gift cards to Drupal Commerce: create gift-card types, issue or bulk-generate coded gift cards with a monetary balance, sell them as products, and let customers redeem them at checkout to reduce the order total.

---

The module defines a `commerce_giftcard_type` config entity (bundle) whose main setting is the generated-code `length`, a `commerce_giftcard` content entity (fields: `code`, `balance` as a `commerce_price`, `stores`, `status`, owner `uid`, `type`), and a `commerce_giftcard_transaction` content entity that records each balance change (`amount`, `giftcard`, `reference_id`/`reference_type`, `comment`). Redemption is delivered through a checkout pane (`commerce_giftcard_redemption`) and an inline form that let a customer enter a code; a low-priority order processor (`commerce_giftcard.order_processor`, priority -1000) then applies a `commerce_giftcard` **adjustment** to the order so gift cards are deducted after other adjustments. Codes are produced by the `commerce_giftcard.code_generator` service and a bulk **Generate gift cards** form at `/admin/commerce/giftcards/generate`. Gift cards can be limited to specific stores, sold via the `commerce_giftcard` purchasable-entity trait (buying the product credits a gift card), refunded back to a card from an order, and reacted to through the `GiftcardEvents` amount-calculation event. Admin UIs live under `/admin/commerce/giftcards` (cards, transactions) and `/admin/commerce/config/giftcard_types` (types), gated by a set of gift-card permissions.

---

- Sell prepaid gift cards as products that credit a real gift-card balance on purchase.
- Let customers redeem a gift-card code at checkout to reduce their order total.
- Bulk-generate a batch of unique gift-card codes for a promotion or launch.
- Issue a single gift card with a set balance to a specific customer manually.
- Define multiple gift-card types (e.g. "Holiday", "Store credit") with different code lengths.
- Restrict a gift card so it can only be spent in selected stores of a multi-store site.
- Track every top-up and spend as a gift-card transaction with an audit comment.
- Refund part of an order back onto a gift card from the order's admin page.
- Allow multiple gift cards to be applied to one order (checkout pane "allow multiple").
- Give customer-service staff a "view own gift cards" overview for account holders.
- Apply gift cards last in the pricing pipeline so they discount the fully-adjusted total.
- Generate replacement codes that are guaranteed unique against existing codes.
- Model store credit / loyalty balances as gift cards redeemable at checkout.
- Disable (unpublish) a compromised gift card without deleting its transaction history.
- Set the customer-facing display label per gift-card type independent of its admin label.
- Let a site issue promotional gift cards of a fixed length via the generate form.
- React to gift-card amount calculation with the GiftcardEvents event to customize deductions.
- Provide a redeemable balance that carries across multiple orders until exhausted.
- Expose gift cards and transactions in Views for reporting (views data handlers provided).
- Enforce currency consistency between a gift card and the order it is applied to.
- Grant granular access with permissions for creating cards, creating transactions, and admin.
- Build a corporate gift-card program where finance bulk-issues cards to employees.
- Integrate gift-card purchase with normal Commerce products via the purchasable entity trait.
- Manage all gift cards, types and transactions from dedicated admin listings.
