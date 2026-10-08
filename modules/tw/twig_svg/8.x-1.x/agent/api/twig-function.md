<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `icon()` Twig function (API)

## Registration

`Drupal\twig_svg\TwigExtension\TwigSvg` extends `Twig\Extension\AbstractExtension` and is registered
as the service `twig_svg.twig.extension` (tagged `twig.extension`). It exposes one function:

```php
// src/TwigExtension/TwigSvg.php
new TwigFunction('icon', [$this, 'getInlineSvg']);
```

## Signature

```twig
{{ icon(name, title, classes, attributes, wrapper_classes) }}
```

Callback `TwigSvg::getInlineSvg($name, $title = '', array $classes = [], array $attributes = [], array $wrapper_classes = [])`
(TwigSvg.php:52) resolves the `twig_svg.twig_svg_helper` service and returns
`TwigSvgHelper::buildSvg(...)`.

| Arg | Type | Default | Purpose |
|---|---|---|---|
| `name` | string | — | Symbol id. Becomes the `<use xlink:href="#NAME">` fragment and a default class `icon--NAME`. |
| `title` | string | `''` | When non-empty the `<svg>` gets `role="img" title="…" aria-label="…"`; when empty it gets `aria-hidden="true"`. |
| `classes` | array | `[]` | Extra classes, merged after the defaults `['icon', 'icon--NAME']`. |
| `attributes` | array | `[]` | Extra attributes as `key => value`, merged after the default `focusable => 'false'`. |
| `wrapper_classes` | array | `[]` | Extra classes on the outer `<span class="icon__wrapper …">`. |

Examples (from README):

```twig
{{ icon('icon-name') }}
{{ icon('icon-name', 'Icon title') }}
{{ icon('icon-name', '', ['extra-class', 'another-class']) }}
{{ icon('icon-name', 'Icon title', ['extra-class', 'another-class']) }}
```

## What it builds

`TwigSvgHelper::buildSvg` (TwigSvgHelper.php:27) returns a render array — it does **not** read any
file:

```php
return [
  '#theme' => 'twig_svg',
  '#title' => $title,
  '#classes' => implode(' ', $classes),      // 'icon icon--NAME …'
  '#attributes' => $attributes_string,       // ' focusable="false" …'
  '#name' => $name,
  '#wrapper_classes' => implode(' ', $wrapper_classes),
];
```

## Theme hook & template

`twig_svg_theme()` declares the `twig_svg` theme hook with variables `classes`, `attributes`,
`title`, `name`, `wrapper_classes`. Template `templates/twig-svg.html.twig` renders:

```twig
<span class="icon__wrapper {{ wrapper_classes }}">
  <svg role="img" title="{{ title }}" aria-label="{{ title }}" class="{{ classes }}" {{ attributes }} xmlns:xlink="…">
    {# or, with no title: <svg aria-hidden="true" class="{{ classes }}" {{ attributes }} …> #}
    <use xlink:href="#{{ name }}"></use>
  </svg>
</span>
```

All of `title`, `classes`, `attributes` and `name` print through Twig's autoescaping. Note that
because `#attributes` is a plain string (not a `Drupal\Core\Template\Attribute` object), the
`{{ attributes }}` output is HTML-escaped, so the `attributes` argument renders escaped rather than as
live attributes — override the template if you need real extra attributes.

## The `<use>` reference needs a sprite

`icon('arrow')` only emits `<use xlink:href="#arrow">`. The `<symbol id="arrow">` it points at must be
inlined into the same page — that is done by config/theme sprite injection, see
[../configure/settings.md](../configure/settings.md).
