<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Buckaroo for Drupal (`buckaroo`) — agent index
**Buckaroo payment gateway integration (buckaroo/sdk); Webform payment handler submodule.**

- **Version:** 8.x-1.x  | **Core:** ^9.5 || ^10  | **PHP:** >=7.4 | Composer: `buckaroo/sdk`
- **Configure:** `/admin/config/services/buckaroo` (`buckaroo.configuration`, perm `administer buckaroo integration`, restricted)
- **Overview:** `/admin/buckaroo/payments` (perm `buckaroo integration payments overview`, restricted)
- **Entity:** `buckaroo_payment`. **Submodule:** `buckaroo_webforms` (Webform handler `buckaroo_payment_handler`).
- **Status update:** `buckaroo_cron()` POLLS the Buckaroo API per pending transaction via the authenticated SDK; there is **no inbound push/notify callback route**.

**Security review:** the classic payment-callback-fraud pattern does NOT apply — there is no unauthenticated push/return route that fulfills orders; status comes from server-side authenticated SDK polling on cron, so an attacker cannot forge a callback. Admin routes are gate-kept by restricted permissions. SQL uses the query builder / parameterized queries. **No verified finding.** (Design note: the amount is taken from a webform element on the trusting server side, which is normal.)
