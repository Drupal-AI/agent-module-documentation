# Configure removed headers

## What it does

An HTTP stack middleware, `RemoveHttpHeadersMiddleware` (registered as
`http_middleware.remove_http_headers` with `priority: 1000`, `responder: true`, so it runs
last — after page cache middleware), inspects each **main request** response and calls
`$response->headers->remove($name)` for every configured header name. Subrequests are left
untouched.

Special case: if `X-Generator` is in the list, `remove_http_headers_page_attachments_alter()`
also removes Drupal's default `<meta name="Generator">` tag from the HTML `<head>`.

## Settings UI

| Route | Path | Access |
|---|---|---|
| `remove_http_headers.remove_http_headers_settings` | `/admin/config/system/remove-http-headers` | `remove_http_headers settings access` |

Menu link parent: `system.admin_config_system` (Admin → Configuration → System). The form
(`RemoveHttpHeadersSettings`) is a single textarea, **one header name per line**. On save it
validates that no header contains whitespace (regex `/^[^\s]+$/`); otherwise it errors with
"The format of the HTTP headers field is not valid."

## Config object — `remove_http_headers.settings`

One key holds the list:

```yaml
headers_to_remove:
  - 'X-Generator'
  - 'X-Drupal-Dynamic-Cache'
  - 'X-Drupal-Cache'
```

- `headers_to_remove` — a `sequence` of header-name strings (schema:
  `config/schema/remove_http_headers.schema.yml`). These three are the install defaults.
- It is a `config_object`, so it exports/deploys with `drush config:export` /
  `drush config:import`.
- The install config enforces a dependency on the `remove_http_headers` module.

Common headers to add: `X-Generator` (Drupal version), `X-Drupal-Dynamic-Cache`,
`X-Drupal-Cache` (page cache HIT/MISS), `X-Powered-By` (if the server/PHP adds one).

## Set the list via drush

```bash
# Replace the whole list
drush config:set remove_http_headers.settings headers_to_remove.0 'X-Generator' -y
drush config:set remove_http_headers.settings headers_to_remove.1 'X-Drupal-Dynamic-Cache' -y
# Or import an edited YAML export
drush config:import
```

## Caching / API

`ConfigManager` (service `remove_http_headers.config_manager`, args `@config.factory`,
`@cache.default`) reads the list and caches it under cache id/tag
`remove_http_headers.settings.headers_to_remove`, invalidating on save. Public methods:

- `getHeadersToRemove(bool $skip_cache = FALSE): string[]` — the effective list.
- `saveHeadersToRemoveToConfig(array $headers): void` — write list + invalidate cache.
- `shouldHeaderBeRemoved(string $name): bool` — is a given header configured for removal.
