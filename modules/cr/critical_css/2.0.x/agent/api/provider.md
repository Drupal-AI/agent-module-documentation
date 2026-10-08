<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & when it runs

## `critical_css` (public service `CriticalCssProvider`)

Implements `CriticalCssProviderInterface`. Key methods:

- `getCriticalCss()` — returns the inlined critical CSS string for the current request
  (first matching file's contents; optimized via `asset.css.optimizer` when
  `system.performance:css.preprocess` is on). Memoized per request.
- `getFilePaths()` / `getMatchedFilePath()` — the candidate list and the file that matched.
- `isEnabled()` — see below.
- `reset()` — clears the per-request memoization.

```php
$css = \Drupal::service('critical_css')->getCriticalCss();
$file = \Drupal::service('critical_css')->getMatchedFilePath();
```

## `asset.css.collection_renderer.critical_css` (decorator)

`CssCollectionRenderer` **decorates** core's `asset.css.collection_renderer`. It calls the
provider, inlines the critical CSS in a `<style>` tag in the head, and rewrites the other
stylesheet links to load asynchronously (Filament Group `media`/`onload` pattern; preloads
them first when `preload_non_critical_css` is on).

## When critical CSS is NOT applied

`CriticalCssProvider::isEnabled()` / `calculateFilePaths()` return nothing when:

- `enabled` is false;
- the current route is an **admin route** and the user can *view the administration theme*;
- the request is an **AJAX/XHR** request;
- the user is **authenticated** and `enabled_for_logged_in_users` is false;
- the current entity's id is listed in `excluded_ids`.

Only nodes and taxonomy terms are treated as the "current entity" for the `{entity_id}` /
`{bundle}` candidates. There is no plugin type here — extend behaviour with the file-paths
hook ([../hooks/file-paths.md](../hooks/file-paths.md)) or by decorating these services.
