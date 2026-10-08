<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment gateways, off-site flow & EscrowClient

## Two gateways, one trait
Both gateways are `OffsitePaymentGatewayBase` plugins implementing `EscrowGatewayInterface`
(extends Commerce `SupportsVoidsInterface`) and sharing `EscrowTrait`:

- **`escrow_pay`** (`EscrowPay.php`) — `initiateEscrow()` → `EscrowClient::createEscrowPay($payload)`
  (Escrow **Pay** hosted checkout).
- **`escrow_offer`** (`EscrowOffer.php`) — `initiateEscrow()` wraps payload as
  `['transaction' => $payload]` → `EscrowClient::createEscrowAuction()` (Escrow **Offer** auction).

Both declare `payment_type: "escrow_payment"`, `requires_billing_information: TRUE`, and use
`PaymentOffsiteForm` for the `offsite-payment` form.

### Config form (`EscrowTrait::buildConfigurationForm`)
Fields: **`api_key`** (required), **`email`** (required — Escrow.com login email),
**`logging`** (checkbox). `mode` (test/live) comes from the base off-site gateway. `init()`
constructs `new EscrowClient($api_key, $email, $mode, $logging)`; re-run on `__wakeup()`.
`defaultConfiguration()` seeds empty api_key/email + logging=FALSE.

## Off-site redirect (`PaymentOffsiteForm::buildConfigurationForm`)
1. `initiateEscrow($order)` (wrapped in try/catch → `PaymentGatewayException`).
2. `createPayment($payment, $escrow_response)` — asserts state `new`, sets amount =
   `$order->getTotalPrice()`, remote_state `create`, stores `token`, and sets remote_id to
   `transaction_id` when present (note: the `auction_id` branch also reads
   `$escrow_response['transaction_id']` — likely a bug for offers).
3. `buildRedirectForm(..., $escrow_response['landing_page'] ?? $escrow_response['make_offer_page'], [], 'get')`
   — redirects buyer to Escrow's hosted page.

## Payload building (`EscrowTrait::buildOrderPayload`)
Server-side, from the order:
- `currency` (lowercased), `reference = $order->id()`, `return_url` =
  `commerce_payment.checkout.return`, `redirect_type = manual`. For offers also
  `listing_reference = $order->id()` and buyer customer `buyer_user`.
- Iterates order items whose purchased entity is an `EscrowItemInterface`. Amounts come from
  `$order_item->getTotalPrice()->getNumber()` — **not** from any request input.
- **Brokered** items add `broker_fee` schedule item(s) split by `broker_fee_split`
  (buyer / seller / equal); seller becomes the item owner's email; a `broker` party
  (`ESCROW_OWNER = 'me'`) is added.
- Per item: `escrow_type`, `title`, `sku`, `quantity`, `inspection_period`, schedule
  (payer=buyer, beneficiary=seller), optional `extra_attributes`, escrow `fees` split by
  `escrow_fee`.
- Parties: buyer (from billing profile via `getBuyerParty()` for Pay; fixed `buyer_user` for
  Offer), seller, and broker when brokered.
- Dispatches `EscrowEvents::ESCROW_ORDER_PAYLOAD` (`EscrowOrderPayloadEvent`) so custom code
  can alter the payload; returns `$event->getPayload()`.

`getBuyerParty()` maps the billing address (name, address lines, city/state/postcode/country,
email, optional `field_phone`) into Escrow's party shape.

`voidPayment()` asserts state `authorization` then `EscrowClient::cancelTransaction(remoteId)`
— reached only via Commerce's admin payment operations (`administer commerce_payment`).

## EscrowClient (`EscrowClient.php`)
Guzzle wrapper. `request()` builds URL from `mode` (`ESCROW_SANDBOX_URL
https://api.escrow-sandbox.com/` vs `ESCROW_PRODUCTION_URL https://api.escrow.com/`), auth
header `Basic base64(email:apiKey)`, JSON body; default Guzzle TLS verification (enabled).
On error logs and throws `BadRequestHttpException`. `logging=TRUE` writes request + response
bodies to the `commerce_escrow` logger (contains buyer PII).

Methods (see interface): `createEscrowPay`, `getPendingEscrowPay`, `createCustomer`/`getCustomer`/
`updateCustomer`, `createTransaction`, `getTransaction`, `getTransactionByReference`,
`cancelTransaction`, `confirmTransaction`, `fundTransaction`, `shipTransaction`,
`handleTransactionItems` (receive/accept/reject/return actions — validated against
`ESCROW_TRANSACTION_ITEMS_ACTIONS`), and Offer methods `createEscrowAuction`/`getEscrowAuction`/
`cancelEscrowAuction`/`createEscrowOffer`/`cancelEscrowOfferAsBuyer`/`handleEscrowOfferAsSeller`/
`retrieveAuctionHistory`. Can be instantiated directly in custom code:
`new EscrowClient('api_key', 'account_email', 'test')`.
