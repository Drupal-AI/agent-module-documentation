<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_cashpresso — gateway configuration

## Add the gateway
`/admin/commerce/config/payment-gateways/add`, plugin **cashpresso**. Config keys:
- `api_key` — cashpresso partner API key.
- `secret` — shared secret used for all verification hashes.
- `order_valid_time` — hours an authorised payment stays valid (default 168).
- `interest_free_days_merchant` — extra interest-free days you grant (validated ≤ partner max via a live `partnerInfo` call).

## Authorisation (`CashpressoGateway::authorizePayment`)
POSTs to `{endpoint}/backend/ecommerce/v2/buy` with `amount` = `$payment->getAmount()->getNumber()`, basket line items, invoice/delivery address, `callbackUrl` = notify URL, and `verificationHash` = `sha512(secret;minorUnits;interestFreeDays;orderId;)`. Endpoint = `rest.cashpresso.com` (live) or `backend.test-cashpresso.com` (test).

## Status callback (`onNotify`)
Reads JSON `{referenceId, status, verificationHash}`, loads the payment by remote id, and requires `verificationHash == sha512(secret;status;remoteId;orderId)`. Mapping: `SUCCESS`→`capture`, `CANCELLED`→`void`, `TIMEOUT`→`expire`; anything else throws `InvalidRequestException`.

## Direct checkout route
`/cashpresso/direct-checkout/{entity_type}/{entity_id}` (no_cache). `DirectCheckoutController::access` requires `access checkout`, a valid purchasable entity, and the entity's own `view` access; the unit price is resolved with the chain price resolver (never from the request).
