<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Semantic Views style & row plugins

Two Views plugins. Set them in the view's **Format** section (Views UI). Options are stored in the
display config; the module defines no plugin *type* of its own (these are core Views plugin types).

## Style plugin — `semanticviews_style` ("Semantic Views Style")

`Drupal\semanticviews\Plugin\views\style\SemanticViewsStyle` (extends `StylePluginBase`,
`usesRowPlugin = TRUE`). Replaces "Unformatted list". Option groups (schema
`views.style.semanticviews_style`):

| Group | Keys (defaults) |
|---|---|
| `group` (grouping title) | `element_type` (`h3`), `attributes` (`class|title`) |
| `list` (list wrapper) | `element_type` (`''` = none; UI offers none/`ul`/`ol`/`dl`/`div`), `attributes` (`''`) |
| `row` | `element_type` (`div`), `attributes` (`class|`), `first_class` (`first`), `last_class` (`last`), `last_every_nth` (`0`), `striping_classes` (`odd even`) |

Behaviour of the `row` options (in `template_preprocess_semanticviews_style`):
- **striping_classes** — space-separated classes applied round-robin per row (`odd even` → zebra).
- **first_class / last_class** — added to the first/last row of the pager set; **or**, when
  `last_every_nth > 0`, added every Nth row (grid gutters). `first_class` is added when
  `index % last_every_nth == 0`; `last_class` when `(index+1) % last_every_nth == 0`.
- If the list should be an HTML list, set the list `element_type` to `ul`/`ol`/`dl` **and** the
  row `element_type` to `li`.

## Row plugin — `semanticviews_row` ("Semantic Views Row")

`Drupal\semanticviews\Plugin\views\row\SemanticViewsRow` (extends `RowPluginBase`,
`usesFields = TRUE`). Options (schema `views.row.semanticviews_row`):
- `skip_blank` (bool) — "Skip empty fields": emit nothing for a field with no content.
- `semantic_html` — a per-field map, each with `element_type` (default `div`), `attributes`,
  `label_element_type` (default `label`), `label_attributes`. These **override** each field's own
  "Style settings".

## Attribute mini-syntax

Every `attributes` textarea takes **one `attribute|value` per line**. A line without a `|` is used
as **both** key and value. Example:
```
class|card card--highlight
role|listitem
data-index|{{ row_index }}
```
- Values are passed through Views token replacement (`tokenizeValue`), so field replacement tokens
  work, plus **`{{ row_index }}`** → the row's 0-based index.
- Parsing is done by `semanticviews_extract_attributes()` (see theming doc).

## Where it's stored (scriptable)

Inside the view config `views.view.<id>` → `display.<display>.display_options.style` /
`.row`:
```yaml
style:
  type: semanticviews_style
  options:
    row:
      element_type: article
      attributes: "class|card"
      striping_classes: "odd even"
row:
  type: semanticviews_row
  options:
    skip_blank: 1
    semantic_html:
      title:
        element_type: h2
        attributes: "class|card__title"
```
Set via the UI, or edit the view config entity (`\Drupal::entityTypeManager()->getStorage('view')`)
and save.
