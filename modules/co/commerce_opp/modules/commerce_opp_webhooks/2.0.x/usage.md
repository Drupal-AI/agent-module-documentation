<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce OPP Webhooks receives OPPWA server-to-server payment notifications and finalizes payments asynchronously.

---

`commerce_opp_webhooks` is the optional webhooks submodule of **Commerce Open Payment Platform**. It exposes a
single public endpoint at **`/opp/webhooks`** that OPPWA (ACI PAY.ON) calls with server-to-server **PAYMENT**
notifications. Each notification body is **AES-256-GCM encrypted**; the endpoint requires the
`X-Initialization-Vector` and `X-Authentication-Tag` headers and decrypts the payload with the
`encryption_secret` configured on the parent `commerce_opp.settings` — a forged or tampered body fails the GCM
authentication tag and is rejected. Valid notifications are turned into an **Advanced Queue** job
(`commerce_opp_webhooks` job type / queue) that applies the payment and order state transition, so fulfilment
happens even if the customer never returns to the site. It depends on `commerce_opp` and `advancedqueue`.

Enable this submodule when you can configure webhooks in your OPP provider backend; it is the recommended
alternative to the parent module's cron-based status polling, especially for brands with long pre-authorization
windows (e.g. SIBS Multibanco). Set the same encryption secret on both the OPP side and in Drupal.

---

- Receive OPPWA server-to-server PAYMENT notifications at `/opp/webhooks`.
- Verify and decrypt notification payloads with AES-256-GCM using the configured encryption secret.
- Reject notifications missing the IV / authentication-tag headers.
- Finalize payments without relying on the customer returning to the checkout complete page.
- Process notifications asynchronously through an Advanced Queue queue and job type.
- Apply a configurable processing delay (`queue_delay`) before jobs become available.
- Handle DB (debit), PA (preauthorization), CP (capture) and RC (receipt) payment notification types.
- Answer OPP TEST notifications used to validate the endpoint.
- Skip re-processing of already-completed payments (idempotent handling).
- Place the order automatically once a webhook confirms an authorization.
- Support brands with long pre-authorization windows (e.g. SIBS Multibanco) via async notifications.
- Reduce reliance on cron status polling for high-traffic stores.
- Log webhook processing outcomes to the `commerce_opp_webhooks` logger channel.
- Retry failed queue jobs (max 3 retries, 30-minute delay) via Advanced Queue.
- Reuse the parent module's transaction-status mapping and amount binding for received payloads.
