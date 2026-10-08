<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, Color entity and Typed Data API

## `colorapi.service` (`ColorapiService`)

| Method | Description |
|---|---|
| `hexToRgb($hex, $colorIndex)` | Returns the 0–255 component for `$colorIndex` of `'red'`, `'green'` or `'blue'`. Strips a leading `#`; handles both 3- and 6-digit hex. Returns `NULL` for empty input. |
| `isValidHexadecimalColorString($string)` | `preg_match` against `HexColorInterface::HEXADECIMAL_COLOR_REGEX` = `/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/`. |

```php
$svc = \Drupal::service('colorapi.service');
$r = $svc->hexToRgb('#3366cc', 'red');    // 51
$ok = $svc->isValidHexadecimalColorString('#abc'); // truthy
```

## Color configuration entity (`colorapi_color`)

Only registered when `enable_color_entity` is true. Class `Color` (ConfigEntityBase),
`config_prefix = colorapi_color`, config export `id`, `label`, `color`. Config name:
`colorapi.colorapi_color.<id>`.

| Method | Returns |
|---|---|
| `getHexadecimal()` | the stored `#hex` string |
| `getRgb()` | `['red' => …, 'green' => …, 'blue' => …]` |
| `getRed()` / `getGreen()` / `getBlue()` | the single component (via `colorapi.service`) |

```php
use Drupal\colorapi\Entity\Color;
$c = Color::create(['id' => 'brand_red', 'label' => 'Brand Red', 'color' => '#FF0000']);
$c->save();
$rgb = Color::load('brand_red')->getRgb(); // ['red'=>255,'green'=>0,'blue'=>0]
```

## Typed Data types

Registered in `config/schema/colorapi.data_types.schema.yml`:

| Data type id | Class | Notes |
|---|---|---|
| `colorapi_color` | `ColorData` | complex color (name + hex + rgb), definition `ColorDefinition` |
| `hexadecimal_color` | `HexColorData` | a hex string (`StringInterface`) |
| `rgb_color` | `RgbColorData` | red/green/blue, definition `RgbColorDefinition` |

## Validation constraint

`HexColorConstraint` (validator `HexColorConstraintValidator`) checks a value against the
hexadecimal color regex above — attach it to a Typed Data property to enforce valid `#hex`
input.

## Enable/disable behaviour (`colorapi.module`)

- `hook_field_info_alter()` unsets `colorapi_color_field` when `enable_color_field` is false.
- `hook_entity_type_alter()` unsets the `colorapi_color` entity type when
  `enable_color_entity` is false (and `hook_menu_links_discovered_alter` hides its menu link).

So to use the Color entity API in code, ensure `enable_color_entity` is true and the entity
type is rebuilt (`drush cr`) first — otherwise `getStorage('colorapi_color')` is undefined.
