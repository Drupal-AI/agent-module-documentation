<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# vallb — lazy block, Ajax route, controller, JS, theming

## Install / enable

`drush en vallb` (or `ddev drush en vallb`). Requires `views`. No config form, no permissions of
its own, nothing to configure in settings. It simply adds new block plugin derivatives.

## Place the block

- In **Block layout** (or Layout Builder), place the block whose admin label carries the
  `[Lazy Loaded]` category suffix instead of the stock Views block. The suffix is added by
  `ViewsLazyBuiltBlock::getDerivativeDefinitions()` (`src/Plugin/Derivative/ViewsLazyBuiltBlock.php`).
- Every Views **block** display gets a `vallb_block:<view>-<display>` derivative, mirroring core's
  `views_block:*`. Block settings reuse the core `views_block` schema
  (`config/vallb.schema.yml` → `block.settings.vallb_block:*: { type: views_block }`), so items-
  per-page / more-link / etc. behave as usual.

## What the block renders (`src/Plugin/Block/ViewsLazyBuiltBlock.php`)

`ViewsLazyBuiltBlock extends ViewsBlock`. `build()` does NOT render the view. It returns:

```
[
  '#theme' => 'vallb',
  '#ajax_identifier' => "<view_id>:<display_id>",
  '#route_parameters' => ['view' => <view_id>, 'display_id' => <display_id>, 'nojs' => 'nojs'],
  '#route_options' => ['query' => <current request query> + ['vallb_views_arguments' => []]],
  '#route_name' => 'vallb.lazy_builder',
  '#view' => $this->view,
  '#view_display_id' => $this->displayID,
]
```

The current page's query string is copied into `route_options.query` so exposed filters and page
args survive into the deferred Ajax call.

## Theme + placeholder (`vallb.module`, `vallb.theme.inc`, `templates/vallb.html.twig`)

- `vallb_theme()` registers theme hook `vallb` with variables `ajax_identifier`, `route_name`
  (default `vallb.lazy_builder`), `route_parameters`, `route_options`, `view`, `view_display_id`,
  `loading_message` (default `t('Loading...')`); implementation file `vallb.theme.inc`.
- `template_preprocess_vallb()` computes `endpoint = Url::fromRoute(route_name, route_parameters,
  route_options)`, and when `route_options.query.vallb_views_arguments` is set appends
  `':' . Crypt::hashBase64(serialize(args))` to `ajax_identifier`. It builds:
  - `attributes`: `data-vallb-container=<ajax_identifier>`, `data-vallb-endpoint=<endpoint URL>`.
  - `placeholder_attributes`: `data-vallb-container-placeholder=TRUE`.
- `vallb.html.twig` renders only when `ajax_identifier and endpoint`: attaches library
  `vallb/lazy-builder`, emits `<div{{attributes}}>` containing the placeholder div with an inline
  bar-chart SVG and `{{ loading_message }}`. Restyle via `css/placeholder.css`.

## Client behaviour (`js/lazy-load.js`, library `vallb/lazy-builder`)

- `Drupal.behaviors.vallb` uses `once('data-vallb-container-initialized', '[data-vallb-container]')`
  and registers each container with a single `IntersectionObserver`.
- On intersection it calls `Drupal.ajax({ url: target.dataset.vallbEndpoint }).execute()` then
  `unobserve()`s the target — each block fetches exactly once, when first visible.
- Library deps: `core/drupal`, `core/once`, `core/drupal.ajax`.

## The Ajax route + controller (`vallb.routing.yml`, `src/Renderer.php`)

- Route `vallb.lazy_builder`, path `/vallb/{view}/{display_id}/{nojs}`; `{view}` is upcast to a
  `view` config entity (`entity:view`). `_controller: vallb.renderer:output`,
  `_custom_access: vallb.renderer:checkOutputAccess`.
- Service `vallb.renderer` = `Drupal\vallb\Renderer` (`ControllerBase`, `TrustedCallbackInterface`;
  `trustedCallbacks()` returns `['output']`). Constructed with `@entity_type.manager` (→ `view`
  storage) and `@views.executable` (`ViewExecutableFactory`).
- `checkOutputAccess(ViewEntityInterface $view, string $display_id)`: builds the executable and
  returns `$view->access($display_id) ? allowed() : forbidden()`. **Access is the view display's
  own access plugin** — same gate as the inline Views block; the lazy path does not widen access.
- `output(ViewEntityInterface $view, string $display_id, string $nojs = 'nojs')`:
  1. reads `request->query->all()`;
  2. if `vallb_views_arguments` present → used as the view's contextual `$args`, and a DOM
     `$selector` is built as `[data-vallb-container='<id>:<display>:<hash>'] [data-vallb-container-placeholder]`
     (hash = `Crypt::hashBase64(serialize(args))`); else selector without the hash;
  3. remaining query → `$view->setExposedInput($query)`;
  4. `$output = $view->buildRenderable($display_id, $args, FALSE)`; `addContextualLinks()` sets
     `#view_id`, admin-links flags and calls `views_add_contextual_links()`; then
     `View::preRenderViewElement($output)`;
  5. if `view_build` empty → returns just `['#cache' => ...]` so emptiness caches correctly;
  6. if `$nojs == 'ajax'` → `AjaxResponse` with `ReplaceCommand($selector, $output)`; otherwise the
     bare render array (direct/no-JS hit).

## Extension point (`vallb.api.php`)

`hook_preprocess_vallb(array &$variables)` runs via the theme preprocess chain. Use it to:

- inject a contextual argument, e.g. push a taxonomy term id onto
  `$variables['route_options']['query']['vallb_views_arguments'][]`, then update
  `ajax_identifier` and `attributes['data-vallb-container']` to keep the selector hash in sync
  (see the example in `vallb.api.php`); or
- preattach libraries the lazy block will need via `$variables['#attached']['library'][]` (e.g.
  charts libraries) so they are present before the Ajax content arrives.

## Notes for operating it

- The block emits nothing (empty render) unless both `ajax_identifier` and `endpoint` are set.
- Multiple instances of the same view/display on one page are disambiguated by the
  `vallb_views_arguments` hash in `data-vallb-container` / the replace selector.
- No BigPipe requirement; this is a plain Ajax replace, so it works where core lazy-load
  (BigPipe-dependent) is unavailable.
