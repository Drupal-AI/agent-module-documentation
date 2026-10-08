<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: commerce_balance

**What:** Computed order/user balance fields + a manual "Balance (Pay later)" gateway.

**Key files:**
- `commerce_balance.module` — `hook_entity_base_field_info` adds computed `balance` (order) and `commerce_balance` (user) fields.
- `src/OrderBalanceFieldItemList.php`, `src/UserOrdersBalanceFieldItemList.php` — computed lists.
- `src/Plugin/Commerce/PaymentGateway/Balance.php` — manual gateway (all ops no-op).

**Deps:** `commerce_order`, `commerce_payment`.

**Security (reviewed, SOUND):** balance is COMPUTED from totals (no writable field → no manipulation/negative-amount vector); gateway is admin-configured manual. No routes/permissions.
