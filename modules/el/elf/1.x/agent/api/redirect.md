# Redirect service and endpoint

When the `elf_redirect` option is on, external links are rewritten to point at an internal
endpoint that forwards the browser to the real destination. Two pieces implement it.

## Service `elf.manager`
`Drupal\elf\ElfManager` implements `ElfManagerInterface`; constructed with `@private_key`.

```php
$url = \Drupal::service('elf.manager')->getRedirectUrl($external_url);
// $url is a \Drupal\Core\Url to route 'elf.redirect'.
$href = $url->toString();  // /elf/redirect?url=<external>&key=<token>
```

- **`getRedirectUrl($external_url): \Drupal\Core\Url`** — `$external_url` may be a string or a
  `\Drupal\Core\Url`. Returns a `Url` for route `elf.redirect` with query params `url` (the
  target) and `key`, where `key = Crypt::hmacBase64($external_url_string, $private_key->get())`.

The filter calls this in `FilterElf::process()` to replace each external link's `href`.

## Route `elf.redirect`
Path `/elf/redirect`, permission `access content`, controller
`Drupal\elf\Controller\ElfController::elfRedirect`.

Reads `url` and `key` from the query string. It recomputes the expected key via
`elf.manager->getRedirectUrl($url)` and, if `url` or `key` is missing or the supplied `key`
does not match the recomputed one, throws `NotFoundHttpException` (a 404 — behaves like a
broken link). On a match it returns a `TrustedRedirectResponse($url)` to the external target.

So only `url`+`key` pairs produced by `getRedirectUrl()` (i.e. links the site itself signed
with its private key) resolve; anything else 404s.
