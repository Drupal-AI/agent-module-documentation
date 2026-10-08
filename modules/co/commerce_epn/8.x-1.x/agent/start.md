<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce eProcessingNetwork (commerce_epn) — agent index

**On-site credit-card gateway for Drupal Commerce that posts transactions directly to eProcessingNetwork over HTTPS.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Requires:** commerce_payment (OnsitePaymentGatewayBase)
- **Gateway plugin:** `epn_payment_gateway` → `EpnPaymentGateway` (Sale/AuthOnly, capture, void, refund, store card)
- **Endpoint:** POST `https://www.eprocessingnetwork.com/cgi-bin/tdbe/transact.pl` (Guzzle, form_params), auth via `ePNAccount` + `RestrictKey`
- **Config:** username, restrict_key, testmode. **Routes/permissions:** none (on-site, no callback).

**Security:** No inbound webhook/return route to forge; charged amount always from `$payment->getAmount()` (server-side, not request); outbound is HTTPS with TLS verification left ON. Note: default config ships EPN's PUBLIC sandbox creds (`080880` / `yFqqXJh9Pqnugfr`) — replace before production. On-site card handling ⇒ PCI scope. See [configure/gateway.md](configure/gateway.md).
