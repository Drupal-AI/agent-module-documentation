<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Font Awesome Formatter for Int List (fa_formatter) — agent index

A single field formatter that renders a core **`list_integer`** field as a fixed row of icons —
the stored value as "on" icons plus the remaining allowed-value slots as "off" icons (a star-rating
display). Package `Custom`. **No module dependencies.** Core requirement `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 2.0.3 (`8.x-1.2` was the D7/D8-era release; this is the `2.0.x` line).

- **The formatter, its one setting, how to enable it, and the exact markup it emits** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is (from source)

- One plugin: `FAFormatterInt` (id **`fa_formatter_int`**, label *"FA Int Formatter"*), in
  `src/Plugin/Field/FieldFormatter/FAFormatterInt.php`, extending core's `FormatterBase`.
  `field_types = { "list_integer" }` — it targets **core list(integer) fields only**.
- **No field type, no widget, no routes, no permissions, no services, no hooks, no Drush.** The
  whole project is 6 files: `.info.yml`, `.libraries.yml`, one plugin class, one CSS file, and a
  config schema.
- One config schema: `config/schema/fa_formatter.schema.yml` defines
  `field.formatter.settings.fa_formatter_int` with a single `icon_class` string key.
- One asset library: `fa_formatter/fa_formatter.usage` (CSS only, `css/fa_formatter_style.css`) —
  styles `.rate-image.star-on` (yellow) / `.star-off` (grey) and hides `.rate-value` off-screen.
  Attached automatically by the formatter.

## Mechanism

- `defaultSettings()` → `icon_class` default **`<i class="fas fa-star"></i>`** (raw icon HTML, not
  just a class). `settingsForm()` exposes it as a single textfield; `settingsSummary()` prints a
  static *"Displays the Stars"*.
- `viewElements()` computes the maximum from the field's own `allowed_values`
  (`count($allowed_values['allowed_values'])`), then per item emits a `<span class="fa-formatter">`
  containing the value (in an off-screen `.rate-value` span), `value` copies of the icon with class
  `star-on`, and `max - value` copies with `star-off`, as a `#markup` render element with the CSS
  library attached. Empty field → a literal *"Noch keine Bewertung."* message.

## Notes

- Ships **no icon library**; the site's theme/another module must load Font Awesome (or you paste
  markup for any other icon font). Missing library → blank space.
- The formatter settings have a config **schema**, but the module provides **no admin/settings
  route** (`configure` is null) — everything is set per view-display on *Manage display*.
