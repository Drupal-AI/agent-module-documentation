<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare API (cloudflare_api) — agent index

A **standalone, dependency-free PHP client for the Cloudflare v4 management API**
(`https://api.cloudflare.com/client/v4/`). It authenticates each call from a neutral
credentials contract (**account id + API token**), depends only on PSR HTTP interfaces,
and normalises Cloudflare's response envelope into a small result value object. It has
**no admin UI, no routes, no forms, no permissions, no config, and no JS** — it is a
library other code (or other Cloudflare-suite modules) calls from PHP.

Package `Cloudflare`. Core `^10.5 || ^11 || ^12`. PHP `>=8.3`. License GPL-2.0-or-later.
Installed as **1.0.0-alpha2** (version dir `1.0.x`). `security_advisory_coverage: not-covered`.

## Dependencies

- **Drupal modules: none.** `.info.yml` declares no `dependencies`, and
  `cloudflare_api.services.yml` wires against Drupal core's `@http_client` only.
- **PHP libraries** (`composer.json`): `guzzlehttp/psr7 ^2.0`, `psr/http-client ^1.0`,
  `psr/http-factory ^1.0`.
- **Note:** despite what `README.md` says, alpha2 does **not** require or depend on
  `cloudflare_sdk`. The SDK (reviewed separately) is a *consumer* that implements the
  credentials contract and passes it in; this module does not depend on it.

## What it provides (from source)

- **v4 API client** — `CloudflareApiClient` implements `CloudflareApiClientInterface`
  (`src/`), a `final` class registered as a service and aliased by its interface. Methods,
  each taking a `CloudflareCredentialsInterface` as the first argument:
  - `get($cred, $path)`, `delete($cred, $path)` — bodyless.
  - `post/put/patch($cred, $path, array $body)` — JSON body (`Json::encode`, `Content-Type:
    application/json`).
  - `graphql($cred, $query, $variables = [])` — POSTs to the fixed `graphql` path and
    parses the GraphQL `{data, errors}` envelope (not the standard `{success, result}` one).
  - `putMultipart($cred, $path, array $parts)` — generic multipart PUT (e.g. Worker script
    uploads) via `GuzzleHttp\Psr7\MultipartStream`; the caller builds the parts.
  - All standard-envelope methods route through `standard()` → `send()` →
    `parseStandardEnvelope()`.
- **Result value object** — `CloudflareApiResult` (`final readonly`, `JsonSerializable`):
  props `ok`, `result`, `errors[]`, `forbidden`; factories `success()`, `error()`,
  `forbidden()`; `toArray()` / `jsonSerialize()`. A **401/403 is modelled as a first-class
  `forbidden` result, never thrown**, so read-only tokens degrade gracefully. A transport
  exception (`ClientExceptionInterface`) is caught and mapped to `error([...])`.
- **Credentials contract** — `CloudflareCredentialsInterface` (`accountId()`, `apiToken()`)
  and the immutable `CloudflareCredentials` value object (`final readonly`, `Stringable`).
  The `apiToken` constructor param is `#[\SensitiveParameter]`, and `__toString()` returns
  **only the account id, never the token** (documented as leak avoidance).
- **Services** (`cloudflare_api.services.yml`): the client + interface alias,
  `cloudflare_api.psr17_factory` (`GuzzleHttp\Psr7\HttpFactory`, used for both request and
  stream factories), and a dedicated logger channel `logger.channel.cloudflare_api`.
- **Hooks**: only `hook_help` (route `help.page.cloudflare_api`), implemented via the
  OOP `#[Hook('help')]` attribute in `src/Hook/CloudflareApiHooks.php`, with a
  `#[LegacyHook]` shim in `cloudflare_api.module`. No install/update/schema hooks.
- **Tests**: `tests/src/Unit/` covers the client (envelope mapping, forbidden, transport
  error, JSON/multipart/GraphQL bodies, auth header), the result object, and credentials.

## Authentication & transport (posture)

- The token is attached per request as `Authorization: Bearer <token>` in
  `CloudflareApiClient::send()`; there is **no config/state storage** of credentials in this
  module — the caller supplies them each call.
- Transport is Drupal core's Guzzle `http_client`; **TLS certificate verification is left at
  Guzzle's secure default** (no `verify => false`, no `CURLOPT_SSL_VERIFYPEER=0`, no raw
  `file_get_contents`).
- The base URI is the **fixed** `https://api.cloudflare.com/client/v4/`; requests are built
  as `baseUri . ltrim($path, '/')`. `$path` is developer-supplied (not request-derived).
- On failure the logger records only `@method`, `@path`, and the exception `@message` — the
  token is never logged.

## README vs. shipped code

`README.md` describes a much larger surface (a `TokenCapabilityResolver`, a
capability/primitive/reconciler provisioning framework, `AccountResourceLister`, deployment
appliers, a credentials admin column, and a `cloudflare_sdk` dependency). **None of that
exists in the alpha2 source** — the shipped module is only the thin client, result, and
credentials contract described above. Treat the README as aspirational for this version.

## Usage note

There is no UI. Obtain the client service by its interface
(`Drupal\cloudflare_api\CloudflareApiClientInterface`), construct a
`CloudflareCredentials($accountId, $apiToken)` (token sourced from a Key entity /
`settings.php` / env — never committed), and call e.g.
`$client->get($credentials, 'user/tokens/verify')`; inspect `$result->ok` /
`$result->forbidden` / `$result->result`.
