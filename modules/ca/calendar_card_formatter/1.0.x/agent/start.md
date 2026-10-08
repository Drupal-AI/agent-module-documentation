<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calendar Card Formatter (calendar_card_formatter) — agent index

A single field formatter that renders a core **`datetime`** field value as a stacked
"calendar card" (month / day / year blocks) instead of a plain date string. Package `Date`.
Depends only on core **`datetime`**. Core requirement `^10 || ^11` (composer allows `^9`).
PHP `>=8.1`. License GPL-2.0-or-later. Version 1.0.1.

- **The formatter, its one setting, how to enable it, the template and CSS** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `CalendarCardFormatter` (id **`calendar_card_formatter`**, label *"Calendar Card
  Formatter"*), in `src/Plugin/Field/FieldFormatter/CalendarCardFormatter.php`, extending core's
  `FormatterBase`. `field_types = { "datetime" }` — targets **core Datetime fields only**.
- No field type, no widget, **no permissions**, no routes, no services, no Drush, no external calls.
  It only changes how a Datetime field is **displayed**, selected per view-display on *Manage display*.
- `calendar_card_formatter.module` implements `hook_theme()` registering the theme hook
  **`calendar_card_formatter`** with variables `value` and `format_value`.
- Ships a Twig template `templates/calendar-card-formatter.html.twig` and a CSS library
  **`calendar_card_formatter/calendar_card_styles`** (`css/styles.css`).

## Mechanism (from source)

- `viewElements()` iterates the field items and, per delta, builds a render array
  `{'#theme' => 'calendar_card_formatter', '#value' => $item->value, '#format_value' => $this->getSetting('date_option')}`.
- The Twig template branches on `format_value` (`day_month_year` / `day_month` / `month_year`) and
  prints date parts via Twig's `date` filter, e.g. `{{ value|date("M") }}`, `{{ value|date("d") }}`,
  `{{ value|date("Y") }}`. Output is Twig-auto-escaped; nothing is rendered raw.

## Settings (formatter, `defaultSettings()`)

- One key: **`date_option`**. Form (`settingsForm()`) is a select with options
  `day_month_year`, `day_month`, `month_year`. `settingsSummary()` prints
  *"Display in format of: @foo"*. Config schema:
  `field.formatter.settings.calendar_card_formatter` in `config/schema/calendar_card_formatter.schema.yml`.
- **Gotcha:** `defaultSettings()` returns `date_option => 'd_m_y'`, which matches **none** of the
  three template branches — so a display using the untouched default renders an empty card until an
  editor opens the formatter settings and selects a real option. Details in
  [fields/formatter.md](fields/formatter.md).
