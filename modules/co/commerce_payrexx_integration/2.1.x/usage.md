<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Payrexx integration provides Commerce integration for the Payrexx payment gateway.

---

Commerce Payrexx integration provides a Drupal Commerce payment gateway for Payrexx — a Swiss payment
service — supporting a redirect checkout (customer pays on Payrexx) and processing payment results via return
and webhook. It depends on Drupal Commerce, in the Commerce (contrib) package.

Use it to accept payments through Payrexx. Its security handling is **correct**: on the webhook, it treats
the posted transaction as **untrusted and re-fetches the transaction from Payrexx's authenticated API**
(using the gateway's instance name + secret) before acting — the controller literally notes *"The transaction
data is untrusted to this point. Reload the transaction data from the remote server to ensure the data can be
trusted."* The browser return/cancel paths take the same authoritative re-fetch route, and the entered API
credentials are verified against Payrexx (via a `SignatureCheck` API call) when the gateway config is saved.
So a forged webhook cannot mark an order paid — the authoritative status comes from Payrexx. When adopting:
store the Payrexx **API secret as a secret** (not in exported config), operate over HTTPS, and confirm the
gateway is in the correct (test vs live) mode. Configure the Payrexx credentials.

---

- Provide a Payrexx payment gateway.
- Support redirect checkout on Payrexx.
- Process return + webhook results.
- Depend on Drupal Commerce.
- Treat webhook transaction data as untrusted.
- RE-FETCH the transaction from Payrexx's API before acting.
- Use Payrexx SignatureCheck.
- Reject forged webhooks (authoritative status from Payrexx).
- Store the Payrexx API secret as a secret.
- Operate over HTTPS.
- Confirm test vs live mode.
- Configure the Payrexx credentials.
- Accept Payrexx payments.
- Handle the payment flow securely.
- Process payments authoritatively.
- Confirm the re-fetch.
- Integrate Payrexx.
- Configure the gateway.
- Handle credentials securely.
- Accept card payments.
