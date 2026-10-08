# Configure Field Image Style

Two moving parts: an **`image_style` field** the editor picks a style in, and the
**`image_style_image_formatter`** on an `image` field that renders using that pick.

## The `image_style` field type

- Plugin id: `image_style` (class `ImageStyleItem extends ListItemBase`).
- `default_widget = options_select`, `default_formatter = list_default`.
- Stored value: a single `varchar(255)` — the machine name of an image style.
- Cardinality is forced to **1** and the cardinality control is hidden on the field
  storage form (`hook_form_field_storage_config_edit_form_alter`).
- Options come from `image_style_options(FALSE)` (all configured image styles).

### Storage settings

| Setting | Type | Meaning |
|---|---|---|
| `allowed_values` | array (checkboxes) | Restrict which image styles are selectable. **Empty = all styles allowed.** Keys are image-style machine names. |
| `sort` | boolean | Sort the option list by label (`asort`). |

Widgets available for this field type: `options_select`, `options_buttons` (radios/checkboxes).
List formatters available: `list_default` (shows the style label), `list_key` (shows the raw
machine name).

## The image formatter

`image_style_image_formatter` (id) — label "Field Image Style formatter", applies to
`image` field types. It subclasses core `ImageFormatter`.

Settings (in addition to inherited image-link settings):

| Setting | Meaning |
|---|---|
| `field_image_style` | Machine name of an `image_style` field **on the same bundle** whose stored value is used as the image style. Empty ⇒ original image. |
| `image_link` | `''` (nothing), `content`, or `file` — same as core image formatter. |

At render, the formatter reads `$entity->{field_image_style}->value` and passes it as
`#image_style` to `#theme => image_formatter`; it merges the chosen style's cache tags.

## Typical setup (drush / config)

1. Add an `image` field (e.g. `field_hero`) to a bundle.
2. Add an `image_style` field (e.g. `field_hero_style`) to the same bundle. Optionally set
   `allowed_values` to a curated list of styles; optionally set `sort: true`.
3. In **Manage display** for the view mode, set `field_hero`'s formatter to
   *Field Image Style formatter* and set its `field_image_style` setting to `field_hero_style`.
4. Editors now pick a style per node; the image renders with it (or the original if empty).

Example: enabling the formatter in an `entity_view_display` component:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_hero', [
  'type' => 'image_style_image_formatter',
  'settings' => ['field_image_style' => 'field_hero_style', 'image_link' => ''],
])->save();
```
