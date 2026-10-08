<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce CIB is an off-site payment gateway for Hungary's CIB bank that exchanges DES-encrypted SAKI messages, confirming payment via a server-to-server query rather than trusting the browser return.
---
The gateway plugin (`src/Plugin/Commerce/PaymentGateway/Cib.php`, id `cib`) extends `OffsitePaymentGatewayBase` and implements `SupportsRefundsInterface`. Requests are built by `CibForm`, DES-encrypted via the `commerce_cib.encryption` service using an on-disk keyfile (separate test/live paths configured on the gateway) and sent to CIB's SAKI endpoints. On return, `onReturn()` decrypts the `DATA`/`PID` query, and only if the message type is 21 does it issue a **server-side** MSGT32 "close transaction" request (`sendRequest()` over Guzzle) and inspect the authoritative response; `analyseMsgt32Or33()` loads the local payment by remote id and **verifies the returned amount matches the stored payment amount** before setting the state to `completed`, otherwise voiding/pending and dispatching failure events. Refunds (`refundPayment()`) drive the full MSGT70/74/78/80 status-and-refund protocol with HUF-only, 100-HUF-minimum sanity checks.

The module ships event subscribers (failed init/payment, timeout, no-communication, order-paid) that email/notify on outcomes. Setup: create a "CIB" gateway, enter the CIB Shop ID (PID), currency (HUF/EUR) and the absolute test/live DES keyfile paths, and place those keyfiles securely on the server. The return route `commerce_cib.checkout.return` uses Commerce's checkout `_custom_access` check.

Operational/security notes (observations only): the SAKI "market" server-to-server channel is contacted over cleartext `http://eki.cib.hu:8090` / `http://ekit.cib.hu:8090` (`Cib.php` `createUrl()`), i.e. no TLS at the transport layer — the payloads are DES-encrypted at the application layer per CIB's protocol, and the customer-facing channel uses `https://`. Payment state is confirmed and amount-verified server-side, and amounts derive from the order, so there is no client-set-amount or unverified-callback exposure in the confirmation path.
---
- Accept CIB bank card payments in Drupal Commerce.
- Redirect shoppers to CIB's hosted SAKI payment page.
- Confirm payment via a server-side MSGT32 query.
- Verify the returned amount against the stored payment.
- Void or mark pending on failed/timed-out payments.
- Issue full or partial refunds through MSGT70/78/80.
- Enforce HUF-only, 100-HUF-minimum refund rules.
- Configure the CIB Shop ID (PID) per gateway.
- Point to test and live DES keyfiles on disk.
- Switch between test and live SAKI endpoints.
- Email notifications on failed payments/timeouts.
- Notify on order paid via event subscriber.
- Use DES application-layer encryption for messages.
- Handle no-communication scenarios gracefully.
- Log CIB requests/responses to a channel.
- Integrate CIB into the Commerce checkout flow.
- Support EUR/HUF currency configuration.
- Retry close via MSGT33 on MSGT32 failure.
- Dispatch CIB events for custom reactions.
- Deploy for Hungarian CIB merchant accounts.
