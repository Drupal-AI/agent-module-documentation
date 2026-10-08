<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce OPP provides a Drupal Commerce payment gateway for the Open Payment Platform (OPPWA / ACI PAY.ON) COPYandPAY widget.

---

Commerce OPP integrates the **Open Payment Platform (OPPWA / ACI PAY.ON)** COPYandPAY / PAYFRAME widget into
Drupal Commerce checkout. The same platform is white-labelled by many acquirers (SIBS "SIBS Payments", Hobex,
Viveum "VIVEUM Meteorpay", Peach Payments and others), so one module covers a large set of regional gateways.
It ships six payment gateway plugins — credit cards, generic bank transfer, virtual accounts (incl. PayPal),
and dedicated plugins for **MB WAY**, **SIBS Multibanco** and **SOFORT Überweisung** — plus an optional
`commerce_opp_webhooks` submodule for asynchronous server-to-server payment notifications. It depends on
Commerce **Payment** and is in the Commerce (contrib) package.

Payment confirmation is **server-authoritative** (reviewed): the module never marks a payment paid from a
client-supplied field. `onReturn()` and the MB WAY polling controller re-query OPP's authenticated API
(`GET /v1/checkouts/{id}/payment` and `/v1/query`) and derive the Commerce payment state from that response,
verifying the order matches and binding the paid amount to the order total. The webhook endpoint
(`/opp/webhooks`) uses **AES-256-GCM authenticated decryption** with the configured `encryption_secret`, and a
cron task actively finalizes pending payment intents when webhooks are not used. Store the OPP API credentials
and the webhook encryption secret as protected secrets and serve the site over HTTPS.

---

- Accept credit-card payments in Drupal Commerce via the OPPWA COPYandPAY widget.
- Accept bank-transfer payments through the generic bank-transfer gateway.
- Accept virtual-account payments including PayPal.
- Accept **MB WAY** mobile payments with automatic status polling while the customer pays in their app.
- Accept **SIBS Multibanco** payments and show the customer a payment reference and instructions.
- Accept **SOFORT Überweisung** payments, optionally restricted to specific / billing-address countries.
- Use one gateway configured with multiple card brands (VISA, Mastercard, …).
- Run separate gateway instances per non-card brand for a clean single-widget checkout.
- Authorize-only (preauthorization) or direct-debit (immediate capture) depending on the checkout config and brand.
- Capture, void and refund OPP payments from the Commerce order-management screens.
- Store and reuse tokenized payment methods (saved cards) for returning authenticated customers.
- Apply early-payment discounts by altering the payable amount via the `ALTER_AMOUNT` event.
- Finalize orders reliably even when a customer never returns to the site, using the cron status-polling task.
- Delete abandoned/expired "new" payment intents automatically on cron to avoid stale data.
- Receive asynchronous payment notifications by enabling the `commerce_opp_webhooks` submodule.
- Process webhook notifications asynchronously through Advanced Queue with a configurable delay.
- Point live and test traffic at custom OPP host URLs and switch INTERNAL/EXTERNAL test modes.
- Override credentials in `settings.php` so live secrets never live in the exported configuration.
- Diagnose a payment's remote status from the CLI with `drush commerce_opp:transaction-status` (alias `opp:ts`).
- Support long pre-authorization windows (e.g. SIBS Multibanco spanning several days) via webhooks + cron.
- Map OPP result codes to precise success / pending / rejected / chargeback states for order workflow decisions.
