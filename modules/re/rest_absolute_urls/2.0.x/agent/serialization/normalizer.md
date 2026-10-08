<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# StringDataNormalizer — how the rewrite works

Source: `src/Normalizer/StringDataNormalizer.php`, registered in
`rest_absolute_urls.services.yml`.

## Registration and precedence
```yaml
services:
  serializer.normalizer.string_data.rest_absolute_urls:
    class: Drupal\rest_absolute_urls\Normalizer\StringDataNormalizer
    arguments: ['@config.factory']
    tags:
      - { name: normalizer, priority: 6 }
```
- Extends `Drupal\serialization\Normalizer\PrimitiveDataNormalizer`.
- `supportedInterfaceOrClass = StringInterface::class` — it matches every string primitive
  typed-data value.
- Core's `serializer.normalizer.primitive_data` is priority **5**; this one is **6**, so Symfony's
  serializer picks it first for strings. It therefore affects **all** serializers that go through
  the typed-data normalizer chain (JSON:API, `rest`/`serialization`, custom serializers), not just
  a configured REST resource.
- Higher-priority specialised normalizers still win for their own types: datetime / ISO-8601 /
  timestamp / password normalizers register at priority 20, so those values do not pass through
  this rewrite.

## normalize()
```php
public function normalize($object, $format = NULL, array $context = []): ... {
  $value = parent::normalize($object, $format, $context);
  $base_url = $this->configFactory->get('rest_absolute_urls')->get('base_url');
  if (empty($base_url)) {
    $base_url = Request::createFromGlobals()->getSchemeAndHttpHost();
  }
  if (empty($value) && is_array($value)) {
    return '';
  }
  return Html::transformRootRelativeUrlsToAbsolute($value, $base_url);
}
```
1. Gets the parent-normalized scalar string.
2. Resolves the base URL: config `rest_absolute_urls.base_url` first; otherwise the scheme+host of
   a freshly built request from PHP globals (`Request::createFromGlobals()->getSchemeAndHttpHost()`).
3. Empty-array guard returns `''`.
4. Delegates to `Html::transformRootRelativeUrlsToAbsolute($value, $base_url)`.

## What the core helper does
`Drupal\Component\Utility\Html::transformRootRelativeUrlsToAbsolute()`:
- `Html::load($value)` parses the string into a DOM, an XPath pass prefixes `$base_url` onto any
  attribute value starting with a single `/` (not `//`) among the URI attributes
  (`href`, `src`, `srcset`, `poster`, `cite`, `data`, `action`, `formaction`, `about`), then
  `Html::serialize()` returns the body's inner HTML.
- Protocol-relative (`//cdn/...`) and already-absolute (`https://...`) URLs are left alone.
- Asserts (dev builds only) that `$base_url` is scheme+host(+port) with **no path** — a base URL
  such as `https://example.com/app` will fail the assertion.

## Edge cases and side effects
- **Applies to plain text too.** A node title, a plain string field — every string primitive is
  DOM-loaded and re-serialized. Values with HTML-special characters can come back re-encoded
  (`&` -> `&amp;`), which is a behavioural change even when there is no URL to rewrite.
- **Only HTML URI attributes are rewritten.** A field whose value is a bare path (`/node/12` as
  literal text, not inside an `href`) is not changed.
- **Base URL correctness is the operational risk.** Behind a reverse proxy/CDN the auto-detected
  host depends on `trusted_host_patterns` and reverse-proxy settings; when in doubt set
  `$config['rest_absolute_urls']['base_url']` explicitly in `settings.php`.

## Verify
- `ddev drush cget rest_absolute_urls base_url` — returns "Config ... does not exist" until you add
  the settings.php override (the module ships no config).
- Request a JSON:API resource whose body embeds a CKEditor image; the `src` should come back with
  the absolute host prefixed.
