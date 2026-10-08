<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `at_tool.lazy_builders` service

Service **`at_tool.lazy_builders`** = `Drupal\at_tool\AtToolLazyBuilders`
(args `@request_stack`, `@current_route_match`, `@title_resolver`). It implements
`TrustedCallbackInterface`, so its callback can be used in a `#lazy_builder`.

## `breadcrumbTitle()`

Returns a render array for the **current page title**, themed for placement inside a breadcrumb:

```php
[
  '#theme' => 'page_title__breadcrumb',
  '#title' => $this->titleResolver->getTitle($request, $route),
]
```

It resolves the title from the current request + route object via the core title resolver. AT
themes call this (typically as a lazy builder) to render the active page's title in the breadcrumb
region.

Trusted callbacks: `AtToolLazyBuilders::trustedCallbacks()` returns `['breadcrumbTitle']`.

## Using it

```php
// e.g. from a theme/preprocess, as a placeholdered lazy builder:
$build['breadcrumb_title'] = [
  '#lazy_builder' => ['at_tool.lazy_builders:breadcrumbTitle', []],
  '#create_placeholder' => TRUE,
];
```

This is the module's only service/public callable. There are no hooks it invites you to
implement and no other API surface — the rest of AT Tool is internal theme-support wiring
(see [../configure/theme-support.md](../configure/theme-support.md)).
