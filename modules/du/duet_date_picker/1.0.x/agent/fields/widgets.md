<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widgets: Duet Date Picker & Duet Date Range Picker

Two widgets in `src/Plugin/Field/FieldWidget/`. Both extend a core default widget, attach the Duet
library, re-`#theme` the date sub-element(s) as `duet_date_picker`, and convert submitted values to
`DrupalDateTime`.

## Install & enable

```bash
composer require drupal/duet_date_picker npm-asset/duetds--date-picker
drush en duet_date_picker -y
```

`npm-asset/duetds--date-picker` requires asset-packagist in `composer.json` (see README); it installs
the web component to `/libraries/duetds--date-picker` where the library file expects it. Also ensure
core **`datetime`** (and **`datetime_range`** for the range widget) is enabled — the module does not
declare these deps.

## DuetDatePickerWidget (`duet_date_picker`)

- `@FieldWidget(id = "duet_date_picker", field_types = {"datetime"})`, extends
  `Drupal\datetime\Plugin\Field\FieldWidget\DateTimeDefaultWidget`, implements
  `TrustedCallbackInterface`.
- `formElement()` calls `parent::formElement()`, then `#attached[library][] =
  'duet_date_picker/duet-date-picker'`.
- **Date-only** field: the `value` element is themed `duet_date_picker`.
- **Date + time** field (`#date_time_element` != `none`): splits into a `date_value` element (themed
  as Duet, `#date_time_element`/`#date_time_format` cleared) for the date, leaving the core `value`
  element for the time only.
- Registers a process callback `dateDateCallback` via `#date_date_callbacks[]`; sets
  `#no_past_dates`, `#label` (from settings), and unsets the default `#title`.
- Multi-value: for empty deltas > 0 with cardinality != 1, the element is blanked to suppress extra
  empty Duet inputs.
- If `no_past_dates` is on, `$this->fieldDefinition->addConstraint('NoPastDates')` is added.

### Value handling

- `dateDateCallback(&$element, $form_state, $date)` reads raw user input by field name + delta and
  builds the value:
  - datetime field: `new DrupalDateTime($date_value['date_value'] . 'T' . $date_value['value']['time'])`;
  - date-only field: `new DrupalDateTime($date_value['value'])`;
  - empty → `NULL` (element cleared from input). Result set via `setValueForElement()`.
- `massageFormValues()` re-derives the `value` as a `DrupalDateTime` from user input, then calls
  `parent::massageFormValues()`. All parsing is via `DrupalDateTime` (no eval/string SQL).

### Settings (`defaultSettings()` / `settingsForm()`)

| Key | Default | Meaning |
|---|---|---|
| `label` | `Choose a date` | Visible picker label (required textfield); passed to the template as `#label`. |
| `no_past_dates` | `FALSE` | Checkbox. Feeds today's date as the picker `min` and adds the `NoPastDates` constraint. |

Only `no_past_dates` is in config schema (`field.widget.settings.duet_date_picker`).

## DuetDateRangePickerWidget (`duet_daterange_picker`)

- `@FieldWidget(id = "duet_daterange_picker", field_types = {"daterange"})`, extends
  `Drupal\datetime_range\Plugin\Field\FieldWidget\DateRangeDefaultWidget`.
- Same pattern for both ends: themes `value`/`end_value` (or `date_value`/`end_date_value` when the
  field carries time) as `duet_date_picker`, attaches the library, registers `dateDateCallback` on
  both, sets `#no_past_dates` and per-end labels, unsets `#title`.
- `dateDateCallback` / `massageFormValues()` build `value` and `end_value` as `DrupalDateTime`.

### Settings

| Key | Default | Meaning |
|---|---|---|
| `start_label` | `Choose a start date` | Start picker label (required). |
| `end_label` | `Choose an end date` | End picker label (required). |
| `no_past_dates` | `FALSE` | Applies `min` + `NoPastDates` to both ends. |

Schema: `field.widget.settings.duet_daterange_picker` (only `no_past_dates`). README warns the base
daterange widget does not verify start ≤ end (see core issue 2847041).

## Theme / template

`hook_theme()` registers `duet_date_picker` (base hook `datetime_default`) and
`duet_daterange_picker` (base hook `daterange_default`). `hook_preprocess_duet_date_picker()`
formats `#default_value` (a `DrupalDateTime` → `Y-m-d`), sets `make_required` from `#required`, and
sets `min_date = date('Y-m-d')` when `#no_past_dates`. `templates/duet-date-picker.html.twig`
renders a `<duet-date-picker identifier name value min>` element (all attributes Twig-autoescaped).
`assets/js/duetDatePickerLocale.js` localizes the component via `Drupal.t()` and switches locale to
`fr-FR` when the current language is `fr`.

## Configure on a field

Manage form display of the bundle → set the date/daterange field's widget to **Duet Date Picker** /
**Duet Date Range Picker** → gear icon for label + "Disallow past dates". No code needed.
