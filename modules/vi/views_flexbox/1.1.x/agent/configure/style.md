# Configure the Flexbox Views style

No global settings page (`configure` null). In the **Views UI** edit a display, click the
**Format** → *Style* setting, choose **Flexbox**, then open its settings to set the options
below. Settings persist in the View config entity under
`display.<id>.display_options.style` (`type: flexbox`, `options: {...}`; schema
`views.style.flexbox`). The style uses a row plugin, so pick any Row style (Fields, Content/teaser…)
as usual.

Source: `src/Plugin/views/style/Flexbox.php`, template `templates/views-view-flexbox.html.twig`,
preprocess `template_preprocess_views_view_flexbox()` in `views_flexbox.module`.

## Options (defaults from `defineOptions()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `style` | select | `_none_` | Preset: `_none_` (no extra CSS) or `cards` (attaches the Card CSS library). *Required.* |
| `direction` | select | `row` | `flex-direction`: `row` / `row-reverse` / `column` / `column-reverse`. *Required.* |
| `justify` | select | `start` | `justify-content`: `start`/`end`/`center`/`space-between`/`space-around`/`space-evenly`. *Required.* |
| `align_items` | select | `stretch` | `align-items`: `start`/`end`/`center`/`stretch`/`baseline`. *Required.* |
| `align_content` | select | `stretch` | `align-content`: `start`/`end`/`center`/`stretch`/`space-between`/`space-around`. *Required.* |
| `item_class_default` | checkbox | `TRUE` | Add default `item-<N>` class to each item (loop index). Uncheck for leaner markup. |
| `item_class_custom` | textfield | `''` | Extra space-separated classes on every item; sanitized with `Html::cleanCssIdentifier`. Supports Views field tokens when the display uses fields. |
| `link_to_content` | checkbox | `FALSE` | (Shown only when `style = cards`.) Wrap each item in an `<a>`. |
| `link_source` | textfield | `NULL` | (Shown only when `link_to_content` and the display uses fields.) URL for the item link; supports "Rewrite results" field tokens. |

Note: the shipped schema `views.style.flexbox` types `justify` as `boolean` and does **not**
declare `link_to_content` / `link_source`; those still work via Views' generic option handling
but are untyped in schema.

## Markup produced

Wrapper element gets classes:
`views-view-flexbox`, `views-flexbox-direction-<direction>`, `views-flexbox-justify-<justify>`,
`views-flexbox-align-items-<align_items>`, `views-flexbox-align-content-<align_content>`, and
`views-flexbox-<style>` (when a style preset other than `_none_` is chosen). Each row renders as
`<div class="views-flexbox-item item-<N>">…</div>`, or `<a class="…" href="…">…</a>` when
`link_to_content` is on.

## Link resolution (`getLinkLocation`)

When `link_to_content` is enabled: if `link_source` is set and the display uses fields, the link
is the token-replaced, tag-stripped `link_source`; otherwise it falls back to the row entity's
canonical URL (`$row->_entity->toUrl()`). No link is added for field-only displays without a
`link_source` and without a row entity.

## Set the style with code (example)

```php
// drush php:eval — set an existing display to the flexbox style.
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = &$view->getDisplay('default');
$display['display_options']['style'] = [
  'type' => 'flexbox',
  'options' => [
    'style' => 'cards',
    'direction' => 'row',
    'justify' => 'space-between',
    'align_items' => 'stretch',
    'align_content' => 'stretch',
    'item_class_default' => TRUE,
    'item_class_custom' => 'my-card',
    'link_to_content' => TRUE,
    'link_source' => '',
  ],
];
$view->save();
```

## Styling

The visual layout is done entirely in CSS from the module's libraries
(`css/views_flexbox.css`, `css/views_flexbox.cards.css`), attached automatically in preprocess
(`views_flexbox/views_flexbox`, plus `views_flexbox/views_flexbox.cards` for the Card style).
Override or extend by targeting the generated modifier classes in your theme.
