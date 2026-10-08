<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duet Date Picker (duet_date_picker) — agent index

Integrates the accessible **Duet Date Picker** web component (`duetds/date-picker`) into Drupal as
**field widgets** (datetime + daterange) and **Views date filters** (core date, core datetime,
Search API date). Package `Duet Date Picker`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.

> Installed release is a **pre-release beta** (`1.0.0-beta5`); version dir `1.0.x`.

## Dependencies (important)

`info.yml` declares **`dependencies: {}`** and `composer.json` `require: {}` — i.e. **no hard
declared deps**. But the plugins extend core/contrib classes and only work when those modules are
enabled:
- widgets extend **`datetime`** (`DateTimeDefaultWidget`) and **`datetime_range`** (`DateRangeDefaultWidget`);
- Views filters extend **`views`** (`views`/`datetime` `Date`) and **`search_api`** (`SearchApiDate`);
  `duet_date_picker.views.inc` is only loaded when `views` is present.
Enable the relevant module(s) yourself; the missing declarations are a module bug, not a feature.

## Asset library

`duet_date_picker.libraries.yml` defines `duet-date-picker` (and `-esm`), loading the component JS
+ `themes/default.css` from the **local** path `/libraries/duetds--date-picker/dist/duet/…` plus
`assets/js/duetDatePickerLocale.js`. Install the component via `composer require
npm-asset/duetds--date-picker` (asset-packagist, >= 1.4). **No external CDN.**

## What it provides (from source)

- **Field widgets** (`src/Plugin/Field/FieldWidget/`): `DuetDatePickerWidget` (id
  `duet_date_picker`, `datetime` fields), `DuetDateRangePickerWidget` (id `duet_daterange_picker`,
  `daterange` fields). → [fields/widgets.md](fields/widgets.md)
- **Views filters** (`src/Plugin/views/filter/`): `DuetDate` (`duet_date`), `DuetDateTime`
  (`duet_datetime`), `DuetSearchApiDate` (`duet_search_api_date`), swapped in over the core handlers
  by `hook_views_plugins_filter_alter()`. → [plugins/views-filters.md](plugins/views-filters.md)
- **Validation constraint**: `NoPastDates` (`src/Plugin/Validation/Constraint/`) — rejects dates
  before now/today. → [validation/no-past-dates.md](validation/no-past-dates.md)
- **Theme + preprocess** (`duet_date_picker.module`): `duet_date_picker` / `duet_daterange_picker`
  render `templates/duet-date-picker.html.twig` (`<duet-date-picker>` element).
- **Config schema**: widget settings (`duet_date_picker.schema.yml`) + Views filter settings
  (`duet_date_picker.filter.schema.yml`). No permissions, no routes, no services, no Drush.
