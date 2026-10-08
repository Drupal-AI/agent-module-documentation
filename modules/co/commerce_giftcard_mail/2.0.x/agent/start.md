<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Giftcard Mail (commerce_giftcard_mail) — agent index

**Gift-card activation email**: fires a Commerce Email when a purchased gift card is activated, with buyer-email and amount tokens.

**Version:** 2.0.x (git branch `2.0.x`). Core: `^10 || ^11`. Depends on `commerce_giftcard` and `commerce_email`.

Email event plugin `GiftcardActivated` (`@CommerceEmailEvent` id `giftcard_activated`, event `commerce_giftcard.giftcard_activated`, entity_type `commerce_giftcard`). Token alters add `[commerce_giftcard:email]` (buyer email via the purchase transaction's order-item→order) and `[commerce_giftcard:initial_amount]` (transaction amount). Composer references a patch so activation occurs only when payment is confirmed. No routes, permissions, services or config of its own — the email is authored in Commerce Email.

**Security:** no endpoints; token resolution reads existing order/transaction data only. Mail is sent to the order's own contact email. No security findings.