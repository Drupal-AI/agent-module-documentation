<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, the grid dialog, theming and hooks

## Routes & permission

| Route | Path | Access |
|---|---|---|
| `ckeditor_bs_grid.settings` | `/admin/config/content/ckeditor_bs_grid` | `administer ckeditor_bs_grid` |
| `ckeditor_bs_grid.dialog` | `/ckeditor_bs_grid/dialog/{editor}` | `access content` |

`{editor}` is the **text format id** (`$editor->getFilterFormat()->id()`), injected into the JS
config as `dialogURL` by `BsGrid::getDynamicPluginConfig()`.
Permission `administer ckeditor_bs_grid` — "Administer settings for CKEditor BS Grid" — is the
module's only permission.

## The dialog form (`Drupal\ckeditor_bs_grid\Form\GridDialog`, form id `ckeditor_bs_grid_dialog`)

A three-step AJAX form; the step is kept in `$form_state->get('step')` and the accumulated values
in `$form_state->get('bs_grid_settings')` (seeded from `$input['editor_object']` when the dialog
opens, and re-serialised into the hidden `bs_grid_settings` field when editing an existing grid).

| Step | Elements |
|---|---|
| `select` | `num_columns` (radios, one image per allowed column count; read-only when editing an existing grid) |
| `layout` | `add_container` (checkbox), `container_type` (`default` / `fluid` / `wrapper`), `no_gutter` (checkbox), and one `details` per allowed breakpoint containing a `layout` radios element whose options come from `ckeditor_bs_grid.settings` |
| `advanced` | `container_wrapper_class`, `container_class` (only with a container), `row_class`, and `col_<n>_classes` for each column |

Buttons are all `#ajax` (`::submitStep`, `::submitBackStep`, `::submitDialog`) with no regular
submit handler — the form only works through CKEditor's dialog JS, which finally receives an
`EditorDialogSave` command carrying the settings and builds the markup client-side.

Layout radio keys are `implode('_', $layout['settings'])` (e.g. `3_9` for a 25%/75% split), plus
`none` for "None (advanced)".

## Theming

```php
function ckeditor_bs_grid_theme() {
  return ['form_element_label__bs_grid_option' => [
    'base hook' => 'form_element_label',
    'template' => 'form-element-label-bs-grid-option',
  ]];
}
```

`hook_preprocess_form_element()` spots `#attributes['data-bs-grid-option']` on the layout radios,
adds the classes `d-block m-0 bs-grid-option`, switches the label to that theme hook and passes
`#bs_option_value`; `hook_preprocess_form_element_label()` explodes that value on `_` into
`bs_option_values` so the template can draw a miniature preview of the column widths.
Template: `templates/form-element-label-bs-grid-option.html.twig`.

## Config schema alter

```php
function ckeditor_bs_grid_config_schema_info_alter(&$definitions) {
  if (isset($definitions['ckeditor5.plugin.ckeditor5_sourceEditing'])) {
    unset($definitions['ckeditor5.plugin.ckeditor5_sourceEditing']['mapping']['allowed_tags']['sequence']['constraints']['SourceEditingRedundantTags']);
  }
}
```

This removes core's "redundant source editing tags" validation constraint (see
[drupal.org/i/3410100](https://www.drupal.org/i/3410100)) so a format may list `<div class data-*>`
in *Source editing* even though the grid plugin already declares those elements.

## Generated markup

The JS builds ordinary Bootstrap markup, e.g. for a 2-column `md` grid with a fluid container:

```html
<div class="container-fluid">
  <div class="row">
    <div class="col-md-3">…</div>
    <div class="col-md-9">…</div>
  </div>
</div>
```

`equal` renders as `col`, `auto` as `col-auto`, and a numeric width with the breakpoint prefix as
`col-<prefix>-<n>` (no prefix for `xs`). "No Gutters" adds Bootstrap's `g-0` to the row, and the
advanced step's class fields are appended to the corresponding element.
