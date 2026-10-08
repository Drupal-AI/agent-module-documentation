<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce SagePay integration lets a Drupal Commerce store take card payments through the SagePay/Opayo API as an on-site gateway. Card details are collected on the store, a transaction is created via the SagePay REST API, and a 3-D Secure challenge is completed via a dedicated return endpoint before the order is marked paid.

---

Install with Composer (`drupal/commerce_sage`) and enable it (depends on commerce and commerce_payment). Create a 'SagePay (On-site)' payment gateway and enter the vendor name plus live/test integration key and password and transaction/security options. The gateway posts to the SagePay transactions API and returns the buyer through /3dSecureBack/{order} to finish 3-D Secure. Store the integration credentials as secrets.

---

- Accept card payments via SagePay/Opayo.
- Collect card details on-site.
- Create transactions through the SagePay REST API.
- Handle a 3-D Secure challenge/return flow.
- Complete the order after 3DS authentication.
- Create a Commerce payment for the order total.
- Configure vendor name and integration credentials.
- Support live and test integration keys.
- Set an order description sent to SagePay.
- Configure AVS/CV2 security checks.
- Redirect the buyer back into checkout.
- Support the credit-card payment method type.
- Integrate with Commerce order workflow.
- Store integration key/password as secrets.
- Restrict payment-gateway administration to trusted roles.
- Use HTTPS for all SagePay API calls.
