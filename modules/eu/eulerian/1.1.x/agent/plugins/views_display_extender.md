<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views display extender: Eulerian search keys

## Plugin

`src/Plugin/views/display_extender/Eulerian.php`, attribute `#[ViewsDisplayExtender(id: 'eulerian',
title: 'Eulerian', help: 'Send data to Eulerian when search happens.', no_ui: FALSE)]`, extends
`DisplayExtenderPluginBase`. Registered into `views.settings:display_extenders` by
`eulerian_install()` and removed by `eulerian_uninstall()`; so after install it is available on
every view's settings.

## Options (`defineOptions()` / config schema `views.display_extender.eulerian`)

| Option | Default | Meaning |
|---|---|---|
| `enabled` | `false` | Send search data to Eulerian for this display. |
| `keys` | `''` | Comma-separated GET parameter names to read as search keys (**order matters**). |
| `facets` | `[]` | Search API facet IDs to use as search keys (only when the view uses a Search API query and the `facets` module is present). |
| `concat_separator` | `,` | Separator used when a GET value or facet has multiple active values. |

`buildOptionsForm()` renders these under the view's "Eulerian" section (a checkbox, a
"Search keys → GET parameters" textfield, an optional "Facets" checkboxes group when the query is a
`SearchApiQuery` and `facets.manager` exists, and the separator field). `optionsSummary()` shows
Yes/No on the display summary.

## Runtime (`HookHandler\ViewsPostRenderHookHandler::process()`)

Invoked from `Hook\EulerianHooks::viewsPostRender()` (`#[Hook('views_post_render')]`, delegated via
the class resolver). For a display that has the `eulerian` extender **enabled** and a non-empty
exposed input, it sets:

```php
$output['#attached']['drupalSettings']['eulerian']['datalayer'] = [
  'isearchengine'  => $view->storage->label(),
  'isearchkeys'    => getSearchKeys() + getSearchKeysFromFacets(),
  'isearchresults' => $view->total_rows ?? count($view->result),
];
```

- `getSearchKeys()` — for each configured `keys` GET parameter present in the request, takes its
  value (arrays imploded with `concat_separator`) into an `id => value` map.
- `getSearchKeysFromFacets()` — when the view uses a `SearchApiQuery` and `facets.manager` is
  available, resolves the facets for the query's Search API source id and, for each selected facet
  with active items, adds `facetId => implode(separator, activeItems)`.

The resulting `isearchkeys` object is later expanded client-side by `EA_prepare2Push()` into
Eulerian `isearchkey`/`isearchdata` pairs (see [../api/datalayer.md](../api/datalayer.md)). Facet
support is optional: `facets.manager` is injected with `NULL_ON_INVALID_REFERENCE`, so the plugin
and handler work without the `facets`/`search_api` modules (facet features simply do nothing).

## Enable on a view

Edit a view → in *Other* / advanced settings open the **Eulerian** section → check "Send search
data to Eulerian", list the GET parameters (e.g. `search_api_fulltext`), optionally tick facets and
set the separator → save. The datalayer is populated only when the display's exposed form has been
submitted (a real search).
