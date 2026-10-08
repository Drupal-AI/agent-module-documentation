<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo API service layer & push flow

The base module wraps the vendored `neclimdul/coveo-*` OpenAPI clients behind Drupal services so the
config entities can build authenticated API objects. Defined in `coveo.services.yml`.

## Services

- **`coveo.rest.client`** — a plain `GuzzleHttp\Client` (no constructor options → **default TLS
  verification is on**; base URLs come from each client library's `Configuration`). Shared by every
  factory.
- **Factories** (`src/API/`), each `create($class, #[\SensitiveParameter] string $token)`:
  `PushApiFactory`, `FieldApiFactory`, `SearchApiFactory`, `SecurityCacheFactory`, `SourceApiFactory`.
  They delegate to `ApiFactory::create()`, which does `new $class($client, $config)` after
  `$config->setAccessToken($token)`. The token argument is marked `#[\SensitiveParameter]` so it is
  redacted from stack traces.
- **`coveo.org_api_helper`** (`OrganizationApiHelper`) — bundles the field/push/security-cache
  factories for injection into the config entity (entity service injection isn't available).
- **`coveo.index_helper_factory`** (`Coveo\IndexHelperFactory`) — builds a `Coveo\Index` from an
  organization, injecting `FileContainerApi` + `ItemApi` (both created with the org's **push key**),
  the Guzzle client, the `logger.channel.coveo` logger and the event dispatcher.
- **`logger.channel.coveo`** — dedicated log channel.
- **`plugin.manager.coveo_security_provider`** — the security-provider plugin manager.

## Push / indexing flow (`src/Coveo/Index.php`)

Called by the `coveo_search_api` backend. For documents with file attachments it uploads to a Coveo
**file container**:

1. `uploadToAwsContainer()` → `FileContainerApi::organizationsOrganizationIdFilesPost($orgId)` returns
   a presigned upload URI + required headers.
2. `PUT` the file body to that **Coveo-provided** URI via the Guzzle client (retried up to 4 times on
   `ConnectException`, `CURLOPT_CONNECTTIMEOUT => 5`). No TLS options are overridden.
3. The returned `fileId` replaces the document's `compressedBinaryDataFileId`.
4. The batch document itself is uploaded the same way, then registered with Coveo via the Push API
   `.../batch(fileId)` call (see README sequence diagram).

Errors are logged through `Error::logError` / `DrupalError::logException`; the push key/token is not
written to the log message.

## Supporting classes

- `src/DocumentBody.php`, `src/API/Model/BatchDocumentBody.php`, `src/API/Model/DeletedItem.php` —
  build the batch payload shapes.
- `src/FieldConverter.php` — applies the organization `prefix` when mapping Drupal field names to
  Coveo field names (also exposed to Twig by the atomic submodule).
- `src/Coveo/IndexHelperFactory.php` / `src/Coveo/Index.php` — the push helper described above.
