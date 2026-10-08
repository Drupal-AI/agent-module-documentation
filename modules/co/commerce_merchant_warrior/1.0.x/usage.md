<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Merchant Warrior provides Merchant Warrior integration for Drupal Commerce.

---

Commerce Merchant Warrior **provides the Merchant Warrior payment gateway** for Drupal Commerce — processing
card payments via Merchant Warrior's Payframe (tokenized card capture) and Direct API. It depends on Commerce,
Commerce Payment and core REST.

Use it to accept Merchant Warrior card payments. It is a **payment gateway** with a server-to-server (Direct API)
design, and its verification is sound: outbound API requests are **signed per Merchant Warrior's protocol using
the API passphrase** — an md5 transaction hash over the passphrase, merchant UUID, amount and currency for
transaction operations, plus an **HMAC-SHA256 message hash** (`hash_hmac('sha256', $query_string,
$api_passphrase)`) for card verification — and payment methods/cards are **verified server-side via the Direct
API `verifyCard` call** rather than trusting client-supplied status — so payment outcomes come from
authenticated API responses, not a forgeable browser callback. Security essentials:
store the Merchant Warrior **merchant UUID / API key / passphrase as secrets** (env/Key), serve over HTTPS, and
(with Payframe) card data is tokenized so raw PAN doesn't hit your server. It has no access-control role.
Configure the Merchant Warrior credentials.

---

- Provide a Merchant Warrior gateway.
- Process card payments (Payframe + Direct API).
- Tokenize card capture via Payframe.
- Depend on Commerce, Commerce Payment, REST.
- Sign API requests with the API passphrase (md5 transaction hash; HMAC-SHA256 message hash for card verification).
- Verify cards server-side via the Direct API verifyCard call.
- Derive outcomes from authenticated API responses (not a browser callback).
- Store the merchant UUID/API key/passphrase as secrets (env/Key).
- Serve over HTTPS.
- Keep raw PAN off your server (Payframe tokenization).
- Have no access-control role.
- Configure the Merchant Warrior credentials.
- Handle Merchant Warrior payments.
- Accept payments.
- Configure the gateway.
- Verify cards.
- Sign requests.
- Capture payments.
- Secure the credentials.
- Provide a Merchant Warrior gateway.
