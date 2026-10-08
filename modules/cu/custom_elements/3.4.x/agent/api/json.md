<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON serialization

Service `custom_elements.normalizer` = `Drupal\custom_elements\CustomElementNormalizer`
(a `Symfony\…\NormalizerInterface`, supports `CustomElement` objects).

## Entry points

- `CustomElement::toJson(bool $preserve_keys = FALSE, ?BubbleableMetadata $cache = NULL): array`
  — uses the configured `json_format`.
- `CustomElement::toArray(bool $preserve_keys = FALSE, ?BubbleableMetadata $cache = NULL, bool $explicit = FALSE): array`
  — lets the caller force the format via `$explicit`.
- `$normalizer->normalize($element, NULL, $context)` directly.

`$context` keys: `cache_metadata` (a `BubbleableMetadata` to collect tags/contexts through the
tree), `key_casing` (`'ignore'` keeps underscores; default converts keys to camelCase for JS),
`explicit` (bool) or the BC `json_format` (`'explicit'`/`'legacy'`). When neither is given the
`json_format` setting decides (default `explicit`), and `custom_elements.settings` is added as a
cacheable dependency.

## Formats

**Explicit** (`normalizeInExplicitFormat`, default for new installs):
```json
{ "element": "article-teaser",
  "props": { "title": "Title", "href": "/article/1" },
  "slots": { "default": "<p>Content</p>",
             "media": { "element": "image", "props": { "src": "/img.jpg" } } } }
```
`props`/`slots` are omitted when empty.

**Legacy / implicit** (`normalizeInImplicitFormat`, `json_format: legacy`; removed in 4.x — set on
upgraded sites by `custom_elements_update_9401`): props and slots merged at the root; the `default`
slot is renamed `content`.
```json
{ "element": "article-teaser", "title": "Title", "href": "/article/1",
  "content": "<p>Content</p>", "media": { "element": "image", "src": "/img.jpg" } }
```

## Normalization rules

- `element` = `getPrefixedTag()`. A bare `div`/`span` wrapper element key is dropped (implicit
  format), and empty `div`/`span` slot elements are skipped (explicit).
- A `renderless-container` element is flattened: only its slots are output, merged into one array.
- Attributes are copied as props; a leading `:` (vue bound-prop marker) is stripped; the `slot`
  attribute is skipped.
- Slot content: a nested `CustomElement` is recursively normalized (respecting the format); a
  `MarkupInterface` slot is cast to a string. Single-valued slots
  (`NORMALIZE_AS_SINGLE_VALUE`, set when no explicit index is passed) collapse to a scalar rather
  than a one-element array.

**Escaping:** JSON output is **not** HTML-escaped — attribute and slot string values are emitted
as-is. Escaping is the front end's responsibility in the decoupled contract.
