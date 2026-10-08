<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Wallee provides a Wallee payment gateway.

---

Commerce Wallee provides a **Wallee payment gateway for Drupal Commerce** — accepting payments through the
Wallee platform (offsite redirect), with a bundled `wstack` submodule providing the shared SDK/webhook layer. It
depends on Commerce and Commerce Payment.

Use it to accept Wallee payments. It is an e-commerce/payment feature and its webhook handling follows the
**correct authoritative pattern**: the webhook endpoint reads only a remote **entity id + space id** from the
payload, matches the configured gateway by space id, and then **re-fetches the authoritative object from
Wallee's API via the SDK** (`getTokenVersion`/`webhookTransaction`) rather than trusting a status in the
payload — and it only acts on entities that already exist locally. So a forged webhook can at most trigger a
re-sync to the transaction's real state (no payment-status spoofing). Two operational notes: the webhook route
is effectively public (`access content`) and unsigned — safe here because state is re-fetched, but be aware; and
the Transaction branch contains a `sleep(20)`, so treat the endpoint as a place to apply rate-limiting/worker
limits to avoid a public request tying up a worker. Store the Wallee **API credentials** as secrets over HTTPS.
This is a dev release — verify the flow for your version. Configure the Wallee gateway credentials.

---

- Accept Wallee payments.
- Use the offsite-redirect flow.
- Bundle the wstack SDK/webhook layer.
- Depend on Commerce and Commerce Payment.
- Match the gateway by space id.
- RE-FETCH authoritative state via the Wallee SDK.
- Not trust a status in the payload.
- Act only on locally-existing entities.
- Note the webhook is public + unsigned (safe via re-fetch).
- Rate-limit the endpoint (Transaction branch sleeps 20s).
- Store API credentials as secrets over HTTPS.
- Verify the flow for your (dev) version.
- Handle Wallee payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Handle the integration.
- Take payments.
- Secure the credentials.
- Provide Wallee payment.
