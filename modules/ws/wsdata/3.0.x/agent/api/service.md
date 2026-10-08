# The `wsdata` service (calling a service from PHP)

Service id `wsdata` → `\Drupal\wsdata\WSDataService`. This is how blocks, fields and your own
code run a configured WSCall.

```php
$wsdata = \Drupal::service('wsdata');
$result = $wsdata->call(
  'fetch_post',            // WSCall id (or a loaded WSCall object)
  NULL,                    // $method — NULL = connector's default (e.g. 'get')
  ['id' => 42],            // $replacements — values for [name] patterns in endpoint/path
  NULL,                    // $data — request body (encoded by the WSEncoder)
  ['method' => 'get'],     // $options — merged over the call's stored options
  'title',                 // $key / returnToken — select a nested value ('a:b:c')
  ['node' => $node],       // $tokens — Drupal core token context
  []                       // $cache_tag — extra cache tags for the result
);
```

Full signature:
`call($wscall, $method = NULL, $replacements = [], $data = NULL, $options = [], $key = NULL, $tokens = [], $cache_tag = [])`.

- **`$replacements`** replace `[name]` literals in the URL/path/query/body via
  `str_replace`. **`$tokens`** are then run through Drupal's token service
  (`[node:title]`, etc.). Both are applied in `WSConnectorBase::applyReplacements()`.
- **`$key`** selects out of the decoded structure using a `:`-delimited path
  (`WSDecoderBase::getData()`), e.g. `results:0:name`.
- Returns the decoded/selected data, or `FALSE` on error.

## Fetch + cache flow (`WSCall::call()`)

1. Load the WSServer instance; error out if missing.
2. Build a cache id = `md5(serialize(options + replacements + tokens + data + key + connector cache key))`.
3. **Cache hit** in the `wsdata` bin: return the parsed value if the decoder `isCacheable()`,
   else re-decode the cached raw body.
4. Resolve the method (explicit arg → `options['method']` → connector default); invalid method
   throws `WSDataInvalidMethodException`.
5. Encoder encodes `$data`; connector `call()` performs the request.
6. On connector error: log a `wsdata` error, set status, return `FALSE`.
7. Decode the response, select by `$key`, and **cache** the result for
   `connector->expires()` seconds (only if the connector `supportsCaching($method)` and the
   encoder/decoder are cacheable). Cache tags = server tags + call tags + `$cache_tag`.

The HTTP connector's `expires()` comes from the response `Cache-Control: max-age` header, or the
per-call `expires` option override. Only `get` requests are cacheable.

## Inspecting a call

```php
$status = $wsdata->lastCallStatus();   // method, uri, response code, cache cid/tags/debug…
$error  = $wsdata->getError();         // last error string, cleared on read
```

With `wsdata_debug_mode` state on, the status (including request options and response body) is
printed as a status message.

## Exceptions

`WSDataException` (base), `WSDataInvalidMethodException`, `WSDataWSCallNotFoundException`,
`WSDataWSServerNotFoundException` — all in `\Drupal\wsdata\`.

## Form helper

`WSDataService::wscallForm($configurations, $wscall_id)` returns a reusable form fragment
(WSCall select + replacement textfields + data + return-token) with an AJAX callback
`WSDataService::wscallConfigurationsReplacements`; the block and field forms both embed it.
