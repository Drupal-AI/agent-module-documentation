<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an on-site Commerce payment gateway that charges credit cards through the eProcessingNetwork (EPN) transaction API.

---

`EpnPaymentGateway` extends `OnsitePaymentGatewayBase`: card details are collected on the store's own checkout form and the server posts transactions directly to EPN's transaction endpoint (`https://www.eprocessingnetwork.com/cgi-bin/tdbe/transact.pl`) over HTTPS using Guzzle. It implements the full on-site lifecycle — `createPaymentMethod` (Store/tokenize a card, keeping only the last 4 locally), `createPayment` (Sale or AuthOnly), `capturePayment` (Auth2Sale), `voidPayment` and `refundPayment` (Return). Each request is authenticated with the configured EPN account (`ePNAccount`) and `RestrictKey`, and the CSV response is parsed for a Y/N/U approval status.

Security-relevant: this is a server-to-server on-site gateway with no inbound webhook/return route, so there is no unauthenticated callback to forge; the charged amount always comes from `$payment->getAmount()` (the order/payment amount), never from a client request. The outbound endpoint is HTTPS with no TLS verification disabled. Note the default configuration ships EPN's public sandbox credentials (username `080880`, restrict_key `yFqqXJh9Pqnugfr`) purely as test defaults — replace them with your own account before taking real payments. Because card numbers pass through the site, standard PCI/on-site handling considerations apply.

---
- Charge credit cards on-site via eProcessingNetwork
- Tokenize/store a card with EPN (TranType Store)
- Authorize-only then capture later (AuthOnly → Auth2Sale)
- Capture a previously authorized EPN payment
- Void an authorization before capture
- Refund a completed EPN payment (partial or full)
- Configure EPN account username and Restrict Key
- Toggle EPN test mode on a production account
- Collect card details on the store's own checkout form
- Send billing address/AVS data with the transaction
- Include tax and invoice/customer code (PC Level 2 fields)
- Store only the last 4 digits of the card locally
- Map EPN Y/N/U responses to Commerce payment states
- Add EPN as an on-site credit-card payment method
- Support Visa/MC/Amex/Discover/Diners card types
- Reconcile EPN transaction ids with Commerce payments
- Replace shipped sandbox credentials with a live account
- Localize the payment label shown at checkout
