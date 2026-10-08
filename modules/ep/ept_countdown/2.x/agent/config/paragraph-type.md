<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ept_countdown` paragraph type — fields, widget, template, JS

## Install & enable

```bash
composer require drupal/ept_countdown
drush en ept_countdown -y
```

Pulls in `ept_core` and `paragraphs`; core `datetime` is required too. The animated widget needs
the **FlipDown.js** front-end library at `/libraries/flipdown` — `composer require
levmyshkin/flipdown` (listed in this module's `composer.json`) or install it manually. The library
definition (`ept_countdown.libraries.yml`) points CSS/JS at
`/libraries/flipdown/dist/flipdown.min.{css,js}`; if the folder is missing the timer will not render.

Enabling installs (from `config/install/`): the Paragraphs type `ept_countdown`, four field
instances, and the default form + view displays. No update hooks, no permissions.

## Fields on the bundle

| Field | Type | Notes |
|---|---|---|
| `field_ept_countdown_date` | `datetime` (`datetime_type: datetime`, cardinality 1, **required**) | The target date/time counted down to. |
| `field_ept_title` | `text_long` | Optional heading shown above the timer. |
| `field_ept_text` | `text_long` | Optional description text. |
| `field_ept_settings` | `ept_settings` (from ept_core) | Holds the countdown options **and** the shared design options. Rendered with widget `ept_settings_countdown`, formatter `ept_settings_default`. |

Form display groups fields into a **Content** tab (title, text, date) and a **Settings** tab
(`field_ept_settings`) via `field_group` (`core.entity_form_display.paragraph.ept_countdown.default.yml`).

## Widget: `EptSettingsCountDownWidget` (id `ept_settings_countdown`)

`src/Plugin/Field/FieldWidget/EptSettingsCountDownWidget.php` extends
`Drupal\ept_core\Plugin\Field\FieldWidget\EptSettingsDefaultWidget`. `formElement()` calls the
parent (which builds the design-options tree: CSS box margins/borders/padding, background
color/image/video, edge-to-edge, container width, title wrapper/strip-tags) and then adds:

- `pass_options_to_javascript` — hidden, forced `TRUE` (so ept_core exposes this paragraph's
  options to `drupalSettings`).
- `color_theme` — radios `dark` | `light` (default `dark`).
- `styles` — radios `default` | `new_year` (default `default`).
- `heading_days` / `heading_hours` / `heading_minutes` / `heading_seconds` — textfields, default
  the translated words "Days" / "Hours" / "Minutes" / "Seconds". These become the FlipDown unit
  labels.

`massageFormValues()` just ensures each delta has an `ept_settings` key. There is **no config
schema** shipped by this module for these keys; ept_core's schema covers only
`pass_options_to_javascript` and `design_options`, so strict config-schema tooling may warn on the
countdown-specific keys — they still save and work.

## Template & how the date reaches the browser

`templates/paragraph--ept-countdown--default.html.twig`:

- Adds body/paragraph classes including the selected `styles` and `color_theme` values.
- If `styles == 'new_year'` attaches library `ept_countdown/new_year` (snow effect); always
  attaches `ept_countdown/ept_countdown`.
- Renders the optional title inside a wrapper chosen by `title_options.title_wrapper`
  (`h1`–`h5`, `none`, default `h2`), optionally `striptags`-filtered.
- Emits the timer mount point:
  ```
  <div class="ept-countdown-date … flipdown"
       id="paragraph-id-{{ paragraph.id() }}"
       data-date="{{ content.field_ept_countdown_date[0]['#attributes']['datetime']|date('U') }}">
  ```
  i.e. the target date is converted to a **Unix timestamp** and placed in `data-date`.
- Prints ept_core's generated per-paragraph `<style>` via `{{ styles|raw }}` (that string is built
  server-side in `GenerateCSS::generateFromSettings()` with `Html::escape()` on user values).

`js/ept_countdown.js` (`Drupal.behaviors.eptCountDown`, using `core/once`): for each
`.ept-countdown-date`, reads `drupalSettings.eptCountdown['paragraph-id-N'].options` and the
`data-date` timestamp, then runs
`new FlipDown(timestamp, id, { theme: color_theme, headings: [days, hours, minutes, seconds] }).start()`.

The `drupalSettings.eptCountdown` payload is populated by ept_core's `EptCoreHooks::paragraphView()`
(`hook_ENTITY_TYPE_view`): it camel-cases the bundle (`ept_countdown` → `eptCountdown`) and attaches
`{ paragraphClass, options }` keyed by `paragraph-id-N`, only when `pass_options_to_javascript`
is not `FALSE`. `EptCoreHooks::preprocessParagraph()` supplies the `styles` variable and any
background media JS.

## Styling defaults site-wide

There is no route in this module. EPT-wide defaults (primary/secondary colors, mobile/tablet/desktop
breakpoints, container widths) are the `ept_core.settings` config edited at
*Administration » Configuration » Content authoring » Extra Paragraph Types (EPT) settings*
(`/admin/config/content/ept-core`), and apply to every EPT paragraph including this one.

## Operate it

1. Add an **EPT Countdown** paragraph to a paragraphs-enabled field.
2. On the **Content** tab set the required **Countdown date** (and optional title/text).
3. On the **Settings** tab pick color theme, style, unit headings, and any design options.
4. Save and view; FlipDown animates the remaining time to the target date.
