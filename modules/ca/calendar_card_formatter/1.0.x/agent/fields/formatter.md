<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Calendar Card Formatter" formatter

## Install & enable

```bash
composer require drupal/calendar_card_formatter
drush en calendar_card_formatter -y
```

Only dependency is core **`datetime`**. No sub-modules, no permissions, no Drush commands, no
settings page.

## Enable it on a field

Plugin id **`calendar_card_formatter`**, label *"Calendar Card Formatter"*. It applies to **core
Datetime fields** only (`field_types = { "datetime" }`). It does **not** apply to `daterange`,
`timestamp`, `created`/`changed`, or a plain string/date-string field.

UI path: *Structure → (bundle) → Manage display* → set the Datetime field's format to **Calendar
Card Formatter** → click the gear to pick the layout → *Update* → *Save*.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.event.default \
  content.field_date.type calendar_card_formatter -y
drush cset core.entity_view_display.node.event.default \
  content.field_date.settings.date_option day_month_year -y
drush cr
```

## The one setting

From `defaultSettings()` and `settingsForm()` in `CalendarCardFormatter.php`:

| Setting key | Form options | Meaning |
|---|---|---|
| `date_option` | `day_month_year`, `day_month`, `month_year` | Which card layout the template renders. |

- `settingsSummary()` shows *"Display in format of: @foo"* on the Manage-display summary line.
- Config schema for this setting lives in `config/schema/calendar_card_formatter.schema.yml`
  (`field.formatter.settings.calendar_card_formatter`, a mapping with a single string
  `date_option`).

### Important default-value gotcha

`defaultSettings()` returns `['date_option' => 'd_m_y']`. That string matches **none** of the three
`{% if format_value == '…' %}` branches in the Twig template, so a view-display that uses the
formatter with the untouched default outputs an **empty** `.calendar-card` region. Always open the
formatter settings and explicitly select one of the three options (or set
`settings.date_option` to `day_month_year` / `day_month` / `month_year` in exported config).

## How a value is rendered

`viewElements(FieldItemListInterface $items, $langcode)` loops the items and builds, per delta:

```php
$element[$delta] = [
  '#theme' => 'calendar_card_formatter',
  '#value' => $item->value,
  '#format_value' => $this->getSetting('date_option'),
];
```

`$item->value` is the Datetime field's raw stored string (e.g. `2025-08-29T00:00:00`).

`calendar_card_formatter_theme()` (`hook_theme()` in `calendar_card_formatter.module`) registers
the theme hook `calendar_card_formatter` with variables `value` and `format_value`, mapping to
`templates/calendar-card-formatter.html.twig`.

The template branches on `format_value` and prints date parts with Twig's `date` filter:

- `day_month_year` → `.top.month` = `value|date("M")`, `.bottom.day` = `value|date("d")`,
  `.bottom.year` = `value|date("Y")`.
- `day_month` → `.top.day` = `value|date("d")`, `.bottom.month` = `value|date("M")`.
- `month_year` → `.top.month` = `value|date("M")`, `.bottom.year` = `value|date("Y")`.

All output goes through Twig's default auto-escaping (no `|raw`, no `Markup`); the `date` filter
parses the stored string into a formatted date, so the card shows a date, not arbitrary markup.

## Styling / theming

- The template's first line is `{{ attach_library('calendar_card_formatter/calendar_card_styles') }}`,
  attaching library `calendar_card_styles` (defined in `calendar_card_formatter.libraries.yml`),
  which loads `css/styles.css` in the theme group.
- To restyle, override that CSS or the template in your own theme (copy
  `calendar-card-formatter.html.twig` into your theme's `templates/`). The markup is a
  `.calendar-card` wrapper with `.top` and `.wrapper` > `.bottom` blocks carrying `month`/`day`/`year`
  modifier classes.

## Notes / caveats

- Timezone: the `date` filter formats `$item->value` with Twig's date handling; the module does no
  explicit timezone conversion, so cards reflect the raw stored value.
- Only the three listed layouts exist; there is no free-form PHP date-format setting.
- No config schema issue beyond the default-value mismatch above — the formatter settings do have a
  schema entry.
