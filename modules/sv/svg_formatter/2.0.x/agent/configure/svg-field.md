<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure an SVG field

No admin page. The whole module is a formatter you pick on *Manage display*.

## 1. The field

Use a core **File** field and add `svg` to the allowed extensions:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_logo', 'entity_type' => 'node', 'type' => 'file',
])->save();
FieldConfig::create([
  'field_name' => 'field_logo', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Logo', 'settings' => ['file_extensions' => 'svg'],
])->save();
```

An **Image** field also works, but the formatter only offers itself there when the contrib module
`svg_image` is enabled — `SvgFormatter::isApplicable()` returns FALSE for `image` fields otherwise.

## 2. Settings

| Key | Default | Meaning |
|---|---|---|
| `inline` | `FALSE` | Print the SVG markup inline instead of an `<img>` tag. |
| `sanitize` | `TRUE` | Run inline SVG through `enshrined\svgSanitize\Sanitizer`. Only used when `inline`; checkbox is disabled when the library is missing. |
| `apply_dimensions` | `TRUE` | Emit `width`/`height` (as `<img>` attributes, or set on the root `<svg>` when inline). |
| `width` | `100` | Integer, only used when `apply_dimensions`. |
| `height` | `100` | Integer, only used when `apply_dimensions`. |
| `enable_alt` | `TRUE` | Emit an `alt` attribute (non-inline output). |
| `alt_string` | `''` | Token string for `alt`. Empty ⇒ prettified filename. |
| `enable_title` | `TRUE` | Emit `title` (non-inline) or an inline `<title>` element. |
| `title_string` | `''` | Token string for `title`. Empty ⇒ prettified filename. |

Token contexts available to `alt_string` / `title_string`: `file` and the parent entity's type
(e.g. `node`), replaced with `['clear' => TRUE]`. The token-browser link only renders when the
`token` module is installed. If the token string resolves to an empty string the attribute is
simply not set.

## 3. Where it is stored

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  field_logo:
    type: svg_formatter
    label: hidden
    weight: 10
    region: content
    settings:
      inline: false
      sanitize: true
      apply_dimensions: true
      width: 200
      height: 60
      enable_alt: true
      alt_string: '[node:title] logo'
      enable_title: true
      title_string: ''
    third_party_settings: {}
```

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_logo', [
  'type' => 'svg_formatter', 'label' => 'hidden', 'weight' => 10, 'region' => 'content',
  'settings' => [
    'inline' => TRUE, 'sanitize' => TRUE, 'apply_dimensions' => TRUE,
    'width' => 200, 'height' => 60,
    'enable_alt' => TRUE, 'alt_string' => '', 'enable_title' => TRUE, 'title_string' => '',
  ],
  'third_party_settings' => [],
])->save();
```

Read back:

```bash
drush cget core.entity_view_display.node.article.default content.field_logo
```

## 4. Via the UI

1. Add a **File** field, allowed extensions `svg`.
2. *Manage display* → set the field's format to **SVG Formatter**.
3. Cog → tick *Output SVG inline* (and *Sanitize inline SVG*) or leave it off for an `<img>`;
   set *Image width* / *Image height*; enable/disable alt and title and optionally give tokens.
4. **Update**, **Save**.

## Sanitizer library

`enshrined/svg-sanitize` (`>=0.22.0`) is a hard `require` in the module's `composer.json`, so a
Composer install already has it. `isSanitizerInstalled()` just checks
`class_exists('\enshrined\svgSanitize\Sanitizer')`. Without it, the sanitize checkbox is disabled.
