<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block & visibility condition

The module implements two core plugin types (it defines no new plugin type of its own).

## Block plugin — `childfocus_notfound`

`Drupal\childfocus_notfound\Plugin\Block\ChildfocusNotfound` (annotation
`@Block(id="childfocus_notfound", admin_label="Childfocus (notfound.org)")`).

`build()` renders a single `<iframe>` embedding the notfound.org 404 widget:

- Reads `childfocus_notfound.settings`: `key` and `fallback_langcode`.
- Locale map (hard-coded): current UI langcode `en`→`en-BE`, `fr`→`fr-BE`, `nl`→`nl-BE`;
  anything else falls back to the `en-BE`/`fr-BE`/`nl-BE` for `fallback_langcode`.
- Builds `https://notfound-static.fwebservices.be/<locale>/404?key=<key>` (HTTPS; fixed host).
  This is a browser-side iframe embed — the visitor's browser loads the widget, the Drupal server
  does not fetch it.
- Returns `#markup` (a `Markup` object) with `#cache['contexts'] = ['languages:language_interface']`.
  The iframe is fixed `width="100%" height="650"`, `frameborder="0"`, titled "Child focus not found".

The block does not read, reflect, or embed the requested URL/path or any query string — its output
depends only on config and the current interface language.

Place the block anywhere via **Structure → Block layout**; admin label "Childfocus (notfound.org)".
To restrict it to 404 responses, enable the visibility condition below.

## Visibility condition — `childfocus_notfound` ("Show in page not found")

`Drupal\childfocus_notfound\Plugin\Condition\ChildfocusPageNotFound` (annotation
`@Condition(id="childfocus_notfound", label="Childfocus (notfound.org)")`). Appears in every
block's visibility tab as "Childfocus (notfound.org)" with a **Show in page not found** checkbox
(config key `show_on_page_not_found`).

`evaluate()` logic:

- If `show_on_page_not_found` is empty (unchecked) and the condition is not negated → returns TRUE
  (does not restrict — the block shows everywhere).
- If checked → returns TRUE only when the current request's `exception` attribute is a 404
  (`$request->attributes->get('exception')->getStatusCode() === 404`).
- Adds cache context `url.path` (via `getCacheContexts()`).

## Auto-placed block on install

`childfocus_notfound_install()` (in `childfocus_notfound.install`) creates a `block` config entity
so the feature works out of the box:

| Property | Value |
|----------|-------|
| `id` | `childfocus_notfound` |
| `plugin` | `childfocus_notfound` |
| `region` | `content` |
| `theme` | `system.theme` default theme |
| `settings.label_label` | `'0'` (hide label) |
| `visibility.childfocus_notfound` | `show_on_page_not_found: TRUE`, `negate: false` |
| `weight` | `100` |

So after install the block is live in the default theme's `content` region, shown only on 404
pages. Uninstalling does not automatically remove a manually re-placed block; the install-created
one is standard block config you can edit or delete in Block layout.
