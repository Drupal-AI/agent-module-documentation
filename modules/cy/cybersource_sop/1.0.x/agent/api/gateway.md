<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cybersource SOP gateway — agent notes

## Signing (outbound)
`CybersourceSopForm` builds the Secure Acceptance POST: `signed_field_names` = every signed key, `unsigned_field_names` = card fields entered by the customer. `getSigner()->sign($signed, $profile['secret_key'])` = HMAC-SHA256. The amount/currency/reference/URLs are inside the signature, so the browser cannot tamper with them.

## Verifying (inbound)
`CybersourceSop::verifySignature($params)` recomputes the HMAC over the signed fields and compares with `hash_equals` (constant time). `onReturn()` then enforces **signed-field coverage**: `decision, reason_code, req_reference_number, transaction_id, req_amount, req_currency` must all be listed in `signed_field_names`, else the reply is rejected (`ReplyAuthenticationException`). This blocks a party with the secret from signing a harmless field set and appending an unsigned amount/decision.

## Amount integrity
`onReturn()` uses `$order->getTotalPrice()` as the authoritative amount and refuses if the signed `req_amount` differs (`Calculator::compare(...) !== 0`) or currency mismatches — never records an unauthorised amount.

## Credentials
External `.yml` (`cybersource.credentials.example.yml`): one test profile for all currencies, one live profile per currency. Loaded by `CredentialProvider`; `CredentialsCheckSubscriber` warns when missing.
