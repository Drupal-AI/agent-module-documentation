<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce CIB (commerce_cib) — agent index
**Off-site Commerce gateway for CIB bank (Hungary) using DES-encrypted SAKI messaging, with server-side payment confirmation and refunds.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10
- **Depends on:** `commerce:commerce_payment`
- **Gateway:** `@CommercePaymentGateway(id="cib")` (`OffsitePaymentGatewayBase`, `SupportsRefundsInterface`); offsite form `CibForm`; DES `commerce_cib.encryption` (keyfile-based); custom payment type `payment_cib`.
- **Route:** `commerce_cib.checkout.return` → standard checkout return (`_custom_access` = checkout access).
- **Confirmation:** `onReturn()` decrypts return, then does a **server-to-server** MSGT32/33 query; `analyseMsgt32Or33()` verifies `AMO` == stored payment amount before completing.
- **Security (observations, reviewed):** payment state and amount are confirmed server-side (no trust of browser return; no client-set amount). Note: the SAKI "market" channel is contacted over cleartext `http://eki.cib.hu:8090` in `Cib.php::createUrl()` — payloads are DES-encrypted at the app layer (protocol design), customer channel is `https`. No disabled-TLS flag, no unverified fulfilment.

See [configure/gateway.md](configure/gateway.md)
