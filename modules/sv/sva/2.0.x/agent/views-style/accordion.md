<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `simple_views_accordion` style plugin — enabling, options & output

Style plugin `src/Plugin/views/style/SimpleViewsAccordion.php`, id `simple_views_accordion`, title
"Simple Views Accordion", extends core `StylePluginBase`. Declared with
`#[ViewsStyle(id: 'simple_views_accordion', title: …, help: 'Displays each row as a collapsible details element.', theme: 'views_style_simple_views_accordion', display_types: ['normal'])]`.
`usesRowPlugin = TRUE` (works with any row plugin — Fields or an entity view mode) and `usesRowClass = TRUE`.

## Enable it on a view

1. Edit a View → **Format** → set the display **Format** to *Simple Views Accordion*.
2. **Summary / header per item**: the preprocess uses the **first field** of the row as the `<details>` summary
   when the row plugin uses fields (`$view->rowPlugin->usesFields()` → `array_key_first($view->field)`). When the
   display does **not** use fields (e.g. "Content" rendered in a view mode), the **entity label**
   (`$view->result[$id]->_entity?->label()`) is used instead; it falls back to an empty string if neither is
   available. Tip (from README): add a field, mark it "Exclude from display" and move it to the top to use it as
   the summary without repeating it in the body.
3. The **row content** (the full rendered row) becomes the collapsible body of the `<details>`.

## Style options

Config-schema key **`views.style.simple_views_accordion`** (`config/schema/simple_views_accordion.schema.yml`).
Defaults come from `defineOptions()`:

| Option key | Type | Default | Notes |
|---|---|---|---|
| `wrapper_class` | string | `item-list` | Space-separated classes placed on the wrapper `<div>` around all rows. `preprocessViewsStyleSimpleViewsAccordion()` `preg_split`s it on whitespace into `attributes.class`. Empty → no override. |
| `allow_multiple` | bool | `FALSE` | When **unchecked** (default), opening one item closes the others (exclusive accordion). When checked, several items may be open at once. |
| `open_first` | bool | `FALSE` | Open the first item by default on load. With grouping, the first item of **each group** is opened (preprocess runs per group render, `$first` resets each call). |

`buildOptionsForm()` renders them as a `textfield` (`wrapper_class`) and two `checkbox`es (`allow_multiple`,
`open_first`) on top of the standard Views style options.

## How the accordion behaviour is produced (no JavaScript)

`Drupal\simple_views_accordion\Hook\SimpleViewsAccordionHooks::preprocessViewsStyleSimpleViewsAccordion()`
(OOP `#[Hook('preprocess_views_style_simple_views_accordion')]`) does the work — there is **no library, no JS and
no CSS** in 2.0.x. For each row it builds:

```php
$details = [
  '#type' => 'details',
  '#title' => $title ?? '',
  '#open' => $first && !empty($options['open_first']),
  'row' => $row,
];
```

Exclusive behaviour relies on the browser-native exclusive accordion of the **`name` attribute on `<details>`**:
`<details>` elements sharing a `name` auto-close each other. When `allow_multiple` is falsy, the preprocess sets a
single shared name via `Html::getUniqueId('simple-views-accordion-' . $view->id() . '-' . $view->current_display)`
on every row's `#attributes['name']`; when `allow_multiple` is truthy, no name is set (so multiple can stay open).
The name is **unique per render**, so multiple accordions or grouping sections on one page stay independent.
Browsers without `name`-exclusive-`<details>` support simply allow several items to be open.

Each row is also wrapped with `class="simple-views-accordion"` (plus the Views row class from
`$style->getRowClass($id)` when present) via a `Drupal\Core\Template\Attribute` object. The wrapper `<div>` picks
up `wrapper_class`, and `default_row_class` is passed to the template so core's `views-row` class is added when
enabled.

## Template

`templates/views-style-simple-views-accordion.html.twig` — a wrapper `<div{{ attributes }}>` iterating `rows`,
emitting `<div{{ row.attributes.addClass(row_classes) }}>{{ row.content }}</div>` per row (where `row.content` is
the `details` render array). `row_classes` adds `views-row` when `default_row_class` is set.

## Upgrade notes (1.0.x → 2.0.x)

`simple_views_accordion.post_update.php` provides two post-update hooks run on `drush updatedb`:
- `simple_views_accordion_post_update_rename_plugin_id` — rewrites the old doubled style type
  `simple_views_accordion_simple_views_accordion` to `simple_views_accordion` in all views.
- `simple_views_accordion_post_update_add_style_options` — adds `allow_multiple` / `open_first` (both `FALSE`) to
  existing `simple_views_accordion` displays.

Existing views keep working without manual changes. If a theme extended or overrode the removed
`simple_views_accordion/simple_views_accordion` library, remove that reference.

## Trust / output notes

All option values (`wrapper_class`, the two booleans) are set by a user with Views admin rights (trusted config);
class strings are rendered through Drupal's `Attribute` object (escaped). The `<details>` summary is either
already-rendered Views field output (sanitized per the field handler's own configuration — the standard Views
trust model) or the entity `->label()` (a plain string auto-escaped by Twig). No option value and no row value is
passed to JavaScript — the module ships none. There is no untrusted-input sink in this plugin.
