<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bootstrap` icon pack

Everything the module adds at runtime lives in a single definition file:
`bootstrap_icons.icons.yml`. Core (11.1+) reads `*.icons.yml` files as Icon API pack plugins, so
the module ships **no PHP plugin class** for the pack itself.

## Definition (`bootstrap_icons.icons.yml`)

```yaml
bootstrap:                       # pack id → icons addressed as "bootstrap:<icon_id>"
  label: 'Bootstrap Icons'
  description: '2000+ open source SVG icons from the Bootstrap project.'
  version: '1.11.3'              # tracks the vendored library version
  license: { name: MIT, url: .../LICENSE, gpl-compatible: true }
  links: [ https://icons.getbootstrap.com ]
  extractor: svg                 # core's built-in SVG extractor
  config:
    sources:
      - /libraries/bootstrap-icons/icons/*.svg
  settings:
    size: { title: 'Size', description: 'Icon size in pixels.', type: integer, default: 24 }
  template: >-
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"
      class="bi bi-{{ icon_id|clean_class }}"
      width="{{ size|default(24) }}" height="{{ size|default(24) }}"
      fill="currentColor" aria-hidden="true"
    >{{ content }}</svg>
```

- **`extractor: svg`** — core's `svg` icon extractor globs the `config.sources` path(s), one icon
  per matching `.svg` file. The `icon_id` is the filename without extension (e.g.
  `icons/arrow-right.svg` → `bootstrap:arrow-right`). ~2000 icons come from the upstream library.
- **`{{ content }}`** in the template is the inner SVG markup extracted from each file by the `svg`
  extractor; **`{{ icon_id }}`** is the discovered filename, run through `clean_class`. **`size`**
  is the only user-facing setting and is declared `type: integer`.
- Icons inherit text color (`fill="currentColor"`) and are marked `aria-hidden="true"`.

## Rendering an icon

Twig (Icon API `icon()` function):

```twig
{{ icon('bootstrap', 'arrow-right', {size: 24}) }}
{{ icon('bootstrap', 'house') }}
```

PHP render array (`#type => icon`):

```php
$build['x'] = [
  '#type' => 'icon',
  '#pack_id' => 'bootstrap',
  '#icon_id' => 'house',
  '#settings' => ['size' => 24],
];
```

## Querying available icons

Use the core Icon API plugin manager service `plugin.manager.icon_pack`:

```php
$manager = \Drupal::service('plugin.manager.icon_pack');
$icon = $manager->getIcon('bootstrap:house');           // one icon
$all  = array_filter(                                    // all bootstrap icons
  $manager->getIcons(),
  fn($k) => str_starts_with($k, 'bootstrap:'),
  ARRAY_FILTER_USE_KEY,
);
```

## Prerequisite

The pack resolves to nothing until the SVG files exist at
`/libraries/bootstrap-icons/icons/*.svg`. Install the library (see
[../install/library.md](../install/library.md)) and `drush cr` so the discovered icon set is
rebuilt. Verify with `libraries/bootstrap-icons/icons/arrow-right.svg`.
