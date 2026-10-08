<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Score' paragraph type (drowl_paragraphs_bs_type_score)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_score -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `micon:micon`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_score_start`, `field_score_end`, `field_score_max` (decimals; storages shipped here), `field_score_prefix`/`_suffix`/`_max_prefix`/`_max_suffix` (strings; storages shipped here), `field_icon`, `field_text`, and `field_settings`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_score_preprocess_paragraph()` (bundle `score`) writes `field_score_*` values to `data-score-start/-end/-max/-prefix/-suffix/-max-prefix/-max-suffix` on `score_attributes`. It then maps UI-Styles classes to data attributes / CSS variables: `score--type-*` -> `data-score-type`, `score--value-display-*` -> `data-score-value-display`, and `score--bar-color-*`/`score--bar-end-color-*`/`score--line-color-*` / `icon__text*` into an inline `style` string of `--bar-color`/`--bar-end-color`/`--line-color`/`--icon-color` CSS custom properties (as `var(--bs-*)`).

## Template & JS

`templates/paragraph--drowl-paragraphs-bs--score.html.twig` sets static `data-score-*` sizing/animation attributes, attaches `drowl_paragraphs_bs_type_score/global`, and outputs a `.score` wrapper with a `.score__progressbar` target, optional `.score__text` and a hidden `.score__icon`. `js/drowl_paragraphs_bs_type_score.js` reads the data attributes, resolves colours from the CSS variables, builds the gauge with `ProgressBar.Line/Circle/SemiCircle`, and animates it via an `IntersectionObserver`.

## Install requirement

`hook_requirements()` raises `REQUIREMENT_ERROR` when `/libraries/progressbar.js/dist/progressbar.min.js` is missing; install progressbar.js (>=1), e.g. `composer require npm-asset/progressbar.js`.

## UI Styles

`drowl_paragraphs_bs_type_score.ui_styles.yml` defines score type, text position, value display, line colour, and bar start/end colours.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
