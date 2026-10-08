<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cybersource REST gateway — agent notes

## Credentials
`CredentialProvider` loads an external private YAML (see `cybersource_rest.credentials.example.yml`) — never site config/DB. Two profiles: `test` and `live`, each with `merchant_id`, `key_id`, `shared_secret`. `CredentialsStatus` / `CredentialsCheckSubscriber` warn in admin when missing.

## API client
`CybersourceApiClient` builds a `CyberSource\ApiClient` with `MerchantConfiguration` using `HTTP_SIGNATURE` auth against fixed hosts (`self::HOSTS['test'|'live']`). Wraps SDK APIs: Microform key generation, Payments (authorize/sale), Capture, Refund, Void, PayerAuthentication (setup/enroll/validate).

## Payment flow
1. Microform iframe (Cybersource-hosted) captures PAN/CVV → transient token to the browser.
2. Optional 3-D Secure: POST `payer-auth/setup` (device data), `payer-auth/enroll` (challenge), ACS posts back to `payer-auth/return` (side-effect-free window signal).
3. Server authorizes/captures via REST; **amount/currency come from `$order->getTotalPrice()` / `$payment->getAmount()`** (CybersourceRest.php ~302, ~599, ~752), not the request.

## Access
`PayerAuthController::access`: gateway enabled + `CybersourceRestInterface` + `isPayerAuthEnabled()`, order state `draft`, caller owns order (cart session or customer id). Routes also require `_csrf_request_header_token`.
