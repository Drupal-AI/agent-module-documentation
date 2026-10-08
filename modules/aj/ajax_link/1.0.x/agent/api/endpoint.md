<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax link — endpoint, JS behavior, and markup contract

Everything about ajax_link lives in three files: `ajax_link.routing.yml`, `js/ajax-link.js`, and
`src/Controller/AjaxLink.php`. There is no config, no admin form, no permissions of its own.

## Install / enable

`drush en ajax_link -y`. Requires the `symfony/css-selector` Composer package (pulled in via
`composer require drupal/ajax_link`). Nothing else to set up.

## Wiring it into a page

1. Attach the library where you want AJAX links to work:
   - PHP preprocess: `$variables['#attached']['library'][] = 'ajax_link/ajaxLink';`
   - Twig: `{{ attach_library('ajax_link/ajaxLink') }}`
2. Mark the link and give it a target selector:
   ```html
   <a href="{{ url }}" class="ajax-link" data-ajax-link-selector=".products-list">Next</a>
   ```
   Clicking it loads the content of `{{ url }}` matching `.products-list` and replaces the
   `.products-list` region on the current page.

## Markup contract (classes + data attributes)

Classes on the `<a>`:
- `ajax-link` — **required.** Marks the link as an AJAX link.
- `ajax-link-auto` — optional. Auto-clicks the link when it scrolls into the viewport (drives
  infinite scroll). A `window.scroll` listener is registered once the first auto link is found.
- `ajax-link-hidden` — optional. Hides the link (CSS: `width/height:0; overflow:hidden`). Combine with
  `ajax-link-auto`.

Data attributes (read from the link, or from a wrapping `.ajax-links-wrapper`):
- `data-ajax-link-selector` — **required.** CSS selector of the region to read from the fetched page
  and to replace/append into. If empty/undefined, JS adds `ajax-link-wrapper` to the link's parent and
  uses `.ajax-link-wrapper`.
- `data-ajax-link-method` — `replace` (default) or `append`. Any other value → nothing happens.
- `data-ajax-link-history` — `1` to `window.history.pushState` the clicked path (browser URL reflects
  the click). Default `0`.
- `data-ajax-link-remove-after-execution` — default true (link is removed after firing so it can't be
  reused). Set `false` to keep the link clickable; JS then resets its `ajax-link-executed` flag each
  time.

Grouping: wrap several links in an element with class `ajax-links-wrapper` to apply one set of
`data-*` settings to every `<a>` inside it (see the second `once('ajaxlink', '.ajax-links-wrapper', …)`
loop in `js/ajax-link.js`).

## The endpoint

Route `ajax_link.ajax` (`ajax_link.routing.yml`):
- Path `/ajax/ajax_link`, controller `\Drupal\ajax_link\Controller\AjaxLink::ajax`, requirement
  `_permission: 'access content'`.
- Query params: `path` (the link href), `selector` (CSS selector), `method` (`replace`|`append`).
- The `@todo` in the controller notes AJAX calls currently go through POST, so the response is not
  cached (see drupal.org issue 2701085).

`AjaxLink::ajax(Request $request)` (`src/Controller/AjaxLink.php`), constructed with `http_kernel`
and `request_stack` via `create()`:
1. Reads `path`, `selector`, `method` from the query.
2. `preg_replace('/^https?:\/\/[^\/]+\/(.*)/', '/$1', $requestPath)` strips a leading scheme+host,
   keeping the path only; `parse_url($path, PHP_URL_QUERY)` extracts its query string.
3. Overrides `REQUEST_URI`/`QUERY_STRING` in the server bag, then
   `Request::create($path, $request->getMethod(), [], $currentRequest->cookies->all(),
   $currentRequest->files->all(), $server)` and dispatches it as
   `HttpKernelInterface::SUB_REQUEST` through `http_kernel->handle(...)`. Because it reuses the current
   request's cookies and runs as a subrequest, the target page is rendered **in the current user's own
   session/access context** — the fetched content enforces its normal access; the endpoint is a
   fragment extractor, not a privilege boundary.
4. Loads the rendered HTML into `DOMDocument` (`LIBXML_NOERROR`), converts `selector` to XPath with
   `CssSelectorConverter::toXPath` and queries `//$xpathQuery`. If nothing matches, it falls back to
   the parent of `a.ajax-link`.
5. Builds an `AjaxResponse`:
   - `replace` → `ReplaceCommand($selector, $dom->saveHTML($element))`.
   - `append` → serializes the element's child nodes, then `RemoveCommand('a.ajax-link')` +
     `AppendCommand($selector, $html)`.

## Operating notes

- The `selector` used in the returned `ReplaceCommand`/`AppendCommand` is the client-side jQuery
  target; the same selector value is what the server uses to pick the fragment from the fetched page —
  so the source region and destination region share one selector.
- After a successful load the JS re-runs `Drupal.attachBehaviors` on the replaced/appended wrapper, so
  behaviors on newly loaded content initialize.
- No caching (POST); expect a subrequest render cost per click.
- Links degrade gracefully without JS: `href` is a real navigable URL.
