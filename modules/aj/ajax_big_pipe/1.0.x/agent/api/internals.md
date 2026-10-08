<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internals — placeholder strategy, `/api/bigpipe` endpoint, token, JS flow

End-to-end path for a block marked with `use_ajax_big_pipe`:

```
hook_block_build_alter  ->  #lazy_builder + #create_placeholder=TRUE
        ->  AjaxBigPipeStrategy::processPlaceholders (tagged placeholder_strategy)
        ->  <div data-ajax-placeholder="{callback,args,token}"> + loader + ajax_big_pipe/ajax lib
        ->  misc/ajax_big_pipe.js  IntersectionObserver  ->  Drupal.ajax GET /api/bigpipe
        ->  LoadAjaxBigPipe::get()  ->  renders lazy-builder  ->  ReplaceCommand / RemoveCommand
```

## Placeholder strategy — `placeholder_strategy.ajax_big_pipe`

`Drupal\ajax_big_pipe\Render\Placeholder\AjaxBigPipeStrategy` (args `@request_stack`, `@renderer`,
`@cache.data`). `processPlaceholders(array $placeholders): array` (`AjaxBigPipeStrategy.php:65`):

- Returns placeholders unchanged if the `big_pipe_nojs` cookie is present (`NOJS_COOKIE`).
- For each placeholder that is **not** attribute-safe (`placeholderIsAttributeSafe()` — i.e. an
  element placeholder, not one inside an HTML attribute) and whose `#lazy_builder[1]['params']`
  decodes to a config with `use_ajax_big_pipe`:
  - Strips `params` from the args, computes `$token = self::generateToken($callback, $args)`.
  - Replaces the render array with an `html_tag` `div` carrying
    `data-ajax-placeholder = Json::encode(['callback'=>…, 'args'=>…, 'token'=>…])` and
    `data-loading-distance = params['use_preview_height_distance']`, and attaches library
    `ajax_big_pipe/ajax` + `drupalSettings.ajaxBigPipe = Url::fromRoute('rest.load_ajax_big_pipe.GET')`
    (`/api/bigpipe`).
  - If `use_statis_preview`: renders the real builder once via `renderer->renderRoot()`, passes the
    HTML through `clearContent()` (rewrites `<a href>`→`javascript:void(0)` and drops `onclick`,
    deletes `<form>` and `<source>`, blanks `<img src>` to a 1×1 gif), and stores
    `['blockContent','libraries']` in `cache.data` under `ajax_big_pipe_<token>` (`Cache::PERMANENT`);
    subsequent requests read that snapshot. The snapshot becomes the placeholder body markup.
  - Else emits a loading skeleton chosen by `params['use_preview_templates']`
    (`views_template` / `block_template` / `banner_template` / `custom_template` /
    default spinner), custom markup taken from `params['use_preview_templates_custom']`.

`generateToken(string $callback, array $args): string` (`AjaxBigPipeStrategy.php:246`) —
`Crypt::hashBase64(serialize([$callback, $args, Settings::get('hash_salt')]))`. The site `hash_salt`
is the secret that binds the token; the same function is used to validate on the endpoint.

## REST endpoint — `LoadAjaxBigPipe` (`rest.load_ajax_big_pipe.GET`, `/api/bigpipe`)

`Drupal\ajax_big_pipe\Plugin\rest\resource\LoadAjaxBigPipe` (`#[RestResource(id: 'load_ajax_big_pipe',
uri_paths: ['canonical' => '/api/bigpipe'])]`). Enabled via
`config/install/rest.resource.load_ajax_big_pipe.yml` (`methods: [GET]`, `formats: [json]`,
`authentication: [cookie]`). `getBaseRouteRequirements($method)` returns `['_access' => 'TRUE']`, so
the route is public (no `restful get …` permission); the effective route also carries
`_csrf_request_header_token: 'TRUE'` (added for cookie auth) but that check is a no-op for the safe GET
method.

`get()` (`LoadAjaxBigPipe.php:156`) — query parameters:

| Param | Purpose |
|---|---|
| `callback` | The lazy-builder callable to render (must pass the token check **and** `is_callable`). |
| `args` | Array of args passed to the callback (part of the token). |
| `token` | Token from the placeholder; must equal `AjaxBigPipeStrategy::generateToken($callback,$args)`. |
| `destination` | Current page path; resolved via alias manager + inbound path processor and used to repopulate route-match parameters (loads `node`/`user`/`taxonomy_term`/`filter_entity` entities) so the builder renders in the right route context. |
| `ajax_page_state` | Copied into the request so already-loaded libraries/CSS are not re-sent. |

Behaviour:
- Returns an empty `ModifiedResourceResponse([], 200)` if the `big_pipe_nojs` cookie is set.
- `validateToken($callback,$args,$token)` compares `generateToken(...)  == $provided_token`; only if it
  matches **and** `is_callable($callback)` does it render
  `['#lazy_builder' => [$callback, $args], '#create_placeholder' => FALSE]` with `renderer->renderRoot()`.
- Returns an `AjaxResponse` (json): `ReplaceCommand(NULL, $html)` when there is markup (the JS fills in
  the `selector` as the placeholder element), or `RemoveCommand(NULL)` when empty; render attachments
  are forwarded via `$response->setAttachments()`. An invalid/missing token yields an empty response
  (no commands).

## Client JS — `ajax_big_pipe/ajax` (`misc/ajax_big_pipe.js`)

On `window load`, `once('ajax-bigpipe', '[data-ajax-placeholder]')` wires each placeholder to an
`IntersectionObserver` (rootMargin from `data-loading-distance`). On intersect it builds a
`Drupal.ajax({ url: drupalSettings.ajaxBigPipe, progress:false, submit: <parsed data-ajax-placeholder> })`,
forces method/type `GET`, sets `submit.destination` to `window.location.pathname` (+ search), and
`ajax.execute()`. Its custom `success` handler applies returned commands, defers `add_css` and the
`replaceWith` HTML so CSS lands before markup, re-runs `Drupal.attachBehaviors()`, and dispatches an
`ajaxBigPipeLoad` `CustomEvent` on `document.body` (hook this to react to fragments arriving).

## Supporting pieces

- `LazyBlockBuilder` (`ajax_big_pipe.lazy_block`) implements `TrustedCallbackInterface`; its
  `lazyBlockBuild(string $blockId)` returns `['#markup' => $blockId]` and is registered as a trusted
  callback. (Not referenced by the wired block path, which uses core `BlockViewBuilder::lazyBuilder`.)
- Config schema `condition.plugin.ajax_big_pipe` (`config/schema/…schema.yml`).
- Hooks: `hook_block_build_alter` (marks blocks), `hook_entity_presave` (cleans up a block's
  condition/deps when toggled off), `hook_help`; `hook_install`/`hook_uninstall` register/deregister
  the `ajax_big_pipe` Views display extender in `views.settings`.
