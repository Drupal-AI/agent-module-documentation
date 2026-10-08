<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Secret resolution, HTTP client factory & token capability

## Credential resolution

`Credential/CredentialResolverInterface::resolve(CredentialsInterface): CloudflareCredentials`
turns a credential set into an account ID + token, throwing `MissingCredentialException` when the
secret cannot be found. Callers depend on the interface, not the source of the secret.

Default implementation `Credential/SettingsCredentialResolver` (service alias for the interface,
`autowire`) reads from `settings.php`:

```php
$settings['cloudflare']['credentials']['<machine-name>'] = [
  'account_id' => '...',
  'token' => '...',
];
```

Both `account_id` and `token` must be non-empty strings or it throws
`MissingCredentialException::forId($id)`. Because the values are only in `settings.php`, they stay
out of the database, config export and version control. The submodule `cloudflare_sdk_key`
decorates this resolver to optionally source the token from a Key entity instead.

`CloudflareCredentials` (a value object from the `cloudflare_api` module) carries `accountId` +
`token` and is what the API client consumes.

## HTTP client factory

`Http/CloudflareHttpClientFactory` (implements `CloudflareHttpClientFactoryInterface`, `autowire`)
is a thin seam over Drupal core's `ClientFactory`:

```php
create(string $baseUri, array $defaultHeaders = []): \GuzzleHttp\ClientInterface
// → $clientFactory->fromOptions(['base_uri' => $baseUri, 'headers' => $defaultHeaders]);
```

It binds a base URI and default headers and is auth-scheme agnostic: the caller supplies
authentication as a default header (a Bearer token for the REST API, a `cf-aig-authorization` token
for the AI Gateway). It does **not** set any TLS/verify options, so it inherits core Guzzle's
defaults (certificate verification on). It gives the suite one place to add shared middleware later.

`Http/HeaderInjectingHttpClient` is a PSR-18 (`Psr\Http\Client\ClientInterface`) decorator that
adds a fixed header set to every outbound request (`$request->withHeader(...)` per header) before
delegating to the wrapped client. Used when an SDK owns request construction but callers still need
to inject auth/control headers without reaching into that SDK.

## Exceptions

- `Exception/CloudflareApiException` — base `\RuntimeException` for the suite.
- `Exception/MissingCredentialException extends CloudflareApiException` — thrown when a set's secret
  can't be resolved. `::forId($id)` builds a message telling the admin which
  `$settings['cloudflare']['credentials'][<id>]` entry to add. Messages name the credential-set id
  and (in the Key submodule) the key id — never the token value.

## Token capability detection

`TokenCapabilityResolver` (implements `TokenCapabilityResolverInterface`) answers "may this token
write?" for action-gating. `resolve()` caches per credential (cid
`cloudflare_sdk:capability:<id>`, TTL 3600s, tagged with the credential's cache tags so re-saving
the set — e.g. changing declared scope — invalidates it).

`detect()` is hybrid:
1. Verify the token via the API client `GET user/tokens/verify`; if not ok → `TokenCapability(FALSE,
   Unknown, 'verify-failed')`.
2. If the credential declares a scope (`read-only`/`read-write` third-party setting) → use it
   (`'declared'`).
3. Otherwise auto-introspect: `GET user/tokens/{id}` and classify policies via `scopeFromPolicies()`
   — read-write if any permission-group name contains `write`/`edit` (coarse; declared scope
   overrides). If introspection isn't permitted → `Unknown` (treated conservatively as read-only by
   `allowsWrite()`).

`TokenScope` enum: `ReadOnly` / `ReadWrite` / `Unknown`. `TokenCapability` bundles verified flag +
scope + a source label. The reconciler uses `->allowsWrite()` to decide whether a managed
requirement may be provisioned.
