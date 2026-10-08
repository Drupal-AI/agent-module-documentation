<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up a Font Awesome icon field

There is **no settings page**. You use the module by (1) creating a plain **text (string)**
field, (2) giving it an icon-picker widget on *Manage form display*, and (3) giving it the icon
formatter on *Manage display*.

## 1. The field

Any core `string` field (single-line "Text (plain)"). No new field type is defined — the field
just stores an icon class string like `fas fa-eye` / `fa-solid fa-star`.

## 2. Widgets (Manage form display)

| Widget id | Label | Library | Notes |
|---|---|---|---|
| `font_awesome_icon_picker_widget` | Font Awesome icon picker | `font_awesome/iconpicker-widget` (Furcan IconPicker) | The current, recommended picker. |
| `font_awesome_icon_picker` | Font Awesome icon picker (LEGACY) | `font_awesome/iconpicker` (Farbelous fontawesome-iconpicker) | Setting `default_value` (default `fas fa-eye`). |

Widget settings schema: `field.widget.settings.font_awesome_icon_picker` → `default_value` (string).

## 3. Formatter (Manage display)

Formatter id `font_awesome_icon` ("Icon"), for `string` fields; extends core `StringFormatter`.

`defaultSettings()`:

| Setting | Default | Options |
|---|---|---|
| `size` | `''` | `''` (none), `fa-xs`, `fa-sm`, `fa-lg`, `fa-2x` … `fa-10x` |
| `fixed_width` | `fa-fw` | `fa-fw` (add fixed-width class) or empty |

Plus the inherited `link_to_entity` option (render the icon as a link to the host entity).

Render (`viewValue`): merges the stored value's classes with `size` and `fixed_width` into
`<i class="…"></i>`, and attaches `lp_fontawesome/fontawesome` so the font loads only when an
icon renders. Formatter settings schema: `field.formatter.settings.font_awesome_icon` →
`size`, `fixed_width`.

## Configure programmatically (drush php:eval)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_icon', ['type' => 'font_awesome_icon_picker_widget'])->save();

$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_icon', [
  'type' => 'font_awesome_icon',
  'settings' => ['size' => 'fa-2x', 'fixed_width' => 'fa-fw'],
])->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_icon`.

## Library dependency

The Font Awesome assets themselves come from **`lp_fontawesome`** (Libraries Provider);
CDN-vs-local, minification, and version are configured there, not here. Minimum Font Awesome
5.8.0. The icon-picker JS libraries are declared in `font_awesome.libraries.yml`.
