<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: commerce_cart_skip

**What:** Config-entity rules that bypass the cart and auto-create an order (express/buy-now).

**Key files:**
- `src/Entity/CommerceCartSkipRule.php` — config entity.
- `src/Controller/CommerceCartSkipPurchasedController.php` — `purchased()` confirmation page.
- `src/Form/*`, `src/Controller/CommerceCartSkipRuleListBuilder.php`.

**Routes:** rule CRUD gated by `administer commerce cart skip rules`; purchased page gated by `_entity_access: commerce_order.view` (`commerce_order` constrained `\d+`).

**Deps:** `commerce_cart`. **Security:** admin-only rule management; buyer confirmation requires order view access.
