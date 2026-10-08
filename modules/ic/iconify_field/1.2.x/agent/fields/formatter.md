# Formatter & rendering

## Formatter: `iconify_field_icon_formatter`

Class: `Drupal\iconify_field\Plugin\Field\FieldFormatter\IconField` (extends `FormatterBase`).
Label "Icon"; the default and only formatter for `iconify_field_icon`. It has **no settings**.

`viewElements()` emits one `#type => iconify_icon` render element per item:

```php
$elements[$delta] = [
  '#type' => 'iconify_icon',
  '#icon' => $item->value,                       // 'collection:name'
  '#attributes' => ['class' => 'iconify-field ' . $classes],
];
```

Then, from the item's per-item columns (see [field-type.md](field-type.md)):
- if `decorative` → adds `aria-hidden="true"`;
- if `arialabel` is set → adds `aria-label="<name>"` and `role="img"`.

(Because the widget blanks `arialabel` for decorative items, an item is normally *either*
`aria-hidden` *or* labelled, not both.)

## Render element: `iconify_icon`

Class: `Drupal\iconify_field\Element\IconifyIcon` (`@RenderElement("iconify_icon")`). Theme
`iconify_icon`, template `templates/iconify-icon.html.twig`, attaches library
`iconify_field/icon`. The template is a one-liner that delegates to the Twig function:

```twig
{{ iconify_field(element['#icon'], attributes) }}
```

So the formatter, the render element and the Twig function all converge on the same
`IconResolver::getIcon()` path.

## How the SVG is produced (`IconResolver::getIcon()`)

Service `iconify_field.icon_resolver` (`Drupal\iconify_field\Service\IconResolver`, constructed
with `@cache.render`).

1. Normalises `$attributes` (an array or a `Drupal\Core\Template\Attribute`) and builds a cache
   key `iconify_field:<name>[:<sha1 attrs>]:<autosize>`; a hit returns the cached render array.
2. **Fallback**: if `$icon_name` is empty or has no `:` separator, returns a
   `#type => html_tag` `span` with `#value => $icon_name` and class `iconify-field` (plus any
   attrs). This is the "unresolved icon" output — it shows the raw name, it does not error.
3. Splits `collection:name`, loads the collection JSON via `loadCollection()` →
   `Iconify\IconsJSON\Finder::locate($collection)` (a file inside the on-disk `iconify/json`
   package). If the collection or icon is missing, returns the same fallback span.
4. Otherwise returns a `#type => html_tag` **`svg`** with:
   - `xmlns`, class `iconify-field`, computed `viewBox` (`0 0 <icon_width> <collection_height>`),
   - **default sizing `width` normalised to `<em>` and `height => 1em`** so the icon scales with
     font size; when `$autosize` is TRUE it uses the icon's native pixel width/height instead,
   - `#value => Markup::create($collection['icons'][$icon_name]['body'])` — the raw SVG paths
     from the bundled collection JSON.
   Result is cached in `cache.render`.

Because default height is `1em` and the SVG uses `currentColor`, icons **inherit the surrounding
text size and colour** — style them with CSS via the `iconify-field` class or the per-item
`classes`. No client-side JavaScript is involved in frontend rendering.

## Set the formatter in PHP

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_icon', ['type' => 'iconify_field_icon_formatter'])
  ->save();
```
