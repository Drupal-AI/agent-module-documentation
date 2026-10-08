<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Payin-Payout gateway

Add at **Commerce > Configuration > Payment > Payment gateways** → *Payin-Payout* (plugin id `payin_payout`).

Fields (`PayinPayout::buildConfigurationForm`):
- **Mode** — `test` or `live` (selects the hosted endpoint).
- **API token** — Payin-Payout token; used both to sign the outbound redirect and to verify inbound notifications.
- **Agent ID** / **Agent name** — store id and the name shown to the buyer.
- **Order ID prefix** — optional label prefix (e.g. `Order #`).
- **Customer phone field** — a field on the `customer` profile bundle holding the phone number (required; the gateway throws if the selected field is missing on the billing profile at checkout).
- **API logging** — logs request payloads to the `commerce_payin_payout` dblog channel.

Signature model: outbound sign covers `[agent_id, order_id, agent_time, amount, phone]`; the inbound notification sign covers `[agentId, orderId, paymentId, amount, phone, paymentStatus, paymentDate]`, both hashed with the token via `generateSign` and compared with `hash_equals`. Store the token securely; there is no Key entity integration.
