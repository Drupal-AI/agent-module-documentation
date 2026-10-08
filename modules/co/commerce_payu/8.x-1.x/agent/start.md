<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce PayU (commerce_payu) — agent index

**Off-site redirect Drupal Commerce payment gateway for PayU, built on the OpenPayU SDK.**

- **Version:** 8.x-1.x (8.x-1.0-alpha1)
- **Core:** ^10 || ^11
- **Requires:** commerce (commerce_payment)
- **Gateway plugin:** `payu_redirect_checkout` — `Drupal\commerce_payu\Plugin\Commerce\PaymentGateway\CommercePayu`
- **Off-site form:** `Drupal\commerce_payu\PluginForm\PayuPaymentForm` (POST redirect to PayU)
- **Service:** `commerce_payu.notification_helper` — signature verification + workflow transitions
- **Config:** POS ID, signature key, OAuth client id/secret, sandbox/live mode (on the gateway entity)

**Security posture:** The `onNotify()` IPN callback is anonymous by design (Commerce payment notify route) but **verifies the `Openpayu-Signature` HMAC against the configured signature key before recording any payment**, and the stored payment amount comes from the local order total (not the callback), so the callback is authenticated and price-manipulation is mitigated. See [api/notifications.md](api/notifications.md). Minor findings (see final report): a leftover `syslog(LOG_ERR, "RETURN URL: ...")` debug line leaks the Commerce return URL to the system log, and PayU credentials are stored plaintext in gateway config (no Key entity).
