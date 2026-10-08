<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the JS redirect link process plugin

```yaml
process:
  'field_web_link/uri':
    - plugin: migrate_process_js_redirect_link
      source: link
```

Behaviour (`src/Plugin/migrate/process/MigrateProcessJsRedirectLink.php::transform`):

1. Returns `''` unless the input starts with `http` and passes `FILTER_VALIDATE_URL`.
2. Guzzle `GET` the URL (`@http_client`); on `TransferException` logs a notice and returns `''`.
3. Loads the response HTML into `DOMDocument` (errors suppressed via `libxml_use_internal_errors`).
4. Returns the `href`/nodeValue of the last `<a>` if it is an absolute URL, else `''`.

Typically chained with `dom`, `dom_select`, `skip_on_empty`, `file_remote_url`. Note the fetched URL is server-side; only feed it trusted source data.
