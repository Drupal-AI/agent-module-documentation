<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Forms Date & Date of Birth elements

Two Webform elements rendering a date as three text inputs (Day / Month / Year), following the
GOV.UK Design System date-input pattern. Each has a **FormElement** class (the render element) and a
**WebformElement plugin** (the builder-facing element type).

## Install & enable

```bash
drush en localgov_forms_date -y
```

Depends on `webform` + the parent `localgov_forms`. Then add a *LocalGov Forms Date* or
*LocalGov Forms Date of Birth* element (category **LocalGov Forms**) to a webform.

## Element ids & classes

| id | FormElement (`src/Element`) | WebformElement (`src/Plugin/WebformElement`) | Label |
|---|---|---|---|
| `localgov_forms_date` | `LocalgovFormsDate` | `LocalgovFormsDate` | LocalGov Forms Date |
| `localgov_forms_dob` | `LocalgovFormsDOB` (extends Date) | `LocalgovFormsDOB` (extends Date) | LocalGov Forms Date of Birth |

The FormElement classes extend core `Drupal\Core\Datetime\Element\Datelist`; the WebformElement
plugins extend `Drupal\webform\Plugin\WebformElement\DateList`. `localgov_forms_dob` only adds the
description hint "For example 08/02/1982".

## Configurable properties (`LocalgovFormsDate::defineDefaultProperties()`)

- `date_min` / `date_max` — earliest/latest acceptable date (core webform date properties). Their
  min/max messages come from Webform itself and are **not** overridable here.
- `date_invalid_error` — **Invalid date message**: custom wording for the "not a real date /
  missing part" case. Added to the config form under *Form validation* (after webform's own
  *Required message*, weight 10, maxlength 255) and registered translatable via
  `defineTranslatableProperties()`. Blank → default wording.
- Fixed: `date_part_order` and `date_text_parts` are forced to `['day','month','year']` (the config
  form hides the reordering/other controls; `validateConfigurationForm()` re-asserts them),
  `date_year_range` `1900:2050`, `date_increment` 1, `date_abbreviate` TRUE,
  `#options_display` `side_by_side`.

`afterBuild()` sets each part's title (Day/Month/Year), placeholder (DD/MM/YYYY), `maxlength`
(2/2/4), `inputmode="numeric"`, `pattern="[0-9]*"`, and per-part class
`localgov_forms_date__day|__month|__year`.

## Validation (the point of the module)

The render element's `#element_validate` runs, in order: `areDatePartsNumeric` then
`validateDatelist`. Ordering matters — FormState keeps only the first error per element, so the most
specific check reports first.

- **`valueCallback()`** wraps core's. It records the correct wording for complete-but-invalid input
  during form build (because core's `Datelist::valueCallback()` would otherwise set "Selected
  combination of day and month is not valid." too early to override), and on **Drupal 10** it
  catches the `\TypeError` core throws for a non-numeric part (D10's `checkArray()` passes raw
  strings to `checkdate()`); D11 raises `\InvalidArgumentException` which core already handles.
  Without this catch the element fatals on D10.
- **`areDatePartsNumeric()`** flags any of day/month/year that is non-numeric
  ("The day in @title must be a number."), and `restoreUnprocessedDate()` puts the raw typed value
  (e.g. `1A`) back into the box so the user sees what they entered, not a coerced `1`.
- **`validateDatelist()`** mirrors core's branch decisions but supplies the module's wording:
  - all empty + required → `getRequiredErrorMessage()` (uses `#required_error` verbatim, else
    "@title is required.");
  - some parts empty → `getIncompleteErrorMessage()` ("@title must include a @parts", or
    `date_invalid_error`);
  - filled but not a real date → `getInvalidErrorMessage()` ("@title must be a real date", or
    `date_invalid_error`).
  `@title` comes from `getErrorTitle()` (core's element title helper, falling back to "Date"), so
  messages never duplicate the word "date" the way core's do.

The WebformElement plugin also:

- `validateDate()` sets `#date_date_format` / `#date_time_format` from the shipped
  `localgov_forms_date_short_date` (`d-m-Y`) and `localgov_forms_date_datetime`
  (`d-m-Y\TH:i:sO`) date-format entities before delegating to the parent, so range-error messages
  read in UK style.
- `preValidateDate()` repeats core's workaround to ensure the datetime object lands on the
  form-state input (localgovdrupal/localgov_forms#124).
- `setDefaultValue()` temporarily pretends `#type` is `datelist` so core's `DateBase::setDefaultValue()`
  handles it (important inside composite/multi-page forms).

## Date-format config entities

`config/install/core.date_format.localgov_forms_date_short_date.yml` (`pattern: d-m-Y`) and
`…_datetime.yml` (`pattern: 'd-m-Y\TH:i:sO'`). For sites that predate the config-install file,
`localgov_forms_date.install` update hooks `_update_8001`/`_8002` create them and `_8003` back-fills
a UUID. Styling via `css/date.css` (library `localgov_forms_date`), attached by
`hook_preprocess_datetime_form()` for these element types.
