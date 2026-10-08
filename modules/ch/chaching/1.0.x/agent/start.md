<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cha-ching (chaching) — agent index
**Donation register: records verified PayPal IPNs and serves JSON/RSS/graph donation feeds.**

- **Version:** 1.0.x  •  **Core:** ^10.2 || ^11
- **Config:** `chaching.admin` `/admin/config/services/chaching` (`administer site configuration`) — sets `receiver_email` allow-list
- **IPN routes (POST, `_access: TRUE`):** `/paypal/ipn`, `/lm_paypal/ipn` → `ChachingController::ipn`
- **Read routes (`access chaching metadata`):** `/v1/donations/{type}/{period}/{format}/{filter}`, `/graph/{period}`, `/docs`
- **Storage:** table `chaching_paypal_ipns`
- **Security (SOUND):** the public IPN callback is POST-only and, before any DB write, re-posts to PayPal (`_notify-validate`, HTTPS/default TLS verify) and requires `VERIFIED` + a configured `receiver_email` match; only schema fields are stored. Read feeds are permission-gated and expose no PII; JSONP callback is `\W`-sanitised.

See [configure/paypal-ipn.md](configure/paypal-ipn.md).