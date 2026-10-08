<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — http_client_options_per_uri

## Where
`settings.php` only — there is no UI. Key: `$settings['http_client_options_per_uri_config']`.

## Shape
An array keyed by a free-form identifier; each entry has:
- `regexp` — a PCRE tested against the full request URI (`preg_match`).
- `options` — an array of standard Guzzle request options merged into the request.

```php
$settings['http_client_options_per_uri_config']['paypal'] = [
  'regexp' => '/^http(?:s)?:\/\/api\.(?:sandbox\.)?paypal\.com.*$/i',
  'options' => [
    'timeout' => 10,
    'connect_timeout' => 10,
  ],
];
```

## Matching rules
- All entries are evaluated; every entry whose `regexp` matches contributes.
- If more than one matches, **the last matching entry's options win** (`$result` is overwritten, then deep-merged into request options).
- Matched options are combined with existing request options via `NestedArray::mergeDeep()`.

## Security-relevant options
- `verify => false` disables TLS certificate verification for matching hosts (MITM risk). Only set this deliberately and document why; it is only settable here in `settings.php`.
- `proxy`, `cert`, `ssl_key`, custom `headers`, and auth options are likewise merged verbatim — scope the `regexp` tightly so options don't leak to unintended hosts.

## Mechanism
`HcopuClientFactory::fromOptions()` unshifts a middleware named `requestOptionsMiddleware`; on each request `requestOptionsAdjust()` calls `requestOptionsUriLocate((string) $request->getUri())`.
