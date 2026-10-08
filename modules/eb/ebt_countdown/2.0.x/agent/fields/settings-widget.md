<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Countdown — settings widget, templates & JS

## Widget: `ebt_settings_countdown`

`src/Plugin/Field/FieldWidget/EbtSettingsCountDownWidget.php` — `@FieldWidget` id
`ebt_settings_countdown`, label *"EBT Countdown settings"*, `field_types = { "ebt_settings" }`.
Extends `ebt_core`'s `EbtSettingsDefaultWidget`, so it inherits all EBT Core design options and adds,
in `formElement()`:

- `pass_options_to_javascript` — `#type => hidden`, `#value => TRUE`. Forces EBT Core to attach this
  block's settings to `drupalSettings` (default is FALSE).
- `color_theme` — `radios`, options `dark` / `light`, default `dark`.
- `styles` — `radios`, options `default` / `new_year`, default `default`.
- `heading_days`, `heading_hours`, `heading_minutes`, `heading_seconds` — free-text `textfield`s,
  defaulting to the translated "Days"/"Hours"/"Minutes"/"Seconds". These become the FlipDown rotor
  headings.

`massageFormValues()` just ensures each delta has an `ebt_settings` key. Values are stored in the
`field_ebt_settings` field.

## How settings reach the browser

This module has **no** `.module`/hook. `ebt_core`'s `EbtCoreHooks::blockContentView()`
(`hook_block_content_view`) does the work for any `ebt_*` bundle: when `pass_options_to_javascript`
is TRUE it attaches
`drupalSettings[<camelBundle>][<wrapperId>] = ['blockClass' => …, 'options' => <ebt_settings>]`.
For `ebt_countdown` the camel-cased key is **`ebtCountdown`**, and `<wrapperId>` is
`block-revision-id-<rev>` (Layout Builder inline) and `plugin-id-block-content<uuid>` (reusable
block content).

## Templates

- `templates/block--block-content--ebt-countdown.html.twig` (reusable blocks) and
  `templates/block--inline-block--ebt-countdown.html.twig` (Layout Builder inline blocks).
- Both build a wrapper `<div>` whose `id` is `plugin-id-…` / `block-revision-id-…` (matching the
  `drupalSettings` key), add classes including the chosen `styles` and `color_theme`, and attach the
  `ebt_countdown/ebt_countdown` library (plus `ebt_countdown/new_year` when `styles == 'new_year'`).
- The timer element:
  `<div class="ebt-countdown-date … flipdown" id="block-id-…"
   data-date="{{ content.field_ebt_countdown_date[0]['#attributes']['datetime']|date('U') }}">` —
  the datetime is rendered as a **Unix timestamp** into `data-date`.
- `{{ content|without('field_ebt_settings','field_ebt_countdown_date') }}` renders the remaining
  content (Body, label). The trailing `{{ styles|raw }}` is the CSS string produced by EBT Core's
  design-options generator (not this module).

## JS: `js/ebt_countdown.js`

`Drupal.behaviors.ebtCountDown` uses `once('ebt-countdown-block', '.ebt-countdown-date', context)`.
For each timer it finds the closest `.ebt-block-countdown` wrapper, reads its `id`, looks up
`drupalSettings['ebtCountdown'][id]`, parses `data-date` with `parseInt(..., 10)`, and — if the
global `FlipDown` function exists — calls:

```
new FlipDown(countdownTimestamp, countdownId, {
  theme: ebtOptions.options.color_theme,
  headings: [heading_days, heading_hours, heading_minutes, heading_seconds],
}).start();
```

Missing wrapper / settings / invalid timestamp / missing library are handled with
`console.warn`/`console.error` and an early return (defensive, no throw). FlipDown renders headings
via `setAttribute('data-before', …)` and clock digits via `textContent`.

## Libraries & assets (`ebt_countdown.libraries.yml`)

- `ebt_countdown` — CSS `/libraries/flipdown/dist/flipdown.min.css` + `css/flipdown.css`; JS
  `/libraries/flipdown/dist/flipdown.min.js` + `js/ebt_countdown.js`; deps `core/once`,
  `core/drupal`, `core/drupalSettings`.
- `new_year` — CSS `css/new-year.css` (decorative snowflakes; image `img/snowflakes.webp`), attached
  only when the *New Year* style is selected.
