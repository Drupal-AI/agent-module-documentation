<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Ajax Lazy Builder Block (vallb) — agent index

Provides Ajax-lazy-loaded copies of Views **block** displays. Each such block renders only a
small placeholder on page load; a client-side **IntersectionObserver** fires an Ajax callback that
renders the real view and swaps it in when the block scrolls into view. Purpose: put many heavy
Views blocks (dashboards, charts) on one page without stalling the first, uncached hit — and
without BigPipe. Package `Views`. Depends on **`drupal:views`** only. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.2 (doc dir `1.x`). No permissions, no Drush, no config form.

- **The block plugin, the Ajax route/controller, the JS, theming, and the `hook_preprocess_vallb`
  extension point** → [api/lazy-block.md](api/lazy-block.md)

## What it actually is (from source)

- Block plugin **`vallb_block`** — `src/Plugin/Block/ViewsLazyBuiltBlock.php`, extends core
  `ViewsBlock`; deriver `src/Plugin/Derivative/ViewsLazyBuiltBlock.php` extends core Views
  `ViewsBlock` deriver and appends `[Lazy Loaded]` to each derivative's category. So there is one
  lazy block per Views block display, alongside the stock ones.
- `build()` returns a `#theme => 'vallb'` render array (no view output yet) carrying the route
  params (`view`, `display_id`, `nojs => 'nojs'`) and the current request query as route options.
- Theme hook **`vallb`** — `vallb_theme()` in `vallb.module`; preprocess in `vallb.theme.inc`
  (`template_preprocess_vallb`) builds the endpoint `Url` and `data-vallb-*` attributes; template
  `templates/vallb.html.twig` renders a "Loading..." SVG placeholder and attaches library
  `vallb/lazy-builder`.
- Library **`vallb/lazy-builder`** (`vallb.libraries.yml`) → `js/lazy-load.js` (IntersectionObserver
  + `Drupal.ajax`, deps `core/drupal`, `core/once`, `core/drupal.ajax`) and `css/placeholder.css`.
- Route **`vallb.lazy_builder`** — `vallb.routing.yml`, path `/vallb/{view}/{display_id}/{nojs}`,
  `_controller: vallb.renderer:output`, access `_custom_access: vallb.renderer:checkOutputAccess`.
- Service **`vallb.renderer`** = `Drupal\vallb\Renderer` (`vallb.services.yml`), args
  `@entity_type.manager`, `@views.executable`. Implements `TrustedCallbackInterface`.
- Config schema only: `config/vallb.schema.yml` types `block.settings.vallb_block:*` as
  `views_block` (reuses core Views block settings). No `config/install`.
- Hook doc `vallb.api.php`: `hook_preprocess_vallb()` lets other modules inject view arguments
  (`route_options.query.vallb_views_arguments[]`) or preattach libraries.

## Access & data flow

- The Ajax route's access = `Renderer::checkOutputAccess` → `$view->access($display_id)`, i.e. the
  view display's own access plugin — the deferred render enforces the same access as inline Views.
- `Renderer::output()` forwards the request query: `vallb_views_arguments` become the view's
  contextual arguments; remaining query params become `setExposedInput()` (exposed filters).
  Returns an `AjaxResponse` with a `ReplaceCommand` when `nojs == 'ajax'`, else the render array.
