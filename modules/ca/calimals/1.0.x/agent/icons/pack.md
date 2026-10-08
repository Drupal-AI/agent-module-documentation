<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calimals icon pack (calimals.icons.yml)

The entire module is one UI Icons pack definition plus SVG assets. This is the full contract.

## The pack definition (`calimals.icons.yml`)

Top-level key = pack id **`calimals`**:

- `enabled: true`
- `label: "Calimals"`, `description: "The animal-friendly Calimals icon pack for UI Icons."`
- `version: 1.0.0` (pack version string, distinct from the module release 1.0.5)
- `extractor: svg` — UI Icons' built-in SVG extractor; each icon's inner SVG is inlined.
- `config.sources: [ /modules/contrib/calimals/icons/*.svg ]` — glob, relative to the Drupal root.
  Each matched file becomes an icon whose **id is the filename stem** (e.g. `cat.svg` → `cat`,
  `red-panda.svg` → `red-panda`).
- `settings.size` — one declared setting: type `integer`, title `"Size"`, **default `64`**.
- `template` — Twig that emits the wrapper `<svg>`:
  - adds classes `calimals` and `calimals--{{ icon_id|clean_class }}`,
  - `viewBox` = `attributes.viewBox|default('0 0 2400 2400')`,
  - `width`/`height` = `size|default('64')`,
  - `aria-hidden="true"`,
  - inner `{{ content }}` = the extracted SVG body.

## Icons provided (33)

alpaca, capricorn, capybara, cat, cow, dragon, duck, flamingo, frog, giraffe, hedgehog, hippo,
kitten, lemur, lion, llama, monoceros, mouse, ostrich, panda, parrot, phoenix, pig, poulet,
rabbit, red-panda, sheep, squirrel, teddy, toucan, unicorn, wildebeest, zebra.

(`calimals.icons.yml` alone is the pack; the icons live under `icons/`. There is also a decorative
`logo.svg`/`logo.png` and `icons/` assets — only files matching the `icons/*.svg` glob become icons.)

## Enable

```
drush en calimals -y      # ui_icons is a hard dependency and installs with it
```

No settings form, no permissions, nothing to configure. Enabling registers the pack; disabling
removes it from the pickers.

## Using the icons

Anywhere UI Icons exposes an icon picker (menu links, link/icon fields and their formatters,
CKEditor icon button, blocks, UI Patterns / SDC component props) the `calimals` pack appears and
its 33 icons are selectable.

In Twig, via UI Icons' `icon()` function:

```twig
{{ icon('calimals', 'cat', { size: 48 }) }}
{{ icon('calimals', 'red-panda') }}   {# defaults to size 64 #}
```

`size` is the only pack-specific option; it maps to the `<svg>` `width`/`height`. Output is
`aria-hidden`, so icons are decorative by default — pair with visible text or an explicit label
where the icon must convey meaning.

## Notes

- Icons are static, version-controlled SVGs shipped by the maintainer (not user-uploaded), rendered
  through UI Icons' standard `svg` extractor and Twig template.
- The `config.sources` path is hard-coded to `/modules/contrib/calimals/icons/*.svg`; installing the
  module outside `modules/contrib` would mean the glob finds nothing.
- There is no `.install`, no config export, and no schema — nothing to sync with
  `drush config:export`; the pack is discovered from the module directory at runtime.
