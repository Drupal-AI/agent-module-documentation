# Color pickr — field type, widget & formatters

No settings page. Add a **Color pickr** field to any fieldable entity, then choose the widget on
*Manage form display* and one of the five formatters on *Manage display*.

## Field type: `color_pickr_code`
- Class `Plugin/Field/FieldType/ColorPickrItem`. Single property/column `color_pickr`:
  `varchar(256)`, `not null: FALSE`. `isEmpty()` is true when the value is `NULL` or `''`.
- `default_widget = color_pickr_default`, `default_formatter = color_pickr_default`.
- Stored value is whatever the widget writes: normally a HEXA string like `#3F51B5CC`, or the
  literal string `none` when the picker's *clear* action is used.

## Widget: `color_pickr_default`
Class `Plugin/Field/FieldWidget/ColorPickrDefaultWidget`. Settings:

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `theme` | select | `classic` | Pickr skin: `classic`, `monolith`, or `nano`. |
| `hide_description` | bool | `false` | If true, the text input is hidden (`style=display:none`); only the swatch button shows. |

The form element is a `#type => textfield` (rendered `readonly`) with a `#suffix` `<div class="color-picker" data-id=UUID>`; it `#attached`s the `color_pickr/color_pickr` library and `drupalSettings` `{uuid, theme}`. `js/color_pickr.js` instantiates `Pickr.create()` on each `.color-picker`, seeds it from the current field value (default `#3F51B5CC` when empty), and on *save* writes `color.toHEXA()` back into the input; *clear* writes `none`.

## Formatters (all for field type `color_pickr_code`)

| Formatter id | Theme hook | Output |
|---|---|---|
| `color_pickr_default` | `color_pickr_default` | `<div class="snippets-description">{value}</div>` (text). |
| `color_pickr_square` | `color_pickr_square` | `<div class="color-pickr-square" style="background-color: {value};">`. |
| `color_pickr_circle` | `color_pickr_circle` | `<div class="color-pickr-circle" …>`. |
| `color_pickr_hexagon` | `color_pickr_hexagon` | `<div class="color-pickr-hexagon" …>`. |
| `color_pickr_line` | `color_pickr_line` | `<div class="color-pickr-line" …>`. |

Each formatter skips items whose value is empty or equal to `none`. See
[../theming/templates.md](../theming/templates.md) to override the swatch markup/CSS.

## Set up with Drush (example)
```php
// drush php:eval — create a color field on node.article and wire widget + a swatch formatter.
$ex = \Drupal::entityTypeManager()->getStorage('field_storage_config');
$ex->create(['field_name'=>'field_accent','entity_type'=>'node','type'=>'color_pickr_code'])->save();
\Drupal::entityTypeManager()->getStorage('field_config')
  ->create(['field_name'=>'field_accent','entity_type'=>'node','bundle'=>'article','label'=>'Accent color'])->save();

$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_accent', ['type'=>'color_pickr_default','region'=>'content','settings'=>['theme'=>'nano','hide_description'=>TRUE]])->save();

$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_accent', ['type'=>'color_pickr_circle','region'=>'content'])->save();
```
