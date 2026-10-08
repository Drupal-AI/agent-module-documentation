<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service: `toc_js.service` (TocJsService)

`Drupal\toc_js\Service\TocJsService`, service id `toc_js.service` (constructed with
`@current_route_match`). Used by the block, the node view, and the submodules.

## Methods

- `defaultSettings(): array` — the ~40 default TOC option keys/values (see
  [../configure/per-content-type.md](../configure/per-content-type.md) for the list). The single
  source of truth for TOC settings.
- `getTocForm(array &$form, array $values, array|string|null $parents = NULL, array $states = []): void`
  — builds the settings form (title, selectors, container, list type, smooth scrolling, back-to-top,
  sticky, collapsible, ajax, …). Reused by the node type form, the block form, and the filter form,
  with different `$parents`.
- `buildToc(string $id, array $settings): array` — returns the TOC render array: a `#theme => 'toc_js'`
  element whose `.toc-js` wrapper carries the settings as `data-*` attributes, attaches the
  `toc_js/toc` library, and passes `back_to_top_label` / `back_to_toc_label` via `drupalSettings`.
  Settings listed in `getSettingsToIncludeAsAttributes()` are emitted as `data-*` attributes
  (XSS-filtered).
- `getTocEntity(): ?EntityInterface` — the current route entity (node or taxonomy term) used for
  theme context.
- `getTocCacheTags(): array` / `getTocCacheContexts(): array` — the route entity's cache tags and
  `['url.path']`.

## Usage

```php
$svc = \Drupal::service('toc_js.service');
$defaults = $svc->defaultSettings();
$build = $svc->buildToc('my-toc-id', ['selectors' => 'h2,h3'] + $defaults);
```

`buildToc()` does not itself render the list — the JS library (`toc_js/toc`, which depends on
`toc_js/tocjs`, jQuery, `core/drupal`, `core/once`) reads the `data-*` attributes client-side and
generates the anchor list.
