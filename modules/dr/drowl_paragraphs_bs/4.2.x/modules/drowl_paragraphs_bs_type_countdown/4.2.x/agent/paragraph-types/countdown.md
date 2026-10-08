<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Countdown' paragraph type (drowl_paragraphs_bs_type_countdown)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_countdown -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `drupal:datetime`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_date` (datetime; storage shipped here), a color-scheme field (`field_color_scheme`, from the base module) and `field_settings`.

## Template

`templates/paragraph--drowl-paragraphs-bs--countdown.html.twig` computes `paragraph.field_date.0.date|date('U')` and a color scheme escaped with `|e('html_attr')`, attaches the `drowl_paragraphs_bs_type_countdown/global` library, and outputs `<div id="countdown-{id}" class="countdown" data-target-date="{ts}" data-countdown-theme="{theme}"></div>` plus a `.countdown-no-js-fallback` block printing `format_date('short')`.

## JS & library

`js/drowl_paragraphs_bs_type_countdown.js` (`Drupal.behaviors.drowl_paragraphs_bs_type_countdown`) reads `data-target-date`/`data-countdown-theme`, calls `new FlipDown(targetTimestamp, countdownId, {headings, theme}).start()` and hides the fallback. `drowl_paragraphs_bs_type_countdown.libraries.yml` `global` loads `/libraries/flipdown/dist/flipdown.min.{js,css}` plus the module's own dist assets.

## Install requirement

`hook_requirements()` (runtime) raises `REQUIREMENT_ERROR` if `/libraries/flipdown/dist/flipdown.min.js` or `.css` is absent; install FlipDown (>=0.3), e.g. `composer require npm-asset/flipdown`.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
