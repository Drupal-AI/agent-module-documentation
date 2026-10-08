<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Buckaroo for Drupal integrates the Buckaroo payment service using the official `buckaroo/sdk`. It defines a `buckaroo_payment` entity to record transactions, an admin payments overview, a credentials configuration form, and a payment-method abstraction (an iDEAL method ships in core). A submodule, `buckaroo_webforms`, adds a Webform handler so a webform submission can trigger a Buckaroo payment.

Use it when you need Buckaroo (a Netherlands/EU payment provider) to collect payments, particularly tied to Webform submissions.
---
Install with Composer (`composer require drupal/buckaroo`) to pull `buckaroo/sdk`, then `drush en buckaroo`. Enter your website key, secret key, and mode (test/live) at `/admin/config/services/buckaroo` (route `buckaroo.configuration`, permission `administer buckaroo integration`, restricted). View recorded payments at `/admin/buckaroo/payments` (permission `buckaroo integration payments overview`, restricted).

To take payments from a form, enable `buckaroo_webforms` (requires the Webform module) and add the "Buckaroo payment" handler to a webform, choosing a payment method, currency, and the form element that holds the amount. Payment status is NOT updated by an inbound gateway callback: `buckaroo_cron()` polls the Buckaroo API for each pending transaction's status via the authenticated SDK client and updates the local `buckaroo_payment` rows. Credentials are validated with `confirmCredential()` before use.
---
- Collect iDEAL payments through Buckaroo.
- Trigger a payment from a Webform submission.
- Record every transaction as a `buckaroo_payment` entity.
- Review payments in an admin overview list.
- Configure test vs live mode with provider credentials.
- Poll transaction status on cron rather than via webhook.
- Bind a payment amount to a chosen webform element.
- Support multiple currencies (EUR/USD) per handler.
- Redirect the customer to Buckaroo's hosted payment page.
- Issue refunds through the SDK's refund method.
- Restrict payment configuration to trusted admins.
- Validate API credentials before attempting a charge.
- Extend with additional Buckaroo payment methods.
- Store an invoice id (uniqid) per transaction.
- Reconcile pending payments automatically on cron.
- Integrate EU payments without building an SDK wrapper.
- Keep payment records queryable for reporting.