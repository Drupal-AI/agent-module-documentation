<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `css` field (type + widget + formatter)

Field CSS ships one field type and its default widget and formatter. Adding a field of type **CSS**
to a bundle is all that is needed — the `css` widget and `css` formatter are the field type's
`default_widget` / `default_formatter`, so they are assigned automatically.

## Field type `css`

`\Drupal\field_css\Plugin\Field\FieldType\CssItem` (`@FieldType(id="css", category="General")`).

- Single property `value` (string), stored in column `value` as `text`, size `big`.
- `isEmpty()` treats the item as empty only when `value` is `NULL` (empty string is normalized to
  `NULL` by the widget's `massageFormValues()`).

## Widget `css`

`\Drupal\field_css\Plugin\Field\FieldWidget\CssWidget` (`@FieldWidget(id="css", field_types={"css"})`).

- Renders a `#type => 'textarea'` for the raw CSS. Description: "The :root selector cannot be used."
- `validate()` (element validate) parses the submitted CSS with `Sabberworm\CSS\Parser` and sets a
  form error if any selector contains `:root` — this keeps entered rules from escaping a selector
  prefix.
- `massageFormValues()` converts an empty string to `NULL` before save.
- **CodeMirror integration:** when the `codemirror_editor` module is enabled, the element gains a
  `#codemirror` config (`mode: text/css`, `lineNumbers: true`, plus the widget's `toolbar`/`buttons`
  settings) and the settings form/summary expose those options. Without that module the widget is a
  plain textarea and has no settings.

Widget settings (schema `field.widget.settings.css`, only meaningful with CodeMirror):

| Setting   | Type              | Default                              | Meaning                                  |
|-----------|-------------------|--------------------------------------|------------------------------------------|
| `toolbar` | boolean           | `TRUE`                               | Show the CodeMirror toolbar.             |
| `buttons` | sequence<string>  | `['undo','redo','enlarge','shrink']` | Toolbar buttons (from `getAvailableButtons()`). |

## Formatter `css`

`\Drupal\field_css\Plugin\Field\FieldFormatter\CssFormatter` (`@FieldFormatter(id="css", field_types={"css"})`).

Formatter settings (schema `field.formatter.settings.css`):

| Setting              | Type   | Default | Values / notes                                                                 |
|----------------------|--------|---------|--------------------------------------------------------------------------------|
| `location`           | string | `head`  | `head` = attach the `<style>` to `html_head`; `body` = render inline in output. |
| `prefix`             | string | `none`  | `none`, `entity-item`, or `fixed-value` — how selectors are prefixed (below).   |
| `fixed_prefix_value` | string | `''`    | CSS class used when `prefix = fixed-value`. Validated to a clean class (no leading period). |

### How the CSS is rendered

The formatter overrides `view()` (its `viewElements()` returns `[]`). For each non-empty item it
processes `$item->value` according to `prefix`, then emits a `<style>` element:

- `prefix = entity-item` → `addSelectorPrefix($value, '.scoped-css--<entity-type>-<id>')` — every
  selector is prefixed with a per-entity class produced by `generatePrefix()` via
  `Html::cleanCssIdentifier()`.
- `prefix = fixed-value` → `addSelectorPrefix($value, '.' . $fixed_prefix_value)`.
- `prefix = none` → `formatCss($value)` — parsed and re-serialized with
  `OutputFormat::createPretty()` (normalizes/pretty-prints; no prefixing).

Output placement:

- `location = head`: `#attached['html_head'][]` with a `#type => 'html_tag', #tag => 'style',
  #weight => 100`, keyed `"<entity-type>_<id>_<field-name>_<delta>"`.
- `location = body`: an inline `#type => 'html_tag', #tag => 'style'` element in the field output.
- The formatter forces `location = body` on Layout Builder edit routes
  (`layout_builder.add_block`, `update_block`, `remove_block`, `defaults.*`, `overrides.*`) so the
  live preview reflects CSS changes without a page reload.

### The scoping class on the entity wrapper

`field_css_entity_view_alter()` (in `field_css.module`) adds the prefix as a **class on the rendered
entity** so the scoped rules match: for `entity-item` it adds `generatePrefix($entity)`
(`scoped-css--<type>-<id>`), for `fixed-value` it adds the configured `fixed_prefix_value`. The class
is put on `$build['#attributes']['class']` and duplicated into `$build['#field_css']['class']`.
Layout Builder strips entity attributes when rendering entities as components, so the event
subscriber `field_css_block_component_render_array_subscriber`
(`\Drupal\field_css\EventSubscriber\BlockComponentRenderArray`, priority 99 on
`SECTION_COMPONENT_BUILD_RENDER_ARRAY`) copies the `#field_css` classes back onto the component
`#attributes`.

## Reusable trait

`\Drupal\field_css\Traits\CssTrait` holds the CSS logic and can be reused by integrators:
`itemPrefixes($entity, $view_mode)`, `generatePrefix($entity, $leading_period = FALSE)`,
`addSelectorPrefix($css_code, $prefix)`, `formatCss($css_code)`.

## Setting a formatter's config via PHP

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'page', 'default');
$display->setComponent('field_my_css', [
  'type' => 'css',
  'settings' => [
    'location' => 'head',
    'prefix' => 'entity-item',
    'fixed_prefix_value' => '',
  ],
])->save();
```
