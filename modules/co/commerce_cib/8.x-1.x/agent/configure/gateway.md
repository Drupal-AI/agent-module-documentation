<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce CIB — configure the gateway

1. Enable `commerce_cib` (requires `commerce_payment`).
2. Add a payment gateway, plugin **CIB** (`cib`). Set:
   - **CIB Shop ID (PID)** — e.g. `ABC0001`,
   - **Currency** — HUF or EUR (disabled/fixed in the form),
   - **Test keyfile path** and **Live keyfile path** — absolute server paths to the DES keyfiles,
   - **Mode** — test/live selects both the keyfile and SAKI endpoint.
3. Place the DES keyfiles at those paths with restrictive permissions.

## Message flow
- `CibForm` builds the request; `commerce_cib.encryption` DES-encrypts using the keyfile.
- Customer is redirected to CIB SAKI (`https://ekit.cib.hu` / `https://eki.cib.hu`).
- `onReturn()` decrypts the return; on MSGT 21 it sends a server-side **MSGT32** close request
  (market channel `http://ekit.cib.hu:8090` / `http://eki.cib.hu:8090`).
- `analyseMsgt32Or33()` loads the local payment by remote id, checks `AMO` equals the stored amount,
  and sets state `completed` (RC 00) or `voided`/`pending` otherwise.

## Refunds
`refundPayment()` (SupportsRefundsInterface) supports HUF only, minimum 100 HUF, driving MSGT70/74/78/80
depending on transaction status (authorized vs captured), setting `refunded`/`partially_refunded`.

## Events
Subscribers under `src/EventSubscriber/` email/notify on failed initialization, failed payment,
timeout, no-communication, and order-paid.
