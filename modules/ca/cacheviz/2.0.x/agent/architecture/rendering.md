<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cacheviz — how it hooks rendering (from source)

Two server-side pieces produce the data; the browser does the visualization.

## 1. Renderer decorator — element-level comments

`Drupal\cacheviz\Renderer` (`src/Renderer.php`) is registered as `cacheviz.renderer` with
`decorates: renderer`, `parent: renderer`, extending core `Drupal\Core\Render\Renderer`. Setter-injection
wires it up (`services.yml` `calls:`): `setCacheContextManager` (`@cache_contexts_manager`),
`setConfigFactory`, `setCurrentUser`, `setPathMatcher` (`@cacheviz.path_matcher`).

It overrides `doRender(array &$elements, RenderContext $context)` (matching core's real signature — verified
against `core/lib/Drupal/Core/Render/Renderer.php`). Flow:

1. Capture `$original_cache = $elements['#cache'] ?? []`, then call `parent::doRender()` to get the real markup.
2. Early-out via `shouldProcessRequest()` (enabled + `view cacheviz debug` + path not excluded; cached per
   request in `$this->shouldProcess`).
3. Skip empty output and skip plain-text output (`$result === strip_tags($result)`) — comments are only injected
   into markup that already contains HTML.
4. Build `pre_bubbling` metadata (`tags`, `max-age` default `Cache::PERMANENT`; when `#cache['keys']` is set,
   merges `required_cache_contexts` from `$this->rendererConfig`) and `final` metadata from `$elements['#cache']`.
   If contexts exist, resolves `context_keys` via `cacheContextManager->convertTokensToKeys($contexts)->getKeys()`.
5. Only if there is "interesting" cache data (`keys`/`contexts`/`tags`/`max-age`), wrap:

   ```
   <!--CACHEVIZ_START--><!--{json}--><!--CACHEVIZ_END-->
   ```

   where `{json}` = `htmlspecialchars(Json::encode(['final'=>…, 'pre_bubbling'=>…, 'context_keys'=>…]), ENT_NOQUOTES)`.
   The result is assigned back to `$elements['#markup'] = Markup::create($wrapped)` and returned.

`htmlspecialchars` always escapes `<`, `>`, `&` (the `ENT_NOQUOTES` flag only leaves quotes alone, which are
irrelevant inside an HTML comment), so the JSON payload cannot terminate the comment or the surrounding markup.

## 2. Response subscriber — page-level settings + asset injection

`Drupal\cacheviz\EventSubscriber\ResponseSubscriber` (`src/EventSubscriber/ResponseSubscriber.php`,
`final readonly`) subscribes to `KernelEvents::RESPONSE` at priority `-100`. In `onResponse()`:

- Runs `shouldProcess()` (same three-way gate as the renderer). Only acts on non-empty `text/html` responses.
- Reads page cache metadata from the `X-Drupal-Cache-Tags`, `X-Drupal-Cache-Contexts` and
  `X-Drupal-Cache-Max-Age` response headers (max-age parsed with `preg_match('/^(-?\d+)/', …)` to strip the
  `"0 (Uncacheable)"` suffix; default `-1`).
- Builds `drupalSettings.cacheviz.page` (`tags`, `contexts`, `maxAge`) + `autoHighlight` and injects it as a
  `<script type="application/json" data-drupal-selector="drupal-settings-json-cacheviz">` before `</head>`.
- Also injects `<link>`/`<script>` tags for `css/cacheviz.panel.css`, `css/cacheviz.highlight.css`,
  `js/cacheviz.comments.js`, `js/cacheviz.js`. URLs come from `file_url_generator->generateString()` plus a
  `?v=<filemtime>` cache-buster (`generateAssetUrl()`); the module path is resolved via
  `extension.path.resolver`. These assets are injected manually — the module ships no `*.libraries.yml`.

## 3. Client-side (assets)

- `js/cacheviz.comments.js` → `window.CachevizComments.parse()`: walks `SHOW_COMMENT` nodes with a stack to pair
  `CACHEVIZ_START`/`CACHEVIZ_END`, `JSON.parse`s the decoded metadata comment, and associates it with the DOM
  element found between the markers.
- `js/cacheviz.js`: `CacheAnalyzer` computes stats and groups issues (uncacheable / per-user / session / cookie
  contexts; builds the `buildBubbleChain()` / `findRootCause()` DOM walk). `CachevizUI` renders the floating
  panel (Overview / Issues / Elements), highlights elements by severity, and exposes a `window.cacheviz` console
  API. All dynamic strings (selectors, contexts, tags, raw JSON) are passed through `utils.escapeHtml()` (a
  `div.textContent` round-trip) before being inserted into `innerHTML`. Panel state persists in `localStorage`
  (`cacheviz_state`). Keyboard: `Ctrl+Shift+C` toggles the panel, `Ctrl+Shift+H` toggles highlights.

## 4. Path matcher

`Drupal\cacheviz\PathMatcher` (`src/PathMatcher.php`, `final readonly`): `isCurrentPathExcluded()` feeds
`path.current`'s path plus the `excluded_paths` config string into core `path.matcher->matchPath()`. Empty
config → nothing excluded.

## Not present

No `hook_*` (`.module` absent), no `.install`/schema, no entities, no plugins, no Drush, no queue/cron, no
outbound HTTP. The renderer decorator and the response subscriber are the entire server surface.
