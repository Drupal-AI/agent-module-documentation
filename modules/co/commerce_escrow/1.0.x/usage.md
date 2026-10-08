<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Escrow settles Drupal Commerce orders through Escrow.com, holding the buyer's funds at Escrow.com until delivery is confirmed.

---

Commerce Escrow provides Drupal Commerce integration for **Escrow.com**, aimed at high-value or trust-sensitive sales (domains, vehicles, general merchandise, services, brokered deals). It ships two off-site payment gateways — **Escrow Pay** and **Escrow Offer** — that build a transaction (or auction/offer) payload from the order and redirect the buyer to Escrow.com's hosted page. Escrow.com holds the funds; the module never holds a local balance. A webhook at `/payment/webhook/escrow` receives Escrow.com transaction events and drives the matching Drupal **order** and **payment** state-machine transitions, keeping Commerce in sync in real time. An **Escrow Item** trait adds escrow-specific fields (item type, inspection period, brokered flag, broker/escrow fee splits, single-item stock) to product-variation types, and a bundled `EscrowClient` exposes the full Escrow.com REST API for custom code. Two events (`ESCROW_ORDER_PAYLOAD`, `ESCROW_WEBHOOK`) let integrators alter the outbound payload or halt the automatic transitions.

Note (as shipped, 1.0.2): `commerce_escrow.module` references `commerce_product`'s `ProductVariationType` class in `hook_entity_bundle_info_alter` without declaring `commerce_product` as a dependency, so enable **`commerce_product`** alongside it or that hook fatals. Depends on `commerce_payment` and `commerce_order`; requires Commerce Core 3; supports Drupal 10 and 11. Store the Escrow.com API key securely.

---

- Settle high-value Commerce orders through Escrow.com, with funds held by Escrow.com until delivery is confirmed.
- Offer buyers the **Escrow Pay** hosted-checkout gateway (off-site redirect to Escrow.com).
- Offer the **Escrow Offer** gateway for auction/offer (make-an-offer) style negotiated sales.
- Keep Drupal order and payment states in sync with Escrow.com automatically via the webhook.
- Sell domains, domain leases, motor vehicles, general merchandise, or milestone services (per escrow item type).
- Broker a sale between a third-party seller and buyer, charging a configurable broker-fee percentage.
- Split the broker fee and the escrow fee between buyer, seller, or both equally.
- Show buyers an estimated Escrow.com fee line during checkout (optional, per variation type).
- Set a per-item inspection period (1–30 days) for the buyer to accept or reject goods.
- Enforce single-item "sold once" stock semantics (forces qty 1, marks out of stock on order placement).
- Void an Escrow transaction from the Commerce order/payment admin.
- Alter the outbound transaction payload via the `ESCROW_ORDER_PAYLOAD` event.
- Halt or replace the automatic order/payment transitions via the `ESCROW_WEBHOOK` event's `setStopWebhook()`.
- Call the Escrow.com REST API directly from custom code with the bundled `EscrowClient` (transactions, customers, auctions/offers, ship/receive/accept item actions).
- Toggle test (sandbox) vs live mode and optional API request/response logging per gateway.
- Enable `commerce_product` alongside the module to avoid the shipped 1.0.2 bundle-info fatal.
