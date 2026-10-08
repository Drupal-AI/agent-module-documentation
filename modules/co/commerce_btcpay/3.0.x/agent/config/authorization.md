<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & API-key authorization

Source: `BtcPayRedirect::buildConfigurationForm/validateConfigurationForm/submitConfigurationForm`,
`src/Controller/ApiKeyController.php`, `src/Form/ApiKeyConfirmationForm.php`,
`src/ApiKeyManager.php`, `src/ApiKeyVerifier.php`, `src/ApiKeyPermissions.php`,
`src/AuthorizationStateStorage.php`, `src/CredentialStorage.php`, `src/Security/SecretEncryptor.php`,
`src/ServerUrlPolicy.php`, `js/api-key-redirect.js`, `commerce_btcpay.routing.yml`.

## Gateway configuration form

Fields: **BTCPay Server URL** (required, `#type url`), **Store ID**, **New API key**
(`#type password`, never pre-filled), **New webhook secret** (`#type password`, ≥32 chars, auto-generated
if left blank), **Send buyer email** (default off), **Debug mode**. The core **Mode** field is hidden
(gateway is live-only); `collect_billing_information` and `payment_method_types` are forced off/empty.

- **Save-disabled-first workflow.** The "Generate API Key" button is disabled until the gateway has
  been saved (`$can_authorize = id && !isNew`). An **enabled** gateway with no stored key is a
  validation error — you save it disabled, authorize, then explicitly re-enable.
- **Validation** normalizes the URL through `ServerUrlPolicy`, and when a key is present (typed or
  already stored) calls `ApiKeyVerifier::verify()` against BTCPay before saving; a webhook secret
  cannot be saved without an API key.
- **Submit** persists only non-secret config; secrets go to `CredentialStorage`. When a key exists it
  calls `setupWebhook()` (creates/updates a signed BTCPay webhook subscribed to the six invoice
  events, generating a 32-byte hex secret if none is stored, and stores the returned `webhook_id`).

## "Generate API Key" authorization flow

1. **JS** (`js/api-key-redirect.js`): validates the URL client-side (HTTPS unless local HTTP opt-in;
   rejects credentials/query/fragment), then POSTs `{gateway_id, server_url}` to
   `commerce_btcpay.api_key_authorize`.
2. **`ApiKeyController::beginAuthorization`** (route requires CSRF token + `_custom_access`
   `administer commerce_payment_gateway`, and re-checks `$gateway->access('update')`): loads and
   type-checks the gateway, normalizes the URL server-side, creates one-time
   `AuthorizationStateStorage` state bound to the admin's uid + server URL + gateway, and returns the
   BTCPay authorize URL (with `ApiKeyPermissions::REQUIRED` least-privilege scopes and the callback
   URL carrying the `state`).
3. **BTCPay** redirects the browser (public POST) to **`ApiKeyController::apiKeyCallback`**
   (`_access: TRUE`). This endpoint changes **no** gateway state — it only calls
   `attachCandidate($state, apiKey)` to store the key **encrypted** against the existing state, then
   303-redirects to the confirmation form. First callback wins; oversized/invalid keys rejected.
4. **`ApiKeyConfirmationForm`** (route requires `administer commerce_payment_gateway`): `buildForm`
   peeks the state for the **current admin's uid** (403 otherwise); `submitForm`
   `consumeForUser()`-s it (atomic, one-time, lock-guarded, deletes before decrypt) and hands it to
   `ApiKeyManager::complete()`.
5. **`ApiKeyManager::complete`** verifies the key with `ApiKeyVerifier` (permissions + store fetched
   from BTCPay, **never** from callback params), stores the key encrypted, writes `server_url` +
   `store_id` to config, reloads the gateway, and sets up the signed webhook. On any failure nothing
   is enabled.

`ApiKeyVerifier::verify()` calls the Greenfield `ApiKey::getCurrent()` and requires, via
`ApiKeyPermissions`, all four least-privilege scopes (`canviewinvoices`, `cancreateinvoice`,
`canviewstoresettings`, `webhooks.canmodifywebhooks`) scoped to exactly **one** store, then confirms
the store is reachable (`Store::getStore`).

## Secret storage & encryption

- **`CredentialStorage`** keeps only `api_key` and `webhook_secret` (allow-listed), in the
  non-exportable key/value collection `commerce_btcpay.credentials`, keyed by `sha256(gateway_id)`.
  Values are JSON then encrypted; empty values delete the entry. **Secrets are absent from config
  exports** (update hook `8002` migrated any legacy config values out).
- **`SecretEncryptor`** uses **AES-256-GCM** with a random 12-byte IV and 16-byte auth tag, versioned
  payload. The key is derived as `sha256(hash_salt "\0" private_key)` — both site-specific and outside
  exported config, so credentials are not portable between environments (must be re-authorized per
  environment).
- **`AuthorizationStateStorage`** uses the expirable collection
  `commerce_btcpay.authorization_state` (900s TTL), 43-char base64 random state, lock-guarded,
  one-time consume, with the staged API-key candidate stored encrypted.

## HTTPS server-URL policy

`ServerUrlPolicy::normalize()` requires a valid URL with scheme+host, **rejects** embedded
credentials / query / fragment, and forces **HTTPS** — plain HTTP is allowed only when
`$settings['commerce_btcpay_allow_insecure_http'] = TRUE` (intended for local dev only). The
Greenfield clients are constructed with `(server_url, api_key)`; TLS verification is left at the
library default (no verification is disabled).
