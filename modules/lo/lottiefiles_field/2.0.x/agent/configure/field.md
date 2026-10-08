<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The lottiefiles_field field, widget, formatter & media type

No settings page. You add a **Lottiefiles Field** to a bundle (Manage fields), pick the
`lottiefiles_field` widget on Manage form display and the `lottiefiles_field` formatter on
Manage display — or use the ready-made `lottiefiles` media type. Source files:
`src/Plugin/Field/FieldType/LottiefilesFieldItem.php`, `.../FieldWidget/LottiefilesFieldWidget.php`,
`.../FieldFormatter/LottiefilesFieldFormatter.php`, `src/Plugin/media/Source/Lottiefile.php`,
`src/Form/LottiefilesFieldMediaForm.php`, `config/install/*`.

## Field type `lottiefiles_field`

Extends core `LinkItem` (so it inherits link validation constraints: `LinkType`, `LinkAccess`,
`LinkExternalProtocols`, `LinkNotExistingInternal`). The `title` sub-property is removed; the
`link_type` is forced to `17` (both internal + external) and hidden. Extra stored columns
(alongside the link `uri`):

| Property | Type | Default | Notes |
|---|---|---|---|
| `autoplay` | bool | 0 | Play on load. |
| `background` | string(32) | `transparent` | `transparent` or `#rrggbb`. |
| `controls` | bool | 0 | Show play/pause/slider. |
| `hover` | bool | 0 | Play on mouse hover. |
| `loop` | bool | 0 | Loop animation. |
| `mode` | string(10) | `normal` | `normal` or `bounce`. |
| `speed` | int | 1 | 1–5. |
| `selector` | string(20) | auto `lottie-<rand>` | Unique element id. |
| `width` | int | 0 | Width in px (0 = unset). |

`isEmpty()` is true when the `uri` is empty.

## Widget `lottiefiles_field` (extends `LinkWidget`)

Form element per value: a **Lottiefile URL** textfield (not required; external URL or internal
path), a `managed_file` **JSON File upload** (`file_validate_extensions => ['json']`,
`#upload_location => 'public://lottiefile_field/'`), a **Background** textfield with a native
`<input type="color">` picker suffix, and checkboxes/selects for the options above. `selector` is a
hidden field defaulting to `lottie-<random>` (via `Crypt::randomBytesBase64`).

- `colorValidate()` — allows empty, `transparent`, or `/^#([a-f0-9]{6})$/i`; else form error.
- `validateUriElement()` — if a file was uploaded, marks it permanent and replaces the URI with the
  file's generated (relative) URL; otherwise keeps the entered URI. Skipped on the field-config form.

## Formatter `lottiefiles_field`

`viewElements()` emits one `#theme => 'lottiefiles_player_formatter'` element per item, passing the
option values through; `#background` is `Xss::filter`ed and `#cssselector` is
`Html::cleanCssIdentifier(<field name>)`. `convertToAbsoluteUrl()` turns an `internal:/…` URI into an
absolute URL, otherwise passes the URL through unchanged. Rendering details: [../theming/player.md](../theming/player.md).

## The `lottiefiles` media type

`config/install/` ships: media type `lottiefiles` (source `lottiefile`), field storage/instance
`field_media_lottiefile` (a `lottiefiles_field`), and default form/view displays (incl. a
`media_library` form mode). Media source `Lottiefile` (`@MediaSource id="lottiefile"`,
`default_thumbnail_filename="lottie.png"`) exposes a `name` metadata attribute and registers the
`LottiefilesFieldMediaForm` as its `media_library_add` form (a `name` field, a JSON URL field, a JSON
upload, and a Player-settings details group). On install the module copies `lottie.png` into the
media icon base directory; it errors on install if `media` is missing or the icon dir is not writable.

## Set the field/widget/formatter with Drush (example)

```php
// drush php:eval — add a lottie field to article and configure widget + formatter.
$ff = \Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_animation', 'entity_type' => 'node', 'type' => 'lottiefiles_field',
]); $ff->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_animation', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Animation',
])->save();
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node','article','default');
$fd->setComponent('field_animation', ['type' => 'lottiefiles_field'])->save();
$vd = \Drupal::service('entity_display.repository')->getViewDisplay('node','article','default');
$vd->setComponent('field_animation', ['type' => 'lottiefiles_field'])->save();
```
