<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three normalizers — how the rewrite works

Source: `src/Normalizer/{StringDataNormalizer,TextProcessedNormalizer,MarkupNormalizer}.php`,
registered in `rest_absolute_urls.services.yml`. All three take `@config.factory` and converge on
`Html::transformRootRelativeUrlsToAbsolute($value, $base_url)`.

## Registration and precedence
```yaml
services:
  serializer.normalizer.string_data.rest_absolute_urls:
    class: Drupal\rest_absolute_urls\Normalizer\StringDataNormalizer
    arguments: ['@config.factory']
    tags:
      - { name: normalizer, priority: 6 }
  serializer.normalizer.text_processed.rest_absolute_urls:
    class: Drupal\rest_absolute_urls\Normalizer\TextProcessedNormalizer
    arguments: ['@config.factory']
    tags:
      - { name: normalizer, priority: 6 }
  serializer.normalizer.markup.rest_absolute_urls:
    class: Drupal\rest_absolute_urls\Normalizer\MarkupNormalizer
    arguments: ['@config.factory']
    tags:
      - { name: normalizer, priority: 10 }
```
- Core's `serializer.normalizer.primitive_data` is priority **5**; `StringDataNormalizer` is **6**,
  so Symfony's serializer picks it first for `StringInterface` values. It affects **all** serializers
  that use the typed-data normalizer chain (JSON:API, `rest`/`serialization`, custom serializers).
- Higher-priority specialised normalizers still win for their own types: datetime / ISO-8601 /
  timestamp / password normalizers register at priority 20, so those values do not pass through this
  rewrite.
- `TextProcessedNormalizer` also sits at priority 6, matching the concrete `TextProcessed` class.
- `MarkupNormalizer` is at priority 10, ahead of core's `MarkupNormalizer`, so it claims
  `MarkupInterface` values before core serialises them to a plain string.

## StringDataNormalizer — formatted-text only
```php
public function normalize($object, $format = NULL, array $context = []): ... {
  $value = parent::normalize($object, $format, $context);
  if (!is_string($value) || !$this->isFormattedText($object)) {
    return $value;
  }
  $base_url = $this->configFactory->get('rest_absolute_urls')->get('base_url');
  if (empty($base_url)) {
    $base_url = Request::createFromGlobals()->getSchemeAndHttpHost();
  }
  return Html::transformRootRelativeUrlsToAbsolute($value, $base_url);
}
```
- `getSupportedTypes()` returns `[StringInterface::class => TRUE]`.
- **Formatted-text gate (new in 2.1.x).** `isFormattedText()` walks up to the parent
  `FieldItemInterface` and returns TRUE only when one of the field item's property definitions
  declares a `text source` setting naming this property (e.g. `value` or `summary` on a
  formatted-text field). Any other string — a node title, a plain string field — returns the
  parent-normalized value **unchanged**, so it is no longer DOM round-tripped and no longer
  re-encoded. This is the main behavioural narrowing from 2.0.x.

## TextProcessedNormalizer — the computed processed output
```php
public function normalize($object, $format = NULL, array $context = []): ... {
  $this->addCacheableDependency($context, $object);
  $value = (string) $object->getValue();
  if ($value === '') {
    return '';
  }
  // resolve base URL, then:
  return Html::transformRootRelativeUrlsToAbsolute($value, $base_url);
}
```
- `getSupportedTypes()` returns `[TextProcessed::class => TRUE]`.
- Exists because `Drupal\text\TextProcessed` extends `TypedData` directly and does **not** implement
  `StringInterface`, so `StringDataNormalizer` never matches it. This covers the `processed` computed
  property a formatted-text field exposes (the rendered HTML after text-format filters run).
- Registers the processed object as a cacheable dependency on the serialization context.

## MarkupNormalizer — rendered markup values
```php
public function normalize($object, $format = NULL, array $context = []): ... {
  $value = (string) $object;
  if ($value === '') {
    return '';
  }
  // resolve base URL, then:
  return Html::transformRootRelativeUrlsToAbsolute($value, $base_url);
}
```
- `getSupportedTypes()` returns `[MarkupInterface::class => TRUE]`.
- Some serializer callers hand over rendered markup instead of typed data. The Views REST Export
  "Fields" row plugin (`DataFieldRow`) is the main example: it renders each field to a `Markup`
  value, which `StringDataNormalizer` never sees, so without this the URLs stayed relative. Runs at
  priority 10, ahead of core's markup normalizer.

## What the core helper does
`Drupal\Component\Utility\Html::transformRootRelativeUrlsToAbsolute()`:
- `Html::load($value)` parses the string into a DOM, an XPath pass prefixes `$base_url` onto any
  attribute value starting with a single `/` (not `//`) among the URI attributes
  (`href`, `src`, `srcset`, `poster`, `cite`, `data`, `action`, `formaction`, `about`), then
  `Html::serialize()` returns the body's inner HTML.
- Protocol-relative (`//cdn/...`) and already-absolute (`https://...`) URLs are left alone.
- Asserts (dev builds only) that `$base_url` is scheme+host(+port) with **no path** — a base URL
  such as `https://example.com/app` fails the assertion.

## Base URL resolution (all three)
- Config `rest_absolute_urls.base_url` first; otherwise the scheme+host of a freshly built request
  from PHP globals (`Request::createFromGlobals()->getSchemeAndHttpHost()`).
- Behind a reverse proxy/CDN the auto-detected host depends on `trusted_host_patterns` and
  reverse-proxy settings; when in doubt set `$config['rest_absolute_urls']['base_url']` explicitly in
  `settings.php`.

## Edge cases and side effects
- **Only formatted text / processed text / markup is rewritten.** Plain string primitives are
  returned untouched (no DOM round-trip, no entity re-encoding) — a change from 2.0.x.
- **Only HTML URI attributes are rewritten.** A value that is a bare path (`/node/12` as literal
  text, not inside an `href`) is not changed.
- **Views "Raw output".** The Fields row plugin with Raw output enabled returns the field's raw
  scalar, bypassing the render pipeline and therefore every normalizer; those URLs stay relative.
  Turn Raw output off or use the Entity row plugin.

## Verify
- `ddev drush cget rest_absolute_urls base_url` — returns "Config ... does not exist" until you add
  the settings.php override (the module ships no config).
- Request a JSON:API resource whose body embeds a CKEditor image; the `src` should come back with
  the absolute host prefixed.
- Unit tests ship for all three normalizers under `tests/src/Unit/`.
