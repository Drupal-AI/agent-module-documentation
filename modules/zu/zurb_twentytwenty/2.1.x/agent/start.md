<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TwentyTwenty (zurb_twentytwenty) — agent index

One image-field formatter that turns a 2-value image field into a ZURB TwentyTwenty
before/after slider. No config form, no permissions, no config schema, no Drush.
Depends on core `image` + `field`.

- **Enabling the formatter, every setting, and the required third-party library** →
  [configure/formatter.md](configure/formatter.md)
- **Theme hook, template, library, and the drupalSettings limitation** →
  [theming/markup.md](theming/markup.md)

Key facts:
- Formatter plugin id **`twentytwenty_field_formatter`**, label *TwentyTwenty*,
  `field_types = {image}`, class `TwentyTwentyFieldFormatter extends ImageFormatterBase`.
- **The JS/CSS library is not bundled and not installed by Composer.** It must be unpacked at
  `/libraries/twentytwenty/` (from https://github.com/zurb/twentytwenty).
  `zurb_twentytwenty_requirements()` checks `/libraries/twentytwenty/js/jquery.twentytwenty.js`
  at both `install` and `runtime` and reports `REQUIREMENT_ERROR` when absent — the formatter
  still renders both images, they just stack without a slider.
- The field should have **cardinality exactly 2**; the settings summary warns otherwise. There is
  no validation preventing 1 or unlimited — with more than two values the plugin compares the
  first two and the rest render inside the container.
- Settings (`defaultSettings()`): `image_style` (''), `default_offset_pct` ('0.5'),
  `orientation` ('horizontal'), `before_label` ('Before'), `after_label` ('After'),
  `no_overlay` (false), `move_slider_on_hover` (false), `move_with_handle_only` (true),
  `click_to_move` (false).
- Theme hook `zurb_twentytwenty` (template `zurb-twentytwenty.html.twig`) with a single
  `images` variable; the library is attached from `template_preprocess_zurb_twentytwenty()`.
- **Known limitation:** settings are written to a *global* `drupalSettings.twentytwenty` key, not
  per-instance. Two TwentyTwenty fields on one page share whichever settings were attached last.
