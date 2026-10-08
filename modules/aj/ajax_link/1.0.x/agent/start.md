<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax link (ajax_link) — agent index

Themer/developer helper that turns a marked `<a>` into an AJAX link: clicking it fetches the linked
route, extracts the markup matching a CSS selector, and **replaces or appends** that fragment into the
page instead of a full navigation. Can act as **infinite scroll**. Package **User interface**. Core
`^8 || ^9 || ^10 || ^11 || ^12`. License GPL-2.0-or-later. Version **1.0.6**.

- **The endpoint, the JS behavior, every class/data-attribute, and how to wire it up** →
  [api/endpoint.md](api/endpoint.md)

## What it actually is

- **No entities, no plugins, no config, no permissions, no Drush, no hooks, no admin UI.** Nothing to
  configure in the database — behavior is driven entirely by CSS classes and `data-*` attributes on
  your links plus attaching one library.
- **One route** `ajax_link.ajax` → `GET|POST /ajax/ajax_link`, controller
  `\Drupal\ajax_link\Controller\AjaxLink::ajax` (`src/Controller/AjaxLink.php`), requirement
  `_permission: 'access content'`.
- **One library** `ajax_link/ajaxLink` (`ajax_link.libraries.yml`): `js/ajax-link.js` +
  `css/ajax-link.css`, depending on `core/jquery`, `core/drupal.ajax`, `core/once`.
- **Composer:** requires `symfony/css-selector` (used server-side to convert the CSS selector to XPath).

## Mechanism (from source)

- **Client** (`js/ajax-link.js`, `Drupal.behaviors.ajaxLink`): on click of `a.ajax-link` it reads
  `data-ajax-link-selector` / `-method` / `-history`, builds
  `ajax/ajax_link?path=<encodeURI(href)>&selector=<encodeURIComponent(selector)>&method=<method>`,
  and runs it through `Drupal.ajax`. On success it optionally `history.pushState`s and re-runs
  `Drupal.attachBehaviors` on the new content. `a.ajax-link-auto` links auto-fire when scrolled into
  the viewport (infinite scroll); `ajax-link-hidden` hides the link via CSS.
- **Server** (`AjaxLink::ajax(Request $request)`): reads `path`, `selector`, `method` query params;
  strips any `http(s)://host` prefix from `path` with a regex; builds a **`SUB_REQUEST`** via
  `http_kernel->handle(...)` reusing the current request's cookies/files — so the target page is
  re-rendered **in the current user's own session and access context**. It parses the rendered HTML
  with `DOMDocument`/`DOMXPath`, selects the node(s) matching the selector (converted by
  `Symfony\Component\CssSelector\CssSelectorConverter::toXPath`), and returns an `AjaxResponse` with a
  `ReplaceCommand` (method `replace`) or `RemoveCommand('a.ajax-link')` + `AppendCommand` (method
  `append`). Falls back to the ajax link's parent element when the selector matches nothing.
