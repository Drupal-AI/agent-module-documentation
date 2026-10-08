<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Global: Fieldset" Views field

Registered by `hook_views_data()` as `views.fieldset` → handler id `fieldset`
(class `Drupal\views_fieldsets\Plugin\views\field\Fieldset`, `@ViewsField("fieldset")`,
title "Fieldset", help "Create a group of fields."). No config entity, no admin route —
everything lives inside the view's own configuration under this field.

## How it works (workflow)

1. Edit a **field-based** Views display (Unformatted list, Grid, Table, etc.).
2. Add field **Global: Fieldset** (also surfaced as "Views: Fieldset"). Add more than
   one for multiple groups.
3. In **Rearrange** (the fields dropdown → Rearrange), drag normal fields *under* a
   Fieldset field to make them its children; drag one Fieldset under another to nest.
   The module rewrites this form with tabledrag parent/depth so indentation = nesting.
4. Preview: each fieldset renders its children inside the chosen wrapper.

At render time `hook_preprocess_views_view_fields()` calls
`Fieldset::replaceFieldsetHandlers()`, which replaces each fieldset handler with a
`RowFieldset`, moves child fields into it, and removes them from the top level. The
fieldset's own `render()` is a placeholder (`[child|child]`); real output comes from
`RowFieldset::render()`.

## Options (field settings form)

Stored on the field via config schema `views.field.fieldset`:

| Option | Type | Default | Notes |
|---|---|---|---|
| `fields` | sequence of field ids | `[]` | child field machine names (managed by Rearrange, not edited directly) |
| `wrapper` | string | `fieldset` | one of `details`, `fieldset`, `div` (see wrapper-types hook) |
| `legend` | string | `''` | heading text; supports row tokens, e.g. `{{ title }}` |
| `classes` | string | `''` | CSS classes for the wrapper; comma-separated, token-aware, run through `Html::getClass()` |
| `collapsible` | bool | `TRUE` | adds collapsible behavior (fieldset/details) |
| `collapsed` | bool | `FALSE` | start collapsed; ignored for `div` wrapper |

The settings form also prints an item list of available **Replacement patterns**
(row tokens) from `getRenderTokens()`.

## Behavior notes

- **Empty groups are hidden.** A wrapper is only output when at least one child field
  has non-empty (tag-stripped) content — `#show_fieldset`. Empty fieldsets disappear.
- `query()` is a no-op — the field adds nothing to the SQL query.
- `allowAdvancedRender()` returns FALSE (no rewrite/advanced-render on the fieldset itself).
- Legend and each class are tokenized per row via `tokenizeValue()`, so groups can carry
  per-row labels/classes.
- Nesting depth is unlimited; parent lookup walks up via `Fieldset::getFieldParents()`.

## Config example (view field snippet)

```yaml
# In a display's fields: mapping
group:
  id: fieldset
  table: views
  field: fieldset
  plugin_id: fieldset
  wrapper: details
  legend: '{{ title }}'
  classes: 'teaser-box, status-{{ field_status }}'
  collapsible: true
  collapsed: false
  fields:
    - title
    - body
```
