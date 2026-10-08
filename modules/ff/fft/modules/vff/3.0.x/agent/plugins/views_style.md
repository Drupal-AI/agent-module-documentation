<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "View Formatter Template" Views style (`views_formatter_template`)

## Install & enable

```bash
drush en vff -y
```

Enables the parent `fft` and requires core `views`. There is no vff config — it reuses FFT's
template directory (`fft.settings:fft_storage_dir`, set at `/admin/config/content/fft`). Author
templates in that directory whose filename starts with **`views`** and that contain a
`{# Template Name: … #}` header.

## Selecting the style

Edit a View → *Format* → **View Formatter Template**. The style is `ViewFormatterTemplate`
(`src/Plugin/views/style/ViewFormatterTemplate.php`), id **`views_formatter_template`**, extending
core `StylePluginBase` with `usesRowPlugin = TRUE`, `usesRowClass = TRUE`, `usesGrouping = FALSE`.

## Style options (`defineOptions()` / `buildOptionsForm()`)

| Option | Default | Meaning |
|---|---|---|
| `template` | `''` | Template file to render, from `fft_get_templates('views')` (filename starts with `views`, has a `{# Template Name: … #}` header). |
| `render_type` | `'raw'` | `raw` = pass `getRenderedFields()` (rendered field markup per row); `styled` = pass the raw row render arrays. The form shows a `<pre>` list of available field ids (from `getFieldLabels()`) when `raw`. |
| `vff_clean_template` | `''` | When checked, `vff_theme_suggestions_alter()` adds the `views_view__vff` suggestion so the outer wrapper (`views-view--vff.html.twig`) drops the default `view-id`/`view-content` wrapper divs. |
| `vff_tree_field` | `''` | Field id used as the node id when building a tree (only offered when the display has fields). |
| `vff_tree_parent_field` | `''` | Field id used as the parent id when building a tree. |
| `show_empty` | `''` | Render the template even when the View has no rows (`evenEmpty()` returns TRUE). |

There is no config schema for these options.

## Preprocessing and what the template receives

`template_preprocess_views_formatter_template()` in `vff.theme.inc` resolves the template as
`fft_storage_dir() . '/' . $options['template']` and calls the parent module's `fft_render()`,
setting `$variables['template_rendered']`. The wrapper template
`templates/views-formatter-template.html.twig` then emits `{{ template_rendered | raw }}`.

Variables handed to the selected template:

- **`data`** — the row data:
  - `render_type = raw` → `$style->getRenderedFields()`: an array of rows, each an associative
    array keyed by **field id** with the rendered field markup as value. In Twig-debug mode the
    preprocessor casts each `MarkupInterface` field to string and strips HTML comments.
  - `render_type = styled` → the raw `rows` render arrays (as passed to the style template).
  - **tree**: when both `vff_tree_field` and `vff_tree_parent_field` are set, `vff_build_tree()`
    rebuilds the flat rendered rows into a nested structure — each node gains a `childNodes` array
    keyed by child id, rooted at the row whose parent id is empty. Useful for taxonomy/menu trees.
- **`view`** — the `ViewExecutable` (present in the raw/styled non-tree paths).
- **`langcode`**, **`langcode_content`**, **`langcode_interface`** — current language ids.
- **`_variables`** — the full preprocess variables array.

In Twig-debug mode the final rendered string also has HTML comments stripped.

## `vff_build_tree()` (in `vff.theme.inc`)

Flat-array → tree helper. Signature `vff_build_tree(array $flat, $idField = 'id',
$parentIdField = 'parentId', $childNodesField = 'childNodes')`. It appends a synthetic root
(id `0`, parent `NULL`), indexes rows by id, then links each row into its parent's `childNodes`,
returning the root's children. vff passes the chosen field ids as `$idField`/`$parentIdField`.

## Example template

```twig
{# Template Name: Card Grid #}
<div class="cards">
{% for row in data %}
  <div class="card">{{ row.title|raw }}{{ row.body|raw }}</div>
{% endfor %}
</div>
```

Save as `views-card-grid.html.twig` in the FFT template directory, rebuild cache, then select
*Card Grid* on the style with `render_type = raw` (field ids like `title`, `body` come from the
form's field list).

## Gotchas

- Templates and rendering come from the parent FFT module — same sandboxed-Twig, procedural
  `twig_render_template()` path (throws outside a themed web request).
- The template dropdown is empty until FFT's `fft_storage_dir` points at an existing directory that
  contains `views*`-prefixed templates with the header — see the parent module's
  `agent/config/settings.md`.
- The style class doc-comment says *"Bootstrap Grid layout"*, a copy-paste leftover; it renders
  whatever the selected template does.
