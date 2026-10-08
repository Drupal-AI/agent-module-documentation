# Configuration

The module ships with sensible defaults tuned to the common 8 KB server header
limit, so it often works with no changes. You only need to touch these settings if
your web server enforces a smaller (or larger) maximum header size.

## Open the settings form

Go to **`/admin/config/development/settings/cacheability`**
(config `debug_cacheability_headers_split.settings`).

## Settings, field by field

- **Header size limit** (`header_size_limit`) — the size, in bytes, above which a
  debug cacheability header is considered too big and gets split. The default is
  **8192** (8 KB), matching the most common web-server limit. Lower it if your
  server (or an intermediate proxy) rejects headers at a smaller size — for
  example, some setups cap at around 4 KB.
- **Header chunk size** (`header_chunk_size`) — the maximum size, in bytes, of
  each individual header the module produces when it splits a large one. The
  default is **8000**, comfortably under the 8 KB default limit. Keep this a little
  below your header size limit so each resulting chunk stays within bounds.

Click **Save configuration** to apply your changes.

## Alternative: set the values in settings.php

If you'd rather manage these per environment in code, you can override the values
in `settings.php` (or, better, `settings.local.php`) instead of using the form:

```php
$config['debug_cacheability_headers_split.settings']['header_size_limit'] = 5120;
$config['debug_cacheability_headers_split.settings']['header_chunk_size'] = 5000;
```

The example above targets a 5 KB limit with a 5000-byte chunk size. Values set
this way take precedence over the form and are handy when different environments
sit behind servers with different header limits.

## Verify

Reload a page with many cache tags and check that each split header
(`X-Drupal-Cache-Tags`, `X-Drupal-Cache-Tags-1`, …) stays under your server's
limit. If you still see errors, lower the header size limit and chunk size to match
your server's real cap.
