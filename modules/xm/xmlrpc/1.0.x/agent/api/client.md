# XML-RPC client API

All functions are procedural and live in `xmlrpc.inc`, autoloaded when you call `xmlrpc()`. Call
`\Drupal::moduleHandler()->loadInclude('xmlrpc', 'inc');` first if you use the lower-level helpers
directly.

## `xmlrpc()` — the one function you usually need

```php
$result = xmlrpc($url, $args, $headers = []);
```

- `$url` (string): absolute URL of the remote XML-RPC endpoint, e.g. `https://example.com/xmlrpc`.
- `$args` (array): map of `method.name => [param1, param2, ...]`.
  - **One** entry → a single `methodCall`.
  - **Multiple** entries → the module builds a single `system.multicall`.
- `$headers` (array): optional extra HTTP headers merged onto `Content-Type: text/xml`.
- Returns: the decoded return value on success; for a multicall, an array of results where a failed
  sub-call is an `xmlrpc_error` object. Returns `FALSE` on transport/parse/fault failure.

```php
// Single call.
$sum = xmlrpc('https://example.com/xmlrpc', ['math.add' => [3, 4]]);

// Multicall (one HTTP request, several methods).
$results = xmlrpc('https://example.com/xmlrpc', [
  'math.add' => [3, 4],
  'math.sub' => [9, 2],
]);

if ($sum === FALSE) {
  \Drupal::logger('mymod')->error('@code: @msg', [
    '@code' => xmlrpc_errno(),
    '@msg' => xmlrpc_error_msg(),
  ]);
}
```

Transport uses `\Drupal::httpClient()->post()` (Guzzle). Connection/request exceptions are caught and
turned into error code `-32300`; a parse failure is `-32700`; a remote fault surfaces the remote
`faultCode`/`faultString`.

## Error inspection (client side)

- `xmlrpc_errno()` → last error code, or `NULL`.
- `xmlrpc_error_msg()` → last error message, or `NULL`.
- `xmlrpc_clear_error()` → reset stored error (called automatically at the start of each `xmlrpc()`).

## Building typed values (rarely needed directly)

`xmlrpc()` auto-encodes PHP scalars/arrays. Wrap a value only to force a specific XML-RPC type:

- `xmlrpc_date($time)` — `$time` is a PHP timestamp or ISO-8601 string → sent as `dateTime.iso8601`.
- `xmlrpc_base64($data)` — sent as `base64` (binary payloads).
- `xmlrpc_value($data, $type = FALSE)` — low-level wrapper; type is auto-detected
  (`boolean`/`double`/`int`/`null`/`array`/`struct`/`string`) unless forced. String-keyed arrays
  become `struct`, integer-indexed arrays become `array`.

```php
xmlrpc($url, ['blog.post' => [xmlrpc_date(time()), xmlrpc_base64($binary)]]);
```

Type mapping (PHP → XML-RPC): bool→boolean, float→double, int→int, null→nil, list→array,
assoc/object→struct, string→string. Strings are HTML-escaped on serialization.
