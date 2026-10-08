<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment Log — agent index

Logs **payment-gateway requests and responses** (customer **email**, order ID, gateway name, request time,
`additional_data` **JSON** of the request/response) into its own table; viewed via Views, gated by `view
payment logs`. Used by Commerce gateways (e.g. Banca Intesa). Version **1.0.20**. Core `^9||^10||^11`.

E-commerce/logging — **security-sensitive by content**: holds **PII (email)** + full gateway request/response
JSON. Gate `view payment logs` to trusted staff; keep raw card data (PAN/CVV) OUT of `additional_data` (PCI);
prune per retention. No access role beyond permission.
