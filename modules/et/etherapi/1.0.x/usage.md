<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EtherAPI accepts Ethereum/crypto payments through the etherapi.net service for the Basket commerce suite, confirming orders via a signed server-to-server status callback.
---
The module stores payment records in its own `payments_etherapi` table and integrates with the (separate) `basket` store module as a Basket payment plugin (`BasketEtherAPI`). A shopper is sent to `/etherapi/pay?pay_id=<id>` which renders `PaymentForm` for a payment whose status is `new`; the form shows the crypto amount/address to send. When etherapi.net observes the transaction it POSTs to `/etherapi/status`, and the controller verifies the notification before marking the payment paid: it optionally checks the source IP against an allow-list (`config.REMOTE_ADDR`, one per line), requires an `etherapi.net` POST marker, loads the payment by the POSTed `tag`, and recomputes a `sha1(type:date:from:to[:token]:amount:txid:confirmations:tag:apiKey)` signature that must equal the POSTed `sign`. On a match it appends the payment to the record, sets status `pay`, calls Basket's `paymentFinish($nid)` to complete the order, and fires the `hook_etherapi_api_alter` hook.

Setup: install and enable, then visit **Configuration → Development → EtherAPI settings** (`/admin/config/development/etherapi`, permission *Access EtherAPI settings*, which is `restrict access: true`) to enter the per-currency API key(s), receiving address, default currency (default `ETH`) and the callback IP allow-list. Operator notes: the status callback is signature-verified with the per-currency **API key as the shared secret**, so that key must be configured for every currency; also fill the `REMOTE_ADDR` allow-list. All DB access uses the parameterized Drupal query builder (no raw SQL). The public payment route uses `access content` because customers (including anonymous checkout) must reach it; the sensitive settings route is properly permission-restricted.
---
- Enable the module and its Basket dependency, then configure at `/admin/config/development/etherapi`.
- Enter the etherapi.net API key per accepted currency (used as the callback signing secret).
- Set the receiving wallet address and default currency (default `ETH`).
- Fill the callback IP allow-list (`REMOTE_ADDR`, one IP per line) to restrict who may POST status updates.
- Offer EtherAPI as a payment method in a Basket checkout (`BasketEtherAPI` plugin).
- Send a shopper to `/etherapi/pay?pay_id=<id>` to display the pay form for a `new` payment.
- Receive asynchronous confirmation at `/etherapi/status` (server-to-server POST from etherapi.net).
- Let the signed callback auto-complete the Basket order via `paymentFinish($nid)`.
- Alter outgoing payment params with `hook_etherapi_payment_params_alter(&$params,$payment,&$config)`.
- React to a confirmed payment with `hook_etherapi_api_alter($payment,$fields)`.
- Track payments in the `payments_etherapi` table (id, nid, sid, uid, amount, currency, status, data).
- Support multiple crypto currencies/tokens via the per-currency `keys` config.
- Restrict callback origin by IP for defence in depth.
- Localise strings via the module's translation server pattern.
- Audit payment status transitions (`new` → `pay`) with the stored `paytime`.
