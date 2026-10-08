# Age Field Formatter — manual setup guide

**Age Field Formatter** (`age_field_formatter`) is a field formatter that takes the
value of a core **datetime** field and displays the age it represents — the number
of whole years between that date and today. It is most often used to turn a stored
birthdate into a live "age", but it works equally well for anything measured in
years: an employee's tenure from a start date, a product's vintage, an account's
age, a piece of equipment's age, and so on.

There is nothing to configure globally — the module has no settings page and no
permissions. You simply choose **Age formatter** as the display format for a
datetime field on an entity's **Manage display** tab, then set a couple of options
in the format's settings. The age is recalculated every time the field is rendered,
so it is always current.

Three display modes are available: show the date followed by `(Age: 42)`, show the
date followed by `(42)` without the "Age:" label, or show just the number. An
optional suffix appends a correctly pluralised "year"/"years", and you can format
the accompanying date with any PHP date pattern. The module depends only on core's
**Datetime** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Make sure the entity has a **datetime** field to read from (for example a
   `field_birthdate` on a *Person* content type).
2. Go to that bundle's **Manage display** tab — for a content type this is
   **Structure → Content types → *(your type)* → Manage display**
   (`/admin/structure/types/manage/<type>/display`).
3. In the row for your datetime field, set the **Format** to **Age formatter**.
4. Click the settings cog on that row to choose the options, then **Update** and
   **Save**.

### Formatter options

- **Age format** — the display mode:
  - *birthdate* (default) renders `date (Age: NN)`.
  - *birthdate_nolabel* renders `date (NN)`.
  - *age_only* renders just the number `NN`.
- **Append "years" suffix** — on by default; adds a pluralised "year"/"years"
  after the number (so "1 year", "42 years").
- **Date/time format** — a PHP `date()` pattern (e.g. `F j, Y`) used to render the
  accompanying date. This option is hidden automatically when the mode is
  *age_only*, since no date is shown then.
- **Time zone** — the inherited core setting for the time zone used when rendering
  the date.

You can set different options per view mode — for example age-only in a teaser and
date-plus-age in the full view. The formatter also works as a Views field: pick
**Age formatter** on the field's display in a View.
