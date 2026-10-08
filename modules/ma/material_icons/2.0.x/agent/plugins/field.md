# Material Icons — field type, widget, formatter

The module defines core-style Field plugins (it does **not** define a new plugin *type*).

## Field type `material_icons`

`@FieldType(id = "material_icons", category = "icons", default_widget = "material_icons",
default_formatter = "material_icons")`

Schema columns (`FieldType/MaterialIcons.php::schema()`):

| Column | Type | Not null | Meaning |
|---|---|---|---|
| `icon` | text (normal) | yes | Icon name, e.g. `home`, `star`. |
| `family` | text (tiny) | yes | Style key, e.g. `baseline`, `outlined`, `symbols__rounded`. |
| `classes` | text (normal) | no | Extra CSS classes. |

`isEmpty()` is true when `icon` is null/empty (family/classes alone do not count).

## Widget `material_icons`

Renders three elements per value:

- `icon` — a textfield with `#autocomplete_route_name = material_icons.autocomplete`
  (parameter `font_family` = the selected style). The autocomplete controller fetches icon
  metadata from Google (`https://fonts.google.com/metadata/icons…`), caches it for a week
  under cache tags `materialicons`/`iconlist`, and returns up to 10 name/tag matches with a
  rendered glyph preview.
- `family` — a select of the enabled families (intersection of `material_icons.settings`
  `families` and the known family list); disabled when `allow_style` is off. Changing it
  AJAX-refreshes the autocomplete's `font_family`.
- `classes` — a textfield, only shown when `allow_classes` is on.

Widget settings: `allow_style`, `default_style`, `allow_classes` (see
[configure/settings.md](../configure/settings.md)).

## Formatter `material_icons`

`viewElements()` themes each value with `#theme = 'material_icon'`, passing `icon`, the
computed CSS `family` class (via `getFontFamilyClass()`), and `classes`. Template
`templates/material-icon.html.twig`:

```twig
<i class="{{ family }} {{ classes }}">{{ icon }}</i>
```

The `family` CSS class is derived from the style key: `baseline` → `material-icons`, other
Material Icons styles → `material-icons-<style>` (e.g. `material-icons-outlined`), and
Material Symbols → `material-symbols-<style>` (the `symbols__` prefix is stripped).

## Create a field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_mi_icon', 'entity_type' => 'node', 'type' => 'material_icons',
])->save();
FieldConfig::create([
  'field_name' => 'field_mi_icon', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Icon',
])->save();
```

Then add the widget/formatter components to the form and view displays (`type` =
`material_icons`).
