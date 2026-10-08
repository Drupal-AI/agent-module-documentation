<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Modern.Gov template page — route, tokens, variants, response subscriber

## The route and its controller "hack"

`localgov_moderngov.routing.yml`:

```yaml
localgov_moderngov.modern_gov:
  path: '/moderngov-template'
  defaults:
    _controller: json_decode
    _title: '{pagetitle}'
    json: '[]'
    assoc: 1
    depth: 2
    options: 3
  options:
    _no_big_pipe: TRUE
  requirements:
    _permission: 'access content'
```

There is no controller class. `_controller: json_decode` points the router at PHP's built-in
`json_decode`, and the extra `defaults` (`json`, `assoc`, `depth`, `options`) are passed as its
arguments by name where they match — the net effect is `json_decode('[]')` → an empty `array`, so the
controller returns an **empty render array**. All visible output therefore comes from the page
template, not the controller. The page `_title` is the literal string `{pagetitle}` (a Modern.Gov
token, not a real title). `_no_big_pipe: TRUE` disables BigPipe because the page is served to
anonymous Modern.Gov fetches, not interactive users. Access is core `access content` (the page
exposes only the site's own public page shell, by design consumed anonymously).

## The four tokens and the template

The page is rendered through the `page__moderngov_template` theme hook (registered by
`localgov_moderngov_theme()` with `'base hook' => 'page'`). The shipped example template
`templates/page--moderngov-template.html.twig` places four **literal placeholder tokens** where the
dynamic parts would normally be — Modern.Gov substitutes them on its side after fetching the page:

- `{pagetitle}` — replaces the real page title (set as `_title`).
- `{breadcrumb}` — hard-coded in the template's `.breadcrumb-wrapper` div (in place of
  `{{ page.breadcrumb }}`).
- `{content}` — hard-coded inside `<main>` (in place of `{{ page.content }}`).
- `{sidenav}` — hard-coded in the `aside.layout-sidebar-second` (in place of
  `{{ page.sidebar_second }}`).

Regions that are NOT tokenized (`page.header`, `page.primary_menu`, `page.secondary_menu`,
`page.highlighted`, `page.help`, `page.content_top`, `page.footer`) render normally. To adapt this to
a real theme, copy `page--moderngov-template.html.twig` into your theme and reposition the four
tokens; the module's example intentionally uses `stark`/`olivero`-style markup.

On this route, `localgov_moderngov_preprocess_html()` adds the body class
`page--moderngov-template` (`Constants::PAGE_BODY_CLASS`), keyed off
`current_route_match` == `localgov_moderngov.modern_gov`.

## Response post-processing (`HtmlResponseSubscriber::onRespond`, priority -10)

The subscriber runs on `KernelEvents::RESPONSE` and returns immediately unless the response is an
`HtmlResponse` AND `_route === 'localgov_moderngov.modern_gov'`. Priority -10 is chosen so the route
is known (needs ≤ 31) and headers are still mutable (needs ≤ 0). Steps:

1. `transformRootRelativeUrlsToAbsolute($dom, $request->getSchemeAndHttpHost())` — for the URI
   attributes `href, poster, src, cite, data, action, formaction, srcset, about`, any value starting
   with `/` (but not `//`) is prefixed with the request's scheme+host, making it absolute (a
   Modern.Gov requirement). `srcset` candidate strings are handled individually. This mirrors core
   `Html::transformRootRelativeUrlsToAbsolute()` but processes the whole `<html>` document, not just
   the body. Note: relative URLs inside inline `<script>`/JS are NOT rewritten.
2. If the `nocontent` query key is present → `emptyContent()` removes all children of the first
   **visible** (`:not([hidden])`) `<main>` element.
3. Then exactly one of:
   - `header` query key present → `HeaderFooterExtraction::prepareHeader()`
   - else `footer` query key present → `HeaderFooterExtraction::prepareFooter()`
   - else the full (absolute-URL) document is re-serialized.
4. `$response->setContent($resultant_html)`.

Presence of the query key is what matters (`!is_null($request->get(...))`); the value is ignored, so
`?header`, `?header=1`, `?header=anything` all trigger it.

## Query-parameter variants

- `/moderngov-template` — full page shell with the four tokens, absolute URLs.
- `/moderngov-template?nocontent` — same, but the first visible `<main>` is emptied (Modern.Gov
  "empty" template).
- `/moderngov-template?header` — returns only: a `<div class="scripts-n-links">` of head
  `<script>` and `<link rel="stylesheet">`, then a `<div class="pre-header-body-scripts">` of body
  scripts that appear before `<header>`, then the first `<header>` and its children.
- `/moderngov-template?footer` — returns only: the first `<footer>` and its children, then a
  `<div class="post-footer-body-scripts">` of body scripts that follow `<footer>`.

Known limitation (per class `@todo`): only the FIRST `<header>`/`<footer>`/visible `<main>` is
processed if a page has several.

## HeaderFooterExtraction (all static, `src/HeaderFooterExtraction.php`)

- `prepareHeader(\DOMDocument): string` — head scripts/styles + pre-header scripts + first `<header>`.
- `prepareFooter(\DOMDocument): string` — first `<footer>` + post-footer scripts.
- `extractHeadScriptsAndStyles($dom, $xpath)` — xpath
  `/html/head/script|/html/head/link[@rel="stylesheet"]`, wrapped in `div.scripts-n-links`.
- `extractPreHeaderScripts($dom, $xpath)` — xpath `/html/body//script[following::header]`, wrapped in
  `div.pre-header-body-scripts`.
- `extractPostFooterScripts($dom, $xpath)` — xpath `/html/body//script[preceding::footer]`, wrapped
  in `div.post-footer-body-scripts`.
- `extractMarkup(...)`, `createEmptyDiv(...)`, `toHtml(...)` — DOM helpers.

## Changing the served path

The path is fixed to `/moderngov-template` in routing. To serve it elsewhere, add a URL alias
pointing at `/moderngov-template` (per README) — the route itself is not configurable.
