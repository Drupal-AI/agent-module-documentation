<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `dropbox_sign` service (`Drupal\dropbox_sign\DropboxSign`)

Defined in `dropbox_sign.services.yml`; class `src/DropboxSign.php`. This is the module's whole
public API surface for creating signatures. Fetch it with `\Drupal::service('dropbox_sign')` (or
inject the `dropbox_sign` service).

## Construction / auth

Constructor args: `@config.factory`, `@encryption`, `@file_system`, `@logger.channel.dropbox_sign`,
`@string_translation`.

On construction it reads `dropbox_sign.settings`, decrypts the stored `api_key` with the Encryption
module (`$this->encryption->decrypt($config->get('api_key'), TRUE)`), and **throws `\Exception` if no
API key is set**. It then creates a SDK `Configuration` (`Configuration::getDefaultConfiguration()`),
sets the API key as the username (`setUsername($api_key)` — Dropbox Sign uses HTTP Basic with the key
as username), and instantiates two SDK clients: `SignatureRequestApi` and `EmbeddedApi`. TLS is the
SDK default (not disabled). Instantiating the service without a saved key fails, so guard calls.

## Methods

### `getSignatureRequestApi(): SignatureRequestApi`
Returns the raw SDK `SignatureRequestApi` so any SDK method can be called directly, e.g.
`$api->signatureRequestCancel($signature_request_id)`.

### `createSignatureRequest($title, $subject, array $signers, $file, $mode = 'email', $redirectUrl = NULL, $msg = NULL): array`
Builds and sends a request.

- `$signers` is an associative array `email => name`; each becomes a `SubSignatureRequestSigner`
  with an incrementing `order`.
- `$file` is a **full local filesystem path**; passed as `setFiles([$file])`.
- `$mode`:
  - `'email'` → builds a `SignatureRequestSendRequest`, sets `signingRedirectUrl($redirectUrl)`,
    and calls `signatureRequestSend()`. Dropbox Sign emails signers.
  - `'embedded'` → decrypts and requires `client_id` (throws `\Exception` if missing), builds a
    `SignatureRequestCreateEmbeddedRequest` with `setClientId()`, and calls
    `signatureRequestCreateEmbedded()`. `$redirectUrl` is not used in this mode.
  - any other value → throws `\Exception`.
- Both modes call `setUseTextTags(TRUE)` and `setHideTextTags(TRUE)` (enabling `[sig|req|signerN]`
  style template tags), apply `setTestMode(TRUE)` when the `test_mode` config is on, and add
  `setCcEmailAddresses()` from the comma-split `cc_emails` config.
- **Returns** `['signature_request_id' => ..., 'signatures' => ...]` on success, or an **empty array**
  on failure — SDK `ApiException`s are caught and logged (error message includes the API error via
  `print_r`), not rethrown. Also emits a `debug` log line naming the title/file/mode.

### `getSignUrl($signatureId): array`
Calls `EmbeddedApi::embeddedSignUrl($signatureId)` and returns `['sign_url' => ...]` (the URL to load
Dropbox Sign's embedded signing widget). Returns an empty array and logs on `ApiException`.

## Notes

- All failures degrade to an empty-array return + a logged error; callers must check for the empty
  array rather than relying on exceptions (except the constructor/`client_id`/bad-mode throws).
- The service does not persist anything in Drupal — no entity, no state. Track returned
  `signature_request_id`s yourself if you need to correlate later callbacks.
