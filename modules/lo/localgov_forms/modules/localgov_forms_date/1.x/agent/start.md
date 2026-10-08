<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Forms: Date (localgov_forms_date) — agent index

Submodule of **localgov_forms**. Provides two GOV.UK-Design-System-style date Webform elements
(three text boxes: Day / Month / Year) with rewritten, plain-English validation. Package
`LocalGov Drupal`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir `1.x` (installed 1.2.0).

Dependencies (info.yml): `webform:webform`, `localgov_forms:localgov_forms`. No permissions, no
routes, no services, no config schema. Ships two `core.date_format` config entities.

## Solution docs

- **The date & date-of-birth elements, settings, validation, date formats** → [elements/date.md](elements/date.md)

## What it provides (from source)

- **Form elements** (`src/Element`, extend core `Datelist`):
  - `localgov_forms_date` → `LocalgovFormsDate` — day/month/year datelist, `#date_year_range`
    `1900:2050`, custom `#element_validate` (`areDatePartsNumeric` then `validateDatelist`).
  - `localgov_forms_dob` → `LocalgovFormsDOB` (extends the above, adds example description
    "For example 08/02/1982").
- **WebformElement plugins** (`src/Plugin/WebformElement`, extend Webform `DateList`):
  - `localgov_forms_date` → `LocalgovFormsDate` (label *LocalGov Forms Date*, category
    *LocalGov Forms*). Adds an **Invalid date message** (`date_invalid_error`) config field,
    forces day/month/year order, sets numeric input attributes in `afterBuild()`, and formats
    validation errors with the UK date-format entities in `validateDate()`.
  - `localgov_forms_dob` → `LocalgovFormsDOB` (label *LocalGov Forms Date of Birth*).
- **Config install** (`config/install`): `core.date_format.localgov_forms_date_short_date`
  (`d-m-Y`) and `core.date_format.localgov_forms_date_datetime` (`d-m-Y\TH:i:sO`). Install-file
  update hooks (`_update_8001/8002/8003`) create/UUID these for existing sites.
- **Hook**: `hook_preprocess_datetime_form()` adds class `localgov-forms-date` and library
  `localgov_forms_date/localgov_forms_date` (`css/date.css`) to these elements.

## Security-relevant facts (public, neutral)

- Pure form element: no routes, no services, no external HTTP, no DB queries. Validation messages
  are built with `t()` and `@title` placeholders (escaped); `date_invalid_error`/`required_error`
  are element settings authored by the form builder.
