<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Boncard (commerce_boncard) — agent index

**Boncard gift-card gateway for Commerce (balance/auth/capture/refund/cancel).**

- **Version:** 1.1.x · **Core:** ^9 || ^10 · **Depends:** commerce_checkout
- **Config:** `commerce_boncard.settings` → `/admin/commerce/config/boncard` (`administer commerce_boncard configuration`).
- **Client:** `Client/BoncardClient` (HMAC-SHA256 signed calls to `/api/v1/{balance,payment,submission,credit,reversal}`).
- **Op route:** `/admin/commerce/orders/{order}/giftcards/{boncard}/operation/{operation}` via `BoncardOperationAccessCheck` (delegates to entity `access()`).

**Security:** admin/entity-access gated; outbound-only (no forgeable inbound webhook); requests HMAC-signed with the configured password; default TLS. Card number/CVC stored on the transaction entity. See [api/client.md](api/client.md).
