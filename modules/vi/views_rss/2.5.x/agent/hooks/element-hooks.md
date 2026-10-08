<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `views_rss_*` element hooks

This is the module's entire extension API. Every RSS element the style/row plugins can offer
comes from another module (core or contrib) implementing these hooks — the 5 bundled
submodules are just the first implementors. Discovery happens in `views_rss_get($key)`
(`views_rss.module`): it calls `hook_views_rss_<key>()` on every implementing module, caches
the merged result **indefinitely** in the `data` cache bin under `views_rss:<key>`, and runs
`hook_views_rss_<key>_alter(&$data)` afterwards. Clear with `drush cr` after changing hook
implementations.

## `hook_views_rss_namespaces()`

Returns `[$namespace_prefix => ['prefix' => 'xmlns', 'uri' => '...']]`, e.g.
`views_rss_dc_views_rss_namespaces()` returns `['dc' => ['prefix' => 'xmlns', 'uri' =>
'http://purl.org/dc/elements/1.1/']]`. Namespaces referenced by a channel/item element but not
explicitly declared here are auto-added with `prefix: xmlns` and a blank URI the site admin
must fill in (Namespaces fieldset on the style options form).

## `hook_views_rss_channel_elements()` / `hook_views_rss_item_elements()`

Return `[$element_key => $definition]`. `$element_key` is `<name>` for the `core` namespace or
`<namespace>:<name>` otherwise (e.g. `dc:creator`, `media:content`, `atom:link`). Definition
array keys, all optional except none are required:

| Key | Effect |
|---|---|
| `configurable` | `FALSE` hides it from the options form (still processed) — used for `title`/`link` on the channel (hardcoded via Views' own title/URL). |
| `description` | Help text shown under the form field. |
| `default_value` | Value used when the admin leaves the field blank (channel elements only). |
| `preprocess functions` | Ordered list of `function(&$variables)` callbacks run on the element's render array (`$variables['elements']`, `['item']`, `['view']`, and `['raw']` for item elements sourced from a raw field value) before it's handed to the renderer/twig. Can replace one element with several (e.g. splitting a comma-separated `category` into multiple `<category>` tags). |
| `settings form` | Override array merged into the default `textfield` (channel) / `select` (item) form element, e.g. `['#type' => 'textarea', '#rows' => 3]`. |
| `settings form options callback` | Callable returning `#options` for a `select`. |
| `group` | Nests the element under a sub-fieldset/details element on the form; the group's title/description come from `hook_views_rss_element_groups()` if implemented (no bundled submodule currently implements this hook). |
| `cdata` | (item elements) Wrap the rendered value in `<![CDATA[ ]]>` in the twig template. |
| `help` | URL appended as a `[?]` link on the form. |

## Alter hooks

`hook_views_rss_namespaces_alter()`, `hook_views_rss_channel_elements_alter()`,
`hook_views_rss_item_elements_alter()`, `hook_views_rss_date_sources_alter()` — run after all
`hook_views_rss_<key>()` implementations are merged, receive `&$data` by reference. This is how
`views_rss_media_getid3` adds extra preprocess functions to `views_rss_media`'s already-defined
`media:content`/`media:thumbnail` elements without redefining them:
```php
function views_rss_media_getid3_views_rss_item_elements_alter(&$elements) {
  $elements['views_rss_media']['media:content']['preprocess functions'][] = 'views_rss_media_getid3_preprocess_media_content';
  $elements['views_rss_media']['media:thumbnail']['preprocess functions'][] = 'views_rss_media_getid3_preprocess_media_thumbnail';
}
```

## `hook_views_rss_date_sources()`

Returns `[$views_base_table => ['lastBuildDate' => ['table' => ..., 'field' => ...]]]`, used by
`views_rss_core_views_query_alter()` to add the correct "changed" field alias to the View's
query so the channel `<lastBuildDate>` can be derived from it (only fires when the View's style
plugin id is `rss_fields`).

## Form + row lifecycle hooks

- `hook_views_rss_options_form_validate($form, $form_state)` / `_submit(...)` — run from the
  style plugin's own `validateOptionsForm()`/`submitOptionsForm()`. `views_rss_core` uses
  validate to check the channel `<image>` path/size and `<docs>` URL.
- `hook_views_rss_preprocess_item(&$item_variables)` — run once per row, before individual
  element preprocess functions, from the row plugin's `render()`. No bundled submodule
  implements it, but it's the right place for whole-item transforms.

## Practical grounding

`views_rss_get('channel_elements')` / `('item_elements')` / `('namespaces')` return arrays
keyed by the **implementing module's machine name** (`views_rss_core`, `views_rss_dc`, ...) —
that module name is also the key used in both the config schema
(`views.style.rss_fields`/`views.row.views_rss_fields`) and the live View option path, e.g.
`style.options.channel.core.views_rss_core.description` or
`row.options.item.dc.views_rss_dc.creator`.
