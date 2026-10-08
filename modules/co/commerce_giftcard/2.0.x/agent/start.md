<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Gift Card — agent index

Gift cards for Drupal Commerce: gift-card **types** (config bundle), coded **gift cards** with a
balance, **transactions**, checkout **redemption**, and bulk code generation. Requires
`commerce`, `commerce_price`, `commerce_store`.

- **Gift-card types (config entity), the giftcard/transaction entities & their fields, admin routes** →
  [configure/giftcard-types.md](configure/giftcard-types.md)
- **Redemption flow, order processor/adjustment, code generator, events, services, purchase trait** →
  [api/redemption-and-services.md](api/redemption-and-services.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route: `entity.commerce_giftcard_type.collection` → `/admin/commerce/config/giftcard_types`.
- Config entity `commerce_giftcard_type` (config prefix `commerce_giftcard.giftcard_type.*`); exported
  keys `id`, `label`, `display_label`, `generate` (`generate.length`, default 8).
- Content entities: `commerce_giftcard` (fields `code`, `balance` [commerce_price], `stores`, `status`,
  `uid`, bundle `type`) and `commerce_giftcard_transaction` (`amount`, `giftcard`, `reference_id`,
  `reference_type`, `comment`).
- Redemption: checkout pane `commerce_giftcard_redemption` + inline form; order processor applies a
  `commerce_giftcard` adjustment (priority -1000, applied last).
- Services: `commerce_giftcard.code_generator`, `commerce_giftcard.order_processor`,
  `commerce_giftcard.order_manager`, `commerce_giftcard.order_subscriber`.
