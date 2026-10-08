# API — `hubspot.hubspot` service

Service id `hubspot.hubspot`, class `Drupal\hubspot\Hubspot`. Deps: `state`, `logger.factory`,
`config.factory`, `http_client`, `plugin.manager.mail`, `request_stack`. Wraps the
`hubspot/hubspot-php` (SevenShores) client. All calls hit fixed HubSpot endpoints.

```php
$hs = \Drupal::service('hubspot.hubspot');
```

## Auth / lifecycle
- `isConfigured(): bool` — true iff state `hubspot.hubspot_refresh_token` is non-empty.
- `getAuthorizationUrl(): string` — builds the HubSpot authorize URL from `hubspot_client_id`,
  the `hubspot.oauth_connect` redirect URI, and scopes parsed from `hubspot_scope`
  (falls back to `['oauth','forms']`).
- `authorize(string $code): void` — exchanges an OAuth code for tokens (via
  `oAuth2()->getTokensByCode()`), stores access/refresh tokens + expiry in state.
- `refreshTokens(): void` — refreshes using the stored refresh token; resets the cached client.
- `getHubspotClient(): Factory` — returns an authenticated client, auto-refreshing when
  `hubspot.hubspot_expires_in < time()`. Throws `\LogicException` if not configured.

## Data operations
- `getHubspotForms(): array` — all HubSpot forms (statically cached). Used to populate the handler
  dropdown.
- `submitHubspotForm(string $form_guid, array $form_field_values, array $context = [], array $request_body = []): Response`
  — posts a submission to `forms()->submit($portal_id, $form_guid, ...)`. Normalizes values:
  File entities are uploaded (`files()->upload()`) and replaced by URL; other entities → label;
  arrays → `;`-joined. Adds `context.ipAddress` (client IP), `context.pageUri` (referer), and
  `context.hutk` (the `hubspotutk` cookie) when present.
- `hubspotGetRecent(int $count = 5): Response` — recent contacts/leads (`contacts()->recent`).
- `hubspotGetSubscriptions(): array` — email subscription definitions (statically cached).

## Notes
- Token storage is Drupal **state**, not config, so tokens are not exported with configuration.
- The service throws on unconfigured use; callers should guard with `isConfigured()` (the Webform
  handler does).
- No SSRF surface: endpoints/URLs are the HubSpot API host baked into the client, not user input.
