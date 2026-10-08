<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# experience field type + widget

Files: `src/Plugin/Field/FieldType/ExperienceItem.php`, `ExperienceFieldItemList.php`, `src/Plugin/Field/FieldWidget/ExperienceDefaultWidget.php`.

## Install / add a field

1. Enable: `drush en experience -y` (core `field` is pulled in automatically).
2. On any bundle's **Manage fields** (nodes, users, paragraphs, terms…), add a field of type **Experience** (`id = experience`, category "Number").
3. Set field settings (below), then use the default widget on **Manage form display** and a formatter on **Manage display** (see `fields/formatters.md`).

No global settings page exists; everything is per-field.

## Storage & value model

`ExperienceItem::schema()` defines one column:

- `value` — `int`, `size normal`, `unsigned`, `not null = FALSE`. Holds the **total number of months**.

Encoding (done in `ExperienceDefaultWidget::massageFormValues()`):

- Both selects empty → stored `''` (empty / null).
- Year select = `fresher` → stored `0`.
- Otherwise → `year * 12 + month`.

Decoding (widget `formElement()`, formatters, filter): if `value == 0` → "fresher"; if `value > 11` → `year = floor(value/12)`, `month = value % 12`; else year 0, month = value.

`propertyDefinitions()` exposes a single `value` string property (required). `isEmpty()` is true when `value` is `NULL` or `''` (note: `0` / "Fresher" is NOT empty). `category = "Number"`, `default_widget = experience_default`, `default_formatter = experience_default`.

## Field settings (`defaultFieldSettings()` / `fieldSettingsForm()`)

| Setting | Type | Default | Effect |
|---|---|---|---|
| `label_position` | radios `above` / `within` | `above` | `within` moves the "Year"/"Month" labels into the select as the first (empty) option and hides the visible title. |
| `include_fresher` | checkbox | `0` | Adds a `fresher` option to the year select (stored as `0`). |
| `year_start` | select `0`–`99` | `0` | First selectable year. |
| `year_end` | select `0`–`99` | `30` | Last selectable year. |

The month select is always fixed to `range(0, 11)`.

## Widget (`experience_default`)

`ExperienceDefaultWidget extends WidgetBase` (`field_types = {experience}`). `formElement()` renders a `container-inline` fieldset with two selects (`.year-entry`, `.month-entry`), builds the year option list from `include_fresher` + `range(year_start, year_end)`, applies `label_position`, and attaches library `experience/drupal.experience`. Existing values are pre-split into year/month via the decoding rules above; default values come from the field's default value literal.

## Default value form

`ExperienceFieldItemList extends FieldItemList` overrides `defaultValuesForm()`/`defaultValuesFormSubmit()` to render the same year/month select pair (keys `default_year`, `default_month`) on the field's "Default value" section when no default-value callback is set.

## Client behavior

`experience.js` (`Drupal.experience.FresherHandler`) watches each `.year-entry`; when its value is `fresher` it hides the sibling month select, otherwise shows it. Purely presentational.
