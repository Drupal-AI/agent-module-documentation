# CDN internals (services, decorators, far-future)

## Services (`cdn.services.yml`)

| Service | Role |
|---|---|
| `Drupal\cdn\CdnSettings` | `@internal` wrapper over `cdn.settings`. Key methods: `isEnabled()`, `farfutureIsEnabled()`, `getScheme()`, `getLookupTable()`, `getDomains()`, `getStreamWrappers()`, `getCdnDomain($uri)`. |
| `Drupal\cdn\File\FileUrlGenerator` | **Decorates `file_url_generator`.** Rewrites public-file URLs to a CDN domain (or the far-future route when enabled). This is the core mechanism. |
| `Drupal\cdn\Asset\CssOptimizer` | Decorates `asset.css.optimizer` so CSS-referenced assets are also CDN-ified. |
| `Drupal\cdn\CdnFarfutureController` | Serves `/cdn/ff/{security_token}/{mtime}/{scheme}` with far-future headers (validates an HMAC of private key + mtime + path). |
| `Drupal\cdn\PathProcessor\CdnFarfuturePathProcessor` | Inbound path processor so the "menu tail" file path in the far-future route is parsed. |
| `Drupal\cdn\EventSubscriber\HtmlResponseSubscriber` | Adds `<link rel="dns-prefetch">` hints for the CDN domains. |
| `Drupal\cdn\EventSubscriber\ConfigSubscriber` | Invalidates caches / reacts when `cdn.settings` changes. |
| `Drupal\cdn\StackMiddleware\DuplicateContentPreventionMiddleware` | Prevents duplicate content on the CDN when behind a reverse proxy; emits a debug header on its 301s. |

## How a URI maps to a domain

`CdnSettings::buildLookupTable()` turns `mapping` into a lookup table keyed by lowercase file
extension (or `*`). `getCdnDomain($uri)`:
1. Looks up the file's extension; else falls back to `*`; else returns `FALSE` (no rewrite).
2. If the value is an array (auto-balanced), picks one domain by
   `hexdec(substr(md5(basename($uri)),0,5)) % count($domains)` — stable per filename.
3. A mapped value of `FALSE` (e.g. a negated extension) means "serve locally".

## Far Future route

`cdn.farfuture.download` → `/cdn/ff/{security_token}/{mtime}/{scheme}` (`_access: 'TRUE'`).
Emits 480-week `Cache-Control`/`Expires`, CORS headers, and answers `If-Modified-Since` with
304. On large sites, replicate this with the `.htaccess` rules in the module's `README.txt`
so Apache serves the files instead of PHP.

## Reading config programmatically

```php
$cdn = \Drupal::service(\Drupal\cdn\CdnSettings::class);
$enabled = $cdn->isEnabled();
$domains = $cdn->getDomains();          // all configured CDN domains
$domain  = $cdn->getCdnDomain('logo.png');
```

The module also implements `hook_editor_js_settings_alter()` so CKEditor external plugin
files resolve correctly when far-future is enabled.
