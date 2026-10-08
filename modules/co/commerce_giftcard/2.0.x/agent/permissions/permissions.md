<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Gift Card permissions

Defined in `commerce_giftcard.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer commerce_giftcard_type` | manage gift-card **types** (the config bundles); admin_permission of the type entity |
| `administer commerce_giftcard` | full admin over gift cards: the collection, add/edit/delete, the bulk **Generate** form, and the order **refund** form |
| `access giftcard overview` | view the gift-card admin overview/listing |
| `view own giftcards` | view gift cards owned by the current user |
| `create giftcard` | create gift-card entities |
| `create giftcard transaction` | create gift-card transactions (balance changes) |

Notes:

- The **Generate gift cards** form (`/admin/commerce/giftcards/generate`) and the **refund** form
  (`/admin/commerce/orders/{order}/giftcard-refund`) both require `administer commerce_giftcard`
  (refund additionally checks `GiftcardOrderRefundAccess`).
- Access to individual gift-card entities is decided by `GiftcardAccessControlHandler` (e.g. `view`
  combines `access giftcard overview` / `view own giftcards`, create uses `create giftcard`).
- Gift-card **types** use the standard bundle access handler with `administer commerce_giftcard_type`.
