<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare SDK Key (cloudflare_sdk_key) — agent index

Optional submodule of **Cloudflare SDK**. It lets a `cloudflare_credentials` set resolve its
Cloudflare API **token** from a Drupal **Key** entity instead of `settings.php`, while keeping the
token out of exported configuration. Package `Cloudflare`. Core `^10.5 || ^11 || ^12`. Part of the
`cloudflare_sdk` project (installed 1.0.0-alpha7; version dir `1.0.x`).

## Dependencies

- **`cloudflare_sdk`** (the base module) and **`key`** (Drupal Key module) — both required
  (`.info.yml`). The base module never depends on Key; enabling this submodule is what turns the
  integration on.

## How it works (from source)

- **`KeyCredentialResolver`** (`cloudflare_sdk_key.services.yml`) **decorates**
  `Drupal\cloudflare_sdk\Credential\SettingsCredentialResolver` (`decorates:` + `$inner: '@.inner'`,
  `$keyRepository: '@key.repository'`). `resolve()`:
  - Reads the credential set's third-party setting `cloudflare_sdk_key.key_id`. If empty →
    delegate straight to the inner (settings.php) resolver, so existing sets are unaffected.
  - Otherwise loads the token via `KeyRepositoryInterface::getKey($keyId)->getKeyValue()` and the
    account ID from third-party setting `cloudflare_sdk_key.account_id`. Throws
    `MissingCredentialException` (from the base module) when the key holds no value or the account
    ID is empty. Returns a `CloudflareCredentials(accountId, token)`.
- **Credentials-form additions** (`Hook/CloudflareSdkKeyHooks::formCloudflareCredentialsFormAlter`,
  `form_cloudflare_credentials_form_alter`): a **API token key** select (`#type: key_select`,
  filtered to the `authentication` type group, empty option "- Use settings.php -") and an
  **Account ID** textfield (shown only when a key is chosen; the account ID is not a secret).
- **Server-side validation + persistence** (`.module`): `_cloudflare_sdk_key_account_id_validate`
  enforces that an account ID is entered whenever a key is selected (the `#states` rule only governs
  client-side visibility); the entity builder `_cloudflare_sdk_key_credentials_builder` stores or
  clears `key_id` + `account_id` as third-party settings.
- **Config schema** `cloudflare_sdk_key.schema.yml`:
  `cloudflare_sdk.credentials.*.third_party.cloudflare_sdk_key` with `key_id` + `account_id`. The
  **token itself is never stored** on the entity — only the key id reference and the account id.

No permissions, routes, services beyond the decorator + hook object, or plugin types of its own; it
reuses the base module's `administer cloudflare`-gated credentials form.

## Setup

1. `drush en cloudflare_sdk_key`.
2. Create a Key (type *Authentication*) holding the Cloudflare API token.
3. Edit a credential set (Configuration → Web services → Cloudflare credentials), select that Key,
   and enter the account ID.

See [usage.md](../usage.md) and the parent module docs at
[../../../../agent/start.md](../../../../agent/start.md).
