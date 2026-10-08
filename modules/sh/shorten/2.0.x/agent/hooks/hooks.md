# Shorten URLs — hooks

## `hook_shorten_service()`
Register one or more shortening services. Return an array keyed by service machine name. Each
value is either:
- a **string** — the endpoint prefix; the target URL is appended and fetched
  (e.g. `'https://is.gd/create.php?format=simple&url='`); or
- an **array** with keys:
  - `url` — endpoint prefix (URL appended, `urlencode`d);
  - `tag` — XML tag to extract from the response, or
  - `json` — JSON member name / dot-path to extract (`shorten_get_value_from_json`);
  - `custom` — a PHP function name called as `custom($original, ...$args)` returning the short URL
    (used by `goo.gl` → `_shorten_googl`, `ShURLy` → `_shorten_shurly`);
  - `args` — extra args passed to the `custom` callback.

Example:
```php
function mymodule_shorten_service() {
  return [
    'my.sh' => 'https://my.sh/api?url=',
    'my.json' => ['url' => 'https://my.sh/api?u=', 'json' => 'data.short'],
  ];
}
```
The core module's own `shorten_shorten_service()` is itself an implementation; services show up in
the admin selector and `shorten_url($url, '<key>')`.

## `hook_shorten_create($original, $url, $service)`
Invoked (via `invokeAll`) after each successful shortening, with the original URL, the resulting
short URL, and the service key used. The `record_shorten` submodule uses this to log shortened
URLs. Implement it to record/audit/react to shortenings.

```php
function mymodule_shorten_create($original, $url, $service) {
  \Drupal::logger('mymodule')->info('Shortened @o -> @u via @s', [
    '@o' => $original, '@u' => $url, '@s' => $service,
  ]);
}
```
