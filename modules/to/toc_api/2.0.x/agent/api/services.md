<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calling the TOC API (services + the `Toc` object)

Three services plus one value object. There is **no plugin type and no hook to implement** —
you drive the API from your own code. Namespaces are `Drupal\toc_api\*`.

## The three services

| Service id | Class | Purpose |
|---|---|---|
| `toc_api.manager` | `TocManager` | Creates and caches `Toc` instances keyed by an id |
| `toc_api.builder` | `TocBuilder` | Renders the TOC navigation and rewrites the body HTML |
| `toc_api.formatter` | `TocFormatter` | string→html id, number→decimal/alpha/roman, etc. |

### `TocManager` (`toc_api.manager`)
- `create(string $id, string $source, array $options = []): TocInterface` — parses `$source`
  and returns a `Toc`. `$options` are **deep-merged over the `default` toc_type's options**.
  `$id` is your tracking key (typically your module name).
- `getToc(string $id): ?TocInterface` — the instance created earlier this request (blocks use this).
- `reset(?string $id = NULL): void` — drop one or all cached instances.

### `TocBuilder` (`toc_api.builder`)
- `buildToc(TocInterface $toc): array` — render array for the TOC nav (`#theme` = `toc_<template>`).
- `renderToc(TocInterface $toc)` — rendered markup, or empty markup if the TOC is not visible.
- `buildContent(TocInterface $toc): array` — render array of the **body** with headers given ids
  and back-to-top links injected.
- `renderContent(TocInterface $toc): string` — that body as an HTML string. Returns the raw
  source unchanged when `!$toc->isVisible()`.

### `TocFormatter` (`toc_api.formatter`)
- `convertStringToId($text)` — slugifies a heading to a valid, accent-folded HTML id.
- `convertNumberToListTypeValue($number, $type)` — `$type` is a CSS list-style
  (`decimal`, `upper-alpha`, `lower-alpha`, `upper-roman`, `lower-roman`, `none`).
- `convertNumberToRomanNumeral($number)`, `convertNumberToLetter($number)`,
  `convertHeaderKeysToValues(array $keys, array $options)`, `convertAllowedTagsToArray($tags)`.

## The `Toc` value object (`TocInterface`)

Returned by `TocManager::create()`. Read-only accessors:

- `getSource()` — the original HTML you passed in.
- `getContent()` — source with every configured header assigned a unique `id`.
- `getOptions()` — the effective options array (defaults + toc_type + overrides).
- `getTitle()`, `getAllowedTags()`.
- `getHeaderCount()` — number of **top-level** (parentless) headers.
- `isVisible()` — `getHeaderCount() >= options['header_count']` (default 2). Below the
  threshold the builder emits nothing / returns the source unchanged.
- `isBlock()` — the `block` option (used by `TocBlockBase::blockAccess()`).
- `getIndex()` — **flat** associative array of every header (`key`, `tag`, `level`, `path`,
  `number`, `value`, `parent`, `children`, `id`, `title`, `html`, `url`).
- `getTree()` — **nested** hierarchy (`below` children under each parent) for tree templates.

## Canonical implementation (from `toc_api_example`)

```php
use Drupal\toc_api\Entity\TocType;

$toc_type = TocType::load('default');
$options  = $toc_type ? $toc_type->getOptions() : [];

/** @var \Drupal\toc_api\TocManagerInterface $manager */
$manager = \Drupal::service('toc_api.manager');
$toc = $manager->create('my_module', $rendered_html, $options);

if ($toc->isVisible()) {
  /** @var \Drupal\toc_api\TocBuilderInterface $builder */
  $builder = \Drupal::service('toc_api.builder');
  $build['body'][0] = [
    'toc'     => $builder->buildToc($toc),      // the navigation
    'content' => $builder->buildContent($toc),  // body with ids + back-to-top
  ];
}
```

Inject the services in real code instead of `\Drupal::service()`. To surface a TOC as a
**block**, subclass `Drupal\toc_api\Plugin\Block\TocBlockBase` — see
[../theming/templates.md](../theming/templates.md).
