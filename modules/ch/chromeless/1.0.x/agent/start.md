<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chromeless (chromeless) — agent index

Adds a `chromeless` query parameter that makes Drupal render **only the main content** of a page (no
header/footer/blocks). When active it selects a custom page display variant instead of the site default.
Version **1.0.0-alpha1**. Core `^10.5 || ^11`, PHP `>=8.3`. License GPL-2.0-or-later. No dependencies.

- **How it works, the container parameters, per-session state, caching, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- No config entity, **no settings form** (`configure` is null), **no permissions**, no routes, no
  Drush, no config schema, no libraries. Pure runtime rendering behaviour driven by two query params.
- One page display variant plugin: **`ChromelessPageVariant`** (id `chromeless_page`, label
  *"Chromeless page"*) in `src/Plugin/DisplayVariant/ChromelessPageVariant.php`, extending core
  `VariantBase` and implementing `PageVariantInterface`. Its `build()` returns only status messages
  (with `#include_fallback` so JS Messages still work), an optional `page_title` (shown only when the
  title preference is active), and the main content render array — no blocks.

## Provided services (`chromeless.services.yml`)

- `chromeless.tempstore` → **`ChromelessTempstore`** (`src/ChromelessTempstore.php`, `@internal`,
  `final`): reads the two query params off the current request; if present, casts each value to
  `bool` via `!!(int)` and writes it to the `chromeless.state` **private temp store**; exposes
  readonly `isActive`, `isActiveTitle` (title only when also active), and `cacheContexts`.
- `chromeless.page_display_variant_subscriber` → **`PageDisplayVariantSubscriber`**
  (`src/EventSubscriber/`): on core `RenderEvents::SELECT_PAGE_DISPLAY_VARIANT`, calls
  `$event->setPluginId('chromeless_page')` when the tempstore reports active.
- `cache_context.chromeless_state` → **`ChromelessStateCacheContext`** (`src/Cache/`, context id
  `chromeless_state`): its `getContext()` hashes `{active, active_title}`; `getCacheableMetadata()`
  adds contexts `url.query_args:chromeless`, `url.query_args:title`, and `session`.

## Hooks

- `chromeless_page_attachments_alter()` in `chromeless.module` appends the `chromeless_state` cache
  context to every page's `#cache` contexts (so the toggle applies to non-chromeless pages too).

## Container parameters (customisable)

- `chromeless.query.active` (default `chromeless`) and `chromeless.query.title` (default `title`) —
  the query-parameter names; override in a site-wide `services.yml`. See
  [config/settings.md](config/settings.md).

## Notes

- Strips surrounding chrome only; the underlying route/content still enforces its own access — not an
  access-control feature and not a bypass. It has no access role of its own.
