<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Coinbase (coinbase) — agent index

**Off-site Commerce gateway that creates a Coinbase Commerce charge and redirects.**

- **Version:** 1.0.x (project `coinbase_payment`) · **Core:** ^9.3 || ^10 · **Depends:** commerce, commerce_payment
- **Plugin:** `Plugin/Commerce/PaymentGateway/Coinbase` (id `coinbase_payment`), offsite form `CustomPaymentOffsiteForm`.
- **Config:** `coinbase_api_key` (set on the gateway).

**Security:** no `onReturn()`/`onNotify()` and no notify route — Coinbase callbacks are never verified and no payment is confirmed server-side (`Coinbase.php`, empty routing). Charge JSON built via string concat (`CustomPaymentOffsiteForm.php:48`). TLS at cURL defaults. See [api/gateway.md](api/gateway.md).
